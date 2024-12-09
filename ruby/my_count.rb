Asciidoctor::Extensions.register do
  postprocessor do
    process do |doc, output|
      puts doc.attr 'page-count'
      output
    end
  end
end