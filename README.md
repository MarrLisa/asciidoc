<!-- Теперь наш репозиторий называется asciidoc -->

<!-- клонировать новый репозиторий себе -->
git clone https://github.com/myrtex/asciidoc.git

<!-- ввести свои учетные данные которые подавали -->
git config user.name "ваше имя"
git config user.email "ваша почта"

<!-- Остальное потом -->

<!-- Переименовать старый удаленный репозиторий -->
git remote rename origin old-origin
<!-- Подключить новый удаленный репозиторий -->
git remote add origin https://github.com/myrtex/asciidoc.git
<!-- удалить локально старый удаленный репозиторий -->
git remote rm old-origin

<!-- Для работы с большим репозиторием надо увеличить размер буферов передачи командами: -->
git config --global http.postBuffer 524288000
git config --global http.maxRequestBuffer 100M


# My_first_repository
Мой первый репозиторий 

<!-- Для работы с большим репозиторием надо увеличить размер буферов передачи командами: -->

git config --global http.postBuffer 524288000
git config --global http.maxRequestBuffer 100M

# My_first_repository
Мой первый репозиторий 
Для рабочей ветки

Создала ветку rp_1 

Владимир создал ветку vladimir_branch_1 

Для сборки сайта с  Antora, в терминале VSCode ввести команду: npx antora --fetch antora-playbook.yml 

Формирование pdf:

<!-- Новая команда для титульной страницы: -->
asciidoctor-pdf -r ./modules/reusable_content/pages/docs/title_list.rb -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/reusable_content/pages/docs/01_user_guide_chief_grbs.adoc
asciidoctor-pdf -r ./modules/reusable_content/pages/docs/title_list.rb -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/reusable_content/pages/docs/02_user_guide_chief_oo.adoc
asciidoctor-pdf -r ./modules/reusable_content/pages/docs/title_list.rb -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/reusable_content/pages/docs/03_user_guide_chief_us.adoc
asciidoctor-pdf -r ./modules/reusable_content/pages/docs/title_list.rb -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/reusable_content/pages/docs/04_user_guide_chief_pp.adoc

...
<!-- ************************************ -->
asciidoctor-pdf -r ./modules/reusable_content/pages/docs/title_list_attr.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=resources/fonts modules/reusable_content/pages/docs/01_user_guide_chief_grbs.adoc
<!-- ************************************ -->

asciidoctor-pdf -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/reusable_content/pages/docs/user_guide_chief_administrator.adoc

asciidoctor-pdf -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/reusable_content/pages/docs/start_eb.adoc

Файл html из редактируемого файла, в VSCode, формируется автоматчески для удобного просмотра нажатием клавиш option+command+S (при сохранении через меню, файл html не формируется)  

git config user.email 

git config user.name 

git remote -v 

*pdf c Ruby* установить руби праун и др уроки отсюда https://www.sitepoint.com/hackable-pdf-typesetting-in-ruby-with-prawn/ 
<!-- --------- -->
 cd ruby
 ruby hello-prawn.rb

В папке ruby файл 1.adoc и olist.rb + темы получается нормально со всеми списками в пдф
 asciidoctor-pdf -r ./ruby/olist.rb -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts ruby/1.adoc
<!-- --------- -->


Формирование pdf: 

asciidoctor-pdf -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/kd-s/pages/1.adoc 

При большом количестве изображений и увеличении репозитория, можно использовать Git LFS: https://github.com/git-lfs/git-lfs?ysclid=lttya7oazk38216200 подробнее тут https://www.atlassian.com/ru/git/tutorials/git-lfs#what-is-git-lfs 

Аттрибуты
:experimental: yes в начале программы позволяет использовать btn:[Применить] kbd:[ENTER] menu:File[Open] и др.

inline аттрибут image:[имя.png, размер] (с одним двоеточием ! )– позволяет вставлять иконки в тексте (желательно брать наверное с фигмы, составить коллекцию в папке images) или использовать аттрибут :icons: images и задать путь :iconsdir: (по умолчанию если установлен imagedir используется ../images/icons) Для стандартизации и однообразия документации, создать такой набор элементов.

ввела размеры изображений:
:image-size: width=642, height=auto = ПО ГОСТ 170мм
:image-size1: width=450, height=auto = 70 % изображение части экрана
:image-size2: width=320, height=auto изображение маленькой части экрана, элементов

чтобы отрабатывали сайз1 и сайз2 в рисунках надо их так прописывать [{image-size1}]

для центровки рисунка вставила [image-size, align="center"]

Примечания/важно/предусловие в блоке:

