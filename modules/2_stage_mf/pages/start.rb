#!/usr/bin/env ruby

# Список команд для выполнения
commands = [
'ruby modules/2_stage_mf/pages/delete_pdf.rb',
'asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/*.adoc',
'ruby modules/2_stage_mf/pages/create_cover_sheet.rb',
'asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/Сопроводительный_лист.adoc',
'ruby modules/2_stage_mf/pages/create_list_application.rb',
'asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/Отчет_о_рез_вып_работ_report.adoc',
'ruby modules/2_stage_mf/pages/create_machine_media.rb',
'asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/Ведомость_машинных_носителей_report.adoc',
'ruby modules/2_stage_mf/pages/create_machine_media.rb',
'asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/Ведомость_машинных_носителей_report.adoc',
'ruby modules/2_stage_mf/pages/create_sort_folder.rb'
]

# Выполнение каждой команды
commands.each do |command|
  puts "Выполняется команда: #{command}"
  system(command) # Выполняет команду в терминале
  puts "\n" # Добавляем пустую строку для читаемости
end

puts "Все команды выполнены."
