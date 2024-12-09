require 'asciidoctor'

# Папка с AsciiDoc файлами
source_folder = "modules/2_stage_mf/pages"

# Пути к лог-файлам
log_doc_file_path = "modules/2_stage_mf/pages/tables/t_cover_sheet_doc.adoc"
log_report_file_path = "modules/2_stage_mf/pages/tables/t_cover_sheet_report.adoc"

# Открываем лог-файлы для записи
File.open(log_doc_file_path, "w") do |log_doc_file|
  File.open(log_report_file_path, "w") do |log_report_file|
    # Перебираем все .adoc файлы в папке
    Dir.glob("#{source_folder}/*.adoc").each do |adoc_file|
    # извлекаем имя файла без расширения
    file_name = File.basename(adoc_file, File.extname(adoc_file))
      pdf_file_path = File.join(source_folder, "#{file_name}.pdf") # Имя одноимённого PDF-файла

      # Загружаем файл с помощью Asciidoctor
      begin
        doc = Asciidoctor.load_file(adoc_file, safe: :safe)

        # Извлекаем атрибуты
        name_attribute = doc.attr('name1_dokument') || "Атрибут 'name1_dokument' не найден"
        plan_attribute = doc.attr('plan') || "Атрибут 'plan' не найден"
        
        if plan_attribute.include?("задание")
          plan_attribute = plan_attribute + ''
        else 
          plan_attribute = plan_attribute + ''
        end

        if File.exist?(pdf_file_path)
          begin
            reader = PDF::Reader.new(pdf_file_path)
            pdf_page_count = reader.page_count
            pdf_file_status = "PDF найден: #{File.basename(pdf_file_path)}, Количество страниц: #{pdf_page_count}"
          rescue => e
            pdf_file_status = "PDF найден: #{File.basename(pdf_file_path)}, но количество страниц не удалось определить (Ошибка: #{e.message})"
          end
        else
          pdf_file_status = "PDF отсутствует"
        end

        # Определяем, в какой файл записывать атрибуты
        if file_name.include?("trd")
          # log_doc_file.puts "|  ^|[.table-style-center]\#{counter:t_row}.# | Документ «#{name_attribute}». #{plan_attribute} | #{File.basename(pdf_file)}  "
          log_doc_file.puts "|  ^|[.table-style-center]\#{counter:t_row}.# | Документ «#{name_attribute}». #{plan_attribute}  | #{File.basename(pdf_file_path)}  "

        elsif file_name.include?("report")
          log_report_file.puts "|  ^|[.table-style-center]\#{counter:t_row}.# | Документ «#{name_attribute}». #{plan_attribute}  | #{File.basename(pdf_file_path)}  "
        else
          # Если имя не содержит "doc" или "plan", можно обработать иначе
          puts "Файл #{file_name} не соответствует ни 'doc', ни 'report'. Пропущен."
        end
      rescue => e
        puts "Ошибка обработки файла #{file_name}: #{e.message}"
      end
    end
  end
end

puts "Атрибуты AsciiDoc файлов записаны в #{log_doc_file_path} и #{log_report_file_path}"