====
[%unbreakable, grid=none, frame=none, cols="1,15"]
|===
^.^| image:{iconsdir}warning.png[16,16] |
{select_user}. 
Лист согласования невозможно сохранить, если не выбран утверждающий. 
|===
====

если надо с рисунком
====
[%unbreakable, grid=none, frame=none, cols="1,15"]
|===
^.^| image:{iconsdir}info.png[16,16] |
{agreement_type}, как на <<id_image-g_sa_42, Рисунке {counter:figure-number}>>.
|===

[[id_image-g_sa_42]]
.Рисунок {counter:figure-number}. Тип согласования
image::g_sa_42.png[{image-size1}, align="center"] 
====

иконки в тексте: image:{iconsdir}help.png[width=16,height=16]

иконки в блоках примечания: image:{iconsdir}warning.png[16,16]

Включение/исключение информации в соответствии с ролями:
// Отображение макроса для Главного распорядителя бюджетных средств
ifdef::role1[]
* {but_setting_otb}, без права вносить изменения;
endif::[]
// Отображение макроса для Организатора отборов
ifdef::role2[]
* {but_setting_otb};
* {but_delete};
* {but_copy};
endif::[]

роли 
________
:role1: Главный распорядитель бюджетных средств
:role2: Организатор отбора
:role3: Член конкурсной комиссии
:role4: Валидатор
:role5: Заявитель
:role6: Эксперт
:role2_cz: Организатор отбора соц заказ
:role4_cz: Валидатор соц заказ
_________

иконки для блоков:
Предусловие – control;
Важно! – warning;
Примечание – info.

ссылка внутри файла: 
якорь [[subsidy_rejection]]
ссылка на якорь <<subsidy_rejection, Отклонение субсидии>> 

{nbsp} - пробел, если надо.

Проверка нескольких условий
// Проверка на роль ГРБС
ifdef::role1[]
<<id_image-g_sa_69, Рисунке {counter:figure-number}>>.
[[id_image-g_sa_69]]
.Рисунок {counter:figure-number}. Иконка «Комментарий из ГИИС ЭБ»
image::g_sa_69.png[{image-size1}, align="center"]
endif::[]
// Отображение макроса для Организатора отборов если в документе нет атрибута delete_otb
ifdef::role2[]
ifndef::delete_otb[]
<<id_image-g_oa_13, Рисунке {counter:figure-number}>>.
[[id_image-g_oa_13]]
.Рисунок {counter:figure-number}. Иконка «Комментарий из ГИИС ЭБ»
image::g_oa_13.png[{image-size1}, align="center"]
endif::[]
// Отображение макроса для Организатора отборов для раздела Отмена отбора где есть атрибут delete_otb
ifdef::delete_otb[]
<<id_image-g_do_7, Рисунке {counter:figure-number}>>.
[[id_image-g_do_7]]
.Рисунок {counter:figure-number}. Иконка «Комментарий из ГИИС ЭБ»
image::g_do_7.png[{image-size1}, align="center"]
endif::[]
endif::[]


Для ссылки на иные доки xref:subsidy.adoc#reestr_subsidy[xrefstyle=full]


Переиспользование одних и тех же файлов в одном документе в разных местах на каждый файл в которых есть якоря рисунков

ifdef::n456[]
:n457:
Перейти в раздел «Субсидии (операторы)» можно через административную панель «Рабочая панель». 
Для этого нужно выбрать пункт «Рабочая панель» (1) во всплывающем меню, либо воспользоваться боковым меню на странице «Мой профиль» и выбрать пункт «Рабочая панель» (2), как на <<n457, Рисунке {counter:figure-number}>>.

[[n457]]
.Рисунок {counter:figure-number}. Пункт меню «Рабочая панель»
image::g_s_2.png[{image-size}, align="center"]
endif::n456[]

ifndef::n456[]
:n456:
Перейти в раздел «Субсидии (операторы)» можно через административную панель «Рабочая панель». 
Для этого нужно выбрать пункт «Рабочая панель» (1) во всплывающем меню, либо воспользоваться боковым меню на странице «Мой профиль» и выбрать пункт «Рабочая панель» (2), как на <<n456, Рисунке {counter:figure-number}>>.

[[n456]]
.Рисунок {counter:figure-number}. Пункт меню «Рабочая панель»
image::g_s_2.png[{image-size}, align="center"]
endif::n456[]


// *lisa* //
asciidoctor-pdf -a pdf-theme=report -a pdf-themesdir=resources/themes -a pdf-fontsdir=resources/fonts modules/lisa_test/test.adoc
// *lisa* //

