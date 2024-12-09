class PDFConverterCustomTitlePage < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

  def ink_title_page doc

    move_cursor_to page_height * 0.6
    theme_font :title_page_title do
      ink_prose doc.attributes['name2_dokument'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    end

    move_cursor_to page_height * 0.5
    theme_font :title_page_subtitle do
      ink_prose doc.attributes['name1_dokument'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    end

    move_cursor_to page_height * 0.05
    theme_font :title_page_city do
      ink_prose 'Листов '+ doc.attributes['page_all'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      move_cursor_to page_height * 0.02
      ink_prose doc.attributes['city'] + " " + doc.attributes['localyear'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    end

  end


end
