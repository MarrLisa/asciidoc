require 'fileutils'

# Укажите путь к папке
folder_path = "modules/2_stage_mf/pages"
folder_path2 = "modules/2_stage_mf/pages/mf_partners_pur/DOC"
folder_path3 = "modules/2_stage_mf/pages/mf_partners_reports"

# Перебираем все файлы с расширением .pdf в указанной папке
Dir.glob("#{folder_path}/*.pdf").each do |file_path|
  # Удаляем файл
  FileUtils.rm(file_path)
 
  puts "Удален файл: #{file_path}"
end

Dir.glob("#{folder_path2}/*.pdf").each do |file_path|
  # Удаляем файл
  FileUtils.rm(file_path)
 
  puts "Удален файл: #{file_path}"
end

Dir.glob("#{folder_path3}/*.pdf").each do |file_path|
  # Удаляем файл
  FileUtils.rm(file_path)
 
  puts "Удален файл: #{file_path}"
end


