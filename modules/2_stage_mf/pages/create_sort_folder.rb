require 'fileutils'

# # Исходная и целевая папки
# source_folder = "modules/2_stage_mf/pages"
# target_folder_doc = "modules/2_stage_mf/pages/mf_partners_pur/DOC"
# target_folder_report = "modules/2_stage_mf/pages//mf_partners_reports"

# require 'fileutils'

# Исходная папка, где находятся файлы
source_folder = "modules/2_stage_mf/pages"

# Папки назначения
destination_doc_folder = "modules/2_stage_mf/pages/mf_partners_pur/DOC"
destination_report_folder = "modules/2_stage_mf/pages/mf_partners_reports"

# Создаем папки назначения, если их нет
FileUtils.mkdir_p(destination_doc_folder)
FileUtils.mkdir_p(destination_report_folder)

# Перебираем все файлы в исходной папке
Dir.glob("#{source_folder}/*.pdf").each do |file_path| # Берем только PDF-файлы
  # Проверяем, является ли объект файлом
  next unless File.file?(file_path)
  
  # Извлекаем имя файла
  file_name = File.basename(file_path)
  
  # Проверяем название файла и копируем в нужную папку
  if file_name.downcase.include?("trd")
    new_path = File.join(destination_doc_folder, file_name)
    FileUtils.mv(file_path, new_path)
    puts "Файл #{file_name} перемещен в #{destination_doc_folder}"
  elsif file_name.downcase.include?("report")
    new_path = File.join(destination_report_folder, file_name)
    FileUtils.mv(file_path, new_path)
    puts "Файл #{file_name} перемещен в #{destination_report_folder}"
  else
    puts "Файл #{file_name} не соответствует условиям и не был перемещен"
  end
end

