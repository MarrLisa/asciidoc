require "prawn"

Prawn::Document.generate("document.pdf", :page_layout => :portrait) do
    start_new_page
    start_new_page
    

    # Footer
    repeat :all do
        bounding_box [bounds.left, bounds.bottom+30], :width  => bounds.width, :height => 30 do
        end
    end

    # Paging
    string = "<page> / <total>"
    options = { :at => [bounds.right - 265, 115],
                    :width => 150,
                    :align => :right,
                    :size => 8,
                    :start_count_at => 1}
    number_pages string, options
end