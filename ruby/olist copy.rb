
require 'prawn'
require "mini_magick"


require 'asciidoctor/extensions'
require 'text/hyphen'

include ::Asciidoctor

HyphenatorGerman = Text::Hyphen.new(:language => "ru")

# ignore entities and things in pointy brackets
SegmentPcdataRx = /(?:(&[a-z]+;|<[^>]+>)|([^&<]+))/

def hyphenate string
  words = string.split(/[^[[:word:]]]+/).uniq
  if (words) then
    words.each do |word|
      hyphenatedWord = HyphenatorGerman.visualize word, '&#173;'
      string = string.gsub word, hyphenatedWord
    end
  end
  return string
end

module HyphenationExtension
  def content
    content = super
    case @content_model
      when :simple
        content.gsub(SegmentPcdataRx) { $2 ? (hyphenate $2) : $1 }
      else
        content
    end
  end

  def text
    content = super
    content.gsub(SegmentPcdataRx) { $2 ? (hyphenate $2) : $1 }
  end
end

class Asciidoctor::Block
  prepend HyphenationExtension
end
class Asciidoctor::ListItem
  prepend HyphenationExtension
end
class Asciidoctor::Table::Cell
  prepend HyphenationExtension
end


class PDFConverterCustomTitlePage < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

# Prawn::Fonts::AFM.hide_m17n_warning = true

# url = "https://s1.1zoom.ru/big3/651/Stars_Nebulae_in_space_Sh2-264_524137_2689x1752.jpg"
# filename = "fitted_background.jpg"
# image = MiniMagick::Image.open(url)
# image.resize "650x950"
# image.write filename
# background = filename

#   Prawn::Document.generate("background.pdf", background: background) do
#   font "/Users/vvv/myruby/resources/fonts/times-new-roman-bold-italic.ttf"
#   font "/Users/vvv/myruby/resources/fonts/times-new-roman-normal.ttf"
#   font "/Users/vvv/myruby/resources/fonts/times-new-roman-italic.ttf"
#   font "/Users/vvv/myruby/resources/fonts/times-new-roman-bold.ttf"

#   options = { align: :center, valign: :center, leading: 25, color: "ff144b"}

