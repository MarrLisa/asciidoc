class PDFConverterCustomTitlePage < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

  def ink_title_page doc

    image "modules/reusable_content/pages/images/title.png", # путь к файлу изображения
        :at => [-80, 800],  # координаты (опционально)
        :width => 620,      # ширина (опционально)
        :height => 877      # высота (опционально)

    # move_cursor_to page_height * 0.6
    # theme_font :title_page_title do
    #   ink_prose doc.attributes['name2_dokument'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    # end

    # move_down 10
    # theme_font :title_page_subtitle do
    #   ink_prose doc.attributes['name3_dokument'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    # end

    # move_down 15
    # theme_font :title_page_subtitle do
    #   ink_prose doc.attributes['name1_dokument'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    # end

    # move_cursor_to page_height * 0.05
    # theme_font :title_page_city do
    #   ink_prose 'Листов '+ doc.attributes['page_all'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    #   move_down 10
    #   ink_prose doc.attributes['city'] + " " + doc.attributes['localyear'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    # end
  end
end

class PDFConverterWithFullPageBorder < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

  def initialize(document, options = {})
    super
    @is_title_page = true  # Флаг для титульной страницы
  end

  # Переопределяем метод для добавления новой страницы
  def start_new_page(options = {})
    super(options)  # Создаем новую страницу

    # Рисуем рамку только если это не титульная страница
    unless @is_title_page
      draw_full_page_border
    end

    @is_title_page = false  # Сбрасываем флаг после титульной страницы
  end

  # Метод для рисования рамки вокруг всей страницы
  def draw_full_page_border
    # Используем canvas для получения доступа к Prawn-контексту
    canvas do
      line_width(2)                # Устанавливаем толщину линии
      stroke_color '000000'         # Черный цвет для рамки

      # Получаем размеры страницы
      page_width = page.dimensions[2]  # Ширина страницы
      page_height = page.dimensions[3] # Высота страницы

      # Рисуем прямоугольник от верхнего левого угла до нижнего правого
      stroke_rectangle [10, page_height-10], page_width-20, page_height-20
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
# здесь меняем маркеры списков
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
    if !list_numeral.nil_or_empty? && (start = (node.attr 'start') || ((node.option? 'reversed') ? node.items.size : nil))
      if (start = start.to_i) > 1
        (start - 1).times { list_numeral = list_numeral.next }
      elsif start < 1 && !(::String === list_numeral)
        (start - 1).abs.times { list_numeral = list_numeral.pred }
      end
    end

    @list_numerals << list_numeral
    convert_list node
    @list_numerals.pop
  end


  def convert_ulist node
    add_dest_for_block node if node.id
    # TODO: move bullet_type to method on List (or helper method)
    if node.option? 'checklist'
      @list_bullets << :checkbox
    else
      if (style = node.style)
        case style
        when 'bibliography'
          bullet_type = :square
        when 'unstyled', 'no-bullet'
          bullet_type = nil
        else
          if Bullets.key? (candidate = style.to_sym)
            bullet_type = candidate
          else
            log :warn, %(unknown unordered list style: #{candidate})
            bullet_type = :disc
          end
        end
      else
        case node.list_level
        when 1
          bullet_type = :disc
        when 2
          bullet_type = :circle
        else
          bullet_type = :square
        end
      end
      @list_bullets << bullet_type
    end
    convert_list node
    @list_bullets.pop
  end

  def convert_list node
    # TODO: check if we're within one line of the bottom of the page
    # and advance to the next page if so (similar to logic for section titles)
    ink_caption node, category: :list, labeled: false if node.title?

    opts = {}
    if (text_align = resolve_text_align_from_role node.roles)
      opts[:align] = text_align
    elsif node.style == 'bibliography'
      opts[:align] = :left
    elsif (text_align = @theme.list_text_align&.to_sym) # rubocop:disable Lint/DuplicateBranch
      # NOTE: theme setting only affects alignment of list text (not nested blocks)
      opts[:align] = text_align
    end

    line_metrics = calc_line_metrics @base_line_height
    #complex = false
    # ...or if we want to give all items in the list the same treatment
    #complex = node.items.any(&:compound?)
    if (node.context == :ulist && !@list_bullets[-1]) || (node.context == :olist && !@list_numerals[-1])
      if node.style == 'unstyled'
        # unstyled takes away all indentation
        list_indent = 0
      elsif (list_indent = @theme.list_indent) > 0
        # no-bullet aligns text with left-hand side of bullet position (as though there's no bullet)
        list_indent = [list_indent - (rendered_width_of_string %(#{node.context == :ulist ? ?\u2022 : '1.'}x)), 0].max
      end
    else
      list_indent = @theme.list_indent
    end
    indent list_indent do
      node.items.each do |item|
        allocate_space_for_list_item line_metrics
        convert_list_item item, node, opts
      end
    end
    theme_margin :prose, :bottom, (next_enclosed_block node) unless node.nested?
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
                  # здесь индекс символа - тире уменьшаем на 1 в коде он \u2013
                  index = ?\u2012
                else
                  # здесь к нумерованному списку добавляем ) скобку
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


  def convert_list node
    # TODO: check if we're within one line of the bottom of the page
    # and advance to the next page if so (similar to logic for section titles)
    ink_caption node, category: :list, labeled: false if node.title?

    opts = {}
    if (text_align = resolve_text_align_from_role node.roles)
      opts[:align] = text_align
    elsif node.style == 'bibliography'
      opts[:align] = :left
    elsif (text_align = @theme.list_text_align&.to_sym) # rubocop:disable Lint/DuplicateBranch
      # NOTE: theme setting only affects alignment of list text (not nested blocks)
      opts[:align] = text_align
    end

    line_metrics = calc_line_metrics @base_line_height
    #complex = false
    # ...or if we want to give all items in the list the same treatment
    #complex = node.items.any(&:compound?)
    if (node.context == :ulist && !@list_bullets[1]) || (node.context == :olist && !@list_numerals[1])
      if node.style == 'unstyled'
        # unstyled takes away all indentation
        list_indent = 0
      elsif (list_indent = @theme.list_indent) > 0
        # no-bullet aligns text with left-hand side of bullet position (as though there's no bullet)
        # list_indent = [list_indent - (rendered_width_of_string %(#{node.context == :ulist ? ?\u2022 : '1.'}x)), 0].max
        list_indent = list_indent
      end
    else
      # list_indent = @theme.list_indent
      list_indent = 16
    end
    indent list_indent do
      node.items.each do |item|
        allocate_space_for_list_item line_metrics
        convert_list_item item, node, opts
      end
    end
    theme_margin :prose, :bottom, (next_enclosed_block node) unless node.nested?
  end

end

