class PDFConverterCustomTitlePage < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

  def ink_title_page doc

    move_cursor_to page_height * 0.9

    theme_font :title_page_subtitle do
      ink_prose doc.attributes['ministry'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['fullname1'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['fullname2'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['shortname'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['cathedra1'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['cathedra2'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0

    end

    move_cursor_to page_height * 0.5

    doctitle = doc.doctitle partition: ' | '
    theme_font :title_page do
      theme_font :title_page_title do
        ink_prose doctitle.title, align: :center, color: theme.base_font_color, line_height: 1, margin: 0
        ink_prose doc.attributes['subjectfull'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0 if doc.attributes['subject']
        ink_prose doc.attributes['themefull'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
      end
    end

    move_cursor_to page_height * 0.3

    theme_font :title_page_subtitle do
      ink_prose doc.attributes['madeby'], align: :right, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['groupfull'], align: :right, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['author'], align: :right, color: theme.base_font_color, line_height: 1, margin: 0

      ink_prose "", align: :right

      ink_prose doc.attributes['checkedby'], align: :right, color: theme.base_font_color, line_height: 1, margin: 0
      ink_prose doc.attributes['tutorposition'], align: :right, color: theme.base_font_color, line_height: 1, margin: 0 if doc.attributes['tutorposition']
      ink_prose doc.attributes['tutorname'], align: :right, color: theme.base_font_color, line_height: 1, margin: 0


    end


    move_cursor_to page_height * 0.07

    theme_font :title_page_subtitle do
      ink_prose doc.attributes['city'] + " " + doc.attributes['localyear'], align: :center, color: theme.base_font_color, line_height: 1, margin: 0
    end

  end
end