#   font_size 20
#   move_cursor_to bounds.bottom + font_size * 42
#   text " Космос !", options.merge({ size: 22, align: :center })
#   options = { align: :center, valign: :center, leading: 25, color: "0000ff"}
#   font_size 20
#   move_cursor_to bounds.bottom + font_size * 38
#   text " Поехали !", options.merge({ size: 22, align: :center })
# end generate("background.pdf", background: background) do


  def ink_title_page doc

    url = "https://s1.1zoom.ru/big3/651/Stars_Nebulae_in_space_Sh2-264_524137_2689x1752.jpg"
    filename = "fitted_background.jpg"
    image = MiniMagick::Image.open(url)
    image.resize "650x950"
    image.write filename
    background = filename

    move_cursor_to page_height * 0.9
    image filename, position: :center, scale: 0.75

    move_cursor_to page_height * 0.92

    theme_font :title_page_subtitle do
      ink_prose doc.attributes['name-prog'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      options = { align: :center, valign: :center, leading: 25, color: "ff144b"}

        font_size 45
        move_cursor_to bounds.bottom + font_size * 22
        text " Космос !", options.merge({ size: 30, align: :center })
        options = { align: :center, valign: :center, leading: 25, color: "0000ff"}
        font_size 45
        move_cursor_to bounds.bottom + font_size * 27
        text " Поехали !", options.merge({ size: 30, align: :center })
    end

  end
end





class CustomPDFConverter < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'


  def init_pdf doc
    @parents = []
    super
  end

  def convert_olist node
    add_dest_for_block node if node.id

    case node.style
    when 'arabic'
      list_numeral = 1
    when 'decimal'
      list_numeral = '01'
    # тут поменял
    when 'loweralpha'
      list_numeral = '–'
    when 'upperalpha'
      list_numeral = '–'
# и тут
    when 'lowerroman'
      list_numeral = '–'
    when 'upperroman'
      list_numeral = '–'
    when 'lowergreek'
      list_numeral = LowercaseGreekA
    when 'unstyled', 'unnumbered', 'no-bullet'
      list_numeral = nil
    when 'none'
      list_numeral = ''
    else
      list_numeral = 1
    end
    # if !list_numeral.nil_or_empty? && (start = (node.attr 'start') || ((node.option? 'reversed') ? node.items.size : nil))
    #   if (start = start.to_i) > 1
    #     (start - 1).times { list_numeral = list_numeral.next }
    #   elsif start < 1 && !(::String === list_numeral)
    #     (start - 1).abs.times { list_numeral = list_numeral.pred }
    #   end
    # end

    @list_numerals << list_numeral
    convert_list node
    @list_numerals.pop
  end


  def convert_list_item node, list, opts = {}
  # TODO: move this to a draw_bullet (or draw_marker) method
  marker_style = {}
  marker_style[:font_color] = @theme.list_marker_font_color || @font_color
  marker_style[:font_family] = font_family
  marker_style[:font_size] = font_size
  marker_style[:line_height] = @base_line_height
  case (list_type = list.context)
  when :dlist
    # NOTE: list.style is always 'qanda'
    junction = node[1]
    @list_numerals << (index = @list_numerals.pop).next
    marker = %(#{index}.)
  when :olist
    junction = node
    if (index = @list_numerals.pop)
      if index == ''
         marker = ''
          else
              if index == '–'
                marker = node.parent.style == 'decimal' && index.abs < 10 ? %(#{index < 0 ? '-' : ''}0#{index.abs}.) : %(#{index})
                index = ?\u2012
              else
                marker = node.parent.style == 'decimal' && index.abs < 10 ? %(#{index < 0 ? '-' : ''}0#{index.abs}.) : %(#{index})')'
              end
              dir = (node.parent.option? 'reversed') ? :pred : :next

          @list_numerals << (index.public_send dir)
          [:font_color, :font_family, :font_size, :font_style, :line_height].each do |prop|
          marker_style[prop] = @theme[%(olist_marker_#{prop})] || marker_style[prop]
          end
      end
    end
  else # :ulist
    junction = node
    if (marker_type = @list_bullets[-1])
      if marker_type == :checkbox
        # QUESTION: should we remove marker indent if not a checkbox?
        if node.attr? 'checkbox'
          marker_type = (node.attr? 'checked') ? :checked : :unchecked
          marker = @theme[%(ulist_marker_#{marker_type}_content)] || BallotBox[marker_type]
        end
      else
        marker = '–'
        # marker = @theme[%(ulist_marker_#{marker_type}_content)] || Bullets[marker_type]
      end
      [:font_color, :font_family, :font_size, :font_style, :line_height].each do |prop|
        marker_style[prop] = @theme[%(ulist_marker_#{marker_type}_#{prop})] || @theme[%(ulist_marker_#{prop})] || marker_style[prop]
      end if marker
    end
  end

  if marker
    if marker_style[:font_family] == 'fa'
      log :info, 'deprecated fa icon set found in theme; use fas, far, or fab instead'
      marker_style[:font_family] = FontAwesomeIconSets.find {|candidate| (icon_font_data candidate).yaml[candidate].value? marker } || 'fas'
    end
    marker_style[:font_style] &&= marker_style[:font_style].to_sym
    marker_gap = rendered_width_of_char 'x'
    font marker_style[:font_family], size: marker_style[:font_size], style: marker_style[:font_style] do
      marker_width = rendered_width_of_string marker
      # NOTE: compensate if character_spacing is not applied to first character
      # see https://github.com/prawnpdf/prawn/commit/c61c5d48841910aa11b9e3d6f0e01b68ce435329
      character_spacing_correction = 0
      character_spacing(-0.5) do
        character_spacing_correction = 0.5 if (rendered_width_of_char 'x', character_spacing: -0.5) == marker_gap
      end
      marker_height = height_of_typeset_text marker, line_height: marker_style[:line_height], single_line: true
      start_position = bounds.left - marker_width - marker_gap + character_spacing_correction
      float do
        advance_page if @media == 'prepress' && cursor < marker_height
        flow_bounding_box position: start_position, width: marker_width do
          ink_prose marker,
            align: :right,
            character_spacing: -0.5,
            color: marker_style[:font_color],
            inline_format: false,
            line_height: marker_style[:line_height],
            style: marker_style[:font_style],
            margin: 0,
            normalize: false,
            single_line: true
        end
      end
    end
  end

  opts = opts.merge margin_bottom: 0, normalize_line_height: true
  if junction
    if junction.compound?
      opts.delete :margin_bottom
    elsif next_enclosed_block junction, descend: true
      opts[:margin_bottom] = @theme.list_item_spacing
    end
  end
  traverse_list_item node, list_type, opts
end

end