//**********************************
// Команда для ветки 2 stage MF//

title_list_attr.rb применяется для всех файлов в зависимости от ключа в файле ramka = 0 или 1
этот файл автоматически распознает портретный и альбомный лист и всё считает
файл theme.yml то же один отступы для портретный и альбомный лист задаются:

margin: [10mm, 8mm, 24mm, 25mm]
margin-rotated: [25mm, 8mm, 24mm, 8mm]

используем для всех:
report-theme.yml
convert_ascii_to_pdf.rb

// Для доков все в имени doc 
asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/*doc*.adoc 

или для отчетов 
asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/*report*.adoc 

или для всех ДЕЛАТЬ ЭТОТ ВАРИАНТ!!!
asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/*.adoc

После конвертации всех файлов можно запустить файл create_cover_sheet.rb для вывода Лист сопроводительный в виде таблиц asciidoc в файлы t_cover_sheet_doc.adoc и t_cover_sheet_report.adoc. Папка задается в файле create_cover_sheet.rb (modules/2_stage_mf/pages/) команда (путь до файла): ruby modules/2_stage_mf/pages/create_cover_sheet.rb – только название и страницы 

В терминале: ruby modules/2_stage_mf/pages/create_machine_media.rb Выводит готовую страницу для ведомости машинных носителей в файл t_machine_media_statement.adoc 

delete_pdf.rb удаляет все пдф в папке ruby modules/2_stage_mf/pages/delete_pdf.rb



create_sort_folder.rb создает папки :
1. destination_doc_folder = "modules/2_stage_mf/pages/mf_partners_pur/DOC"
2. destination_report_folder = "modules/2_stage_mf/pages/mf_partners_reports"

И копирует туда файлы соответственно имеющие в названии trd или report.
Далее можно делать файлы и папки относящиеся к ED PMI и т.п.
<!-- ************************** -->

Итого:
После радактирования файлов:

1. Запустить команду: asciidoctor-pdf -r ./modules/2_stage_mf/pages/convert_ascii_to_pdf.rb -a pdf-theme=report -a pdf-themesdir=modules/2_stage_mf/resources/themes -a pdf-fontsdir=modules/2_stage_mf/resources/fonts modules/2_stage_mf/pages/*.adoc
Она сконвертирует все файлы adoc в pdf.
2. Запустить поочередно  
    - ruby modules/2_stage_mf/pages/create_machine_media.rb (ведомость маш носителей)
    - ruby modules/2_stage_mf/pages/create_cover_sheet.rb (сопровод лист), 
3. Повторить шаги 1-2    
4. Проверить кол-во листов ведомости маш носителей в пдф соответствует ли. 
5. Запустить  ruby modules/2_stage_mf/pages/create_sort_folder.rb которая переместит  пдф файлы в нужные папки кроме сопроводит листа:
    <!--  
    # Исходная папка, где находятся файлы
    source_folder = "modules/2_stage_mf/pages"
    # Папки назначения
    destination_doc_folder = "modules/2_stage_mf/pages/mf_partners_pur/DOC"
    destination_report_folder = "modules/2_stage_mf/pages/mf_partners_reports"
    -->
    команда (не создает лишних копий типа (1) или копия, команда ср переписывает файлы).

Можно скопировать и ввести в терминал все след команды :
<!--  -->
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
<!--  -->
Они последовательно выполнятся и будет готовый комплект

Или добавил в проект файл start.rb:
<!--  -->#!/usr/bin/env ruby

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
<!--  -->

Далее выполнить в терминале:

chmod +x modules/2_stage_mf/pages/start.rb 

./modules/2_stage_mf/pages/start.rb   
эта команда выполнит всё то же самое + вначале удалит все пдф файлы если они есть


5. При необходимости очистить рабочую папку и финальные mf.... от всех пдф файлов: ruby modules/2_stage_mf/pages/delete_pdf.rb
6. Продолжить работу при необходимости.
<!-- ************************** -->


:num_t: {counter:table-number}
Модуль включает в себя следующие функциональные уровни и компоненты, приведенные в <<id_t_{num_t}, Таблице {num_t}>>.
[%unbreakable]
[#id_t_{num_t}]
.Таблица {num_t}. Функциональные уровни и компоненты 
include::../tables/tables.adoc[tag=table_func_level]


:num_i: {counter:figure-number}
Модуль включает в себя следующие функциональные уровни и компоненты, приведенные в <<id_t_{num_i}, hbceyrt {num_i}>>.
[%unbreakable]
[#id_t_{num_i}]
.Таблица {num_i}. Функциональные уровни и компоненты 
include::../images/image.png[]
