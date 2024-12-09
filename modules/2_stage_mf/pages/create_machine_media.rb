require 'asciidoctor'
require 'pdf-reader'

# Путь к папке с файлами
directory_path = "modules/2_stage_mf/pages"
# Пути к лог-файлам
log_doc_file_path = "modules/2_stage_mf/pages/tables/t_machine_media_statement.adoc"

# Проверяем, что папка существует
unless Dir.exist?(directory_path)
  puts "Указанная папка не существует: #{directory_path}"
  exit
end

# Открываем лог-файлы для записи
File.open(log_doc_file_path, "w") do |log_doc_file|


# Сканируем папку на наличие файлов .adoc
adoc_files = Dir.glob(File.join(directory_path, "*.adoc"))
      puts "              "
# Обрабатываем каждый .adoc файл
adoc_files.each do |adoc_file|
  begin
    # Загружаем документ AsciiDoc
    doc = Asciidoctor.load_file(adoc_file, safe: :safe)

    # Извлекаем атрибут 'name'
    name_attribute = doc.attr('name1_dokument') || "Атрибут 'name1_dokument' не найден"
    plan_attribute = doc.attr('plan') || "Атрибут 'plan' не найден"

    # Формируем ожидаемое имя PDF файла
    pdf_file = adoc_file.sub(/\.adoc$/, '.pdf')

    if File.exist?(pdf_file)
      # Открываем PDF файл и получаем количество страниц
      reader = PDF::Reader.new(pdf_file)
      total_pages = reader.page_count

      # Выводим результат

      log_doc_file.puts "^|[.table-style-center]\#{counter:t_row}.# | Документ «#{name_attribute}». #{plan_attribute} ^| 1 | Машинописная брошюра. + \n Листов: #{total_pages} "
    else
      puts "Файл PDF для #{File.basename(adoc_file)} не найден."
    end
  rescue => e
    # Обрабатываем ошибки
    puts "Ошибка при обработке файла #{File.basename(adoc_file)}: #{e.message}"
  end
end
end

puts "Атрибуты AsciiDoc файлов записаны в #{log_doc_file_path}"