require "prawn"



Prawn::Document.generate("hello.pdf") do
  text "Hello world!"

end

Prawn::Document.generate("styling_text.pdf") do
  text "Default text styling"
  text "Blue 16pt Helvetica", size: 16, font: "Helvetica", color: "0000FF"
  text "Aligned Center", align: :center

  font_size 12
  font "Courier" do
    text "Size 12 Courier"
    font_size 10 do
      text "Slightly smaller Courier"
    end
  end
  text "Default font size 12"

  font "Helvetica"
  3.times do |i|
    text "Helvetica with leading 10 line #{i}", leading: 10
  end
end

Prawn::Document.generate("moving_around.pdf") do
  text "#A At the top, cursor position #{cursor}"

  move_down 50
  text "#B Down 50, cursor position #{cursor}"

  move_cursor_to bounds.bottom + font_size
  text "#C at the bottom, cursor position #{cursor}"

  move_up 50
  text "#D Up 50 from #C, cursor position #{cursor}"

  move_cursor_to bounds.top / 2
  text "#E In the middle, cursor position #{cursor}"
end

# require 'prawn'
require 'open-uri'

Prawn::Document.generate("image.pdf") do
  text "Dog", align: :center, color: "333333", size: 42
  move_down 20
  text "Homo sapiens' best friend", align: :center, color: "555555", size: 26
  # url = "https://pixabay.com/static/uploads/photo/2014/03/14/20/13/dog-287420_960_720.jpg"
  image "logo.jpg", fit: [500, 500], position: :center
end

# require 'prawn'
require "mini_magick"

Prawn::Fonts::AFM.hide_m17n_warning = true


url = "https://habrastorage.org/getpro/moikrug/uploads/company/100/006/896/8/logo/6fae72f408703e5f85f867e1c8886f7d.png"
filename = "fitted_background.jpg"
image = MiniMagick::Image.open(url)
image.resize "650x950"
image.write filename
background = filename

  Prawn::Document.generate("background.pdf", background: background) do
  font "/Users/vvv/Myrtex/My_first_repository/resources/fonts/times-new-roman-bold-italic.ttf"
  font "/Users/vvv/Myrtex/My_first_repository/resources/fonts/times-new-roman-normal.ttf"
  font "/Users/vvv/Myrtex/My_first_repository/resources/fonts/times-new-roman-italic.ttf"
  font "/Users/vvv/Myrtex/My_first_repository/resources/fonts/times-new-roman-bold.ttf"

  options = { align: :center, valign: :center, leading: 25, color: "C1C1C1"}
  # move_down 50
  font_size 20
  move_cursor_to bounds.bottom + font_size*22
  text "Я люблю МИРТЕХ !", options.merge({ size: 22, align: :center })
  # text "– Tech writers –", options.merge({ size: 18 })

end

Prawn::Document.generate("oruby_cover.pdf") do
  move_down 60

  image "logo.jpg", fit: [500, 400], position: :center

  move_cursor_to bounds.top

  shape_color = "008888"
  font "Times-Roman"

  fill_color shape_color
  fill_rectangle [0, bounds.top], bounds.width, 20

  move_down 25

  fill_color "000000"
  text "Because InDesign is for scrubs", :size => 20, :style => :italic, :align => :center

  bounding_box([0, bounds.top - 50], :width => bounds.width, :height => bounds.height) do
    move_down 380
    text "using", :size => 40, :style => :italic
    move_up 380

    fill_color shape_color
    fill_rectangle [0, 300], 550, 200

    fill_color "FFFFFF"
    move_down 410
    font "Times-Roman"
    text "Prawn", :size => 165, :align => :center

    fill_color "000000"
    font "Helvetica"
    draw_text "O'RUBY", :at => [0, bounds.bottom + 50], :size => 30

    move_to [0, bounds.bottom + 100]
    font "Times-Roman"
    draw_text "Robert Qualls", :at => [bounds.right - 100, bounds.bottom + 50], :size => 20, :style => :italic
  end
end
