﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
	#Область ОбработчикиСобытий
	
	Процедура ПриКомпоновкеРезультата(ДокументРезультат, ДанныеРасшифровки, СтандартнаяОбработка)
		
		ИнициализироватьОтчет();
		
		СтандартнаяОбработка = Ложь;
		
		НастройкиОтчета = ЭтотОбъект.КомпоновщикНастроек.ПолучитьНастройки();				   
		
		ДокументРезультат.Очистить();
		КлючВарианта = "СписокДляСверкиСВоенкоматом";
		// Параметры документа
		ДокументРезультат.ТолькоПросмотр = Истина;
		ДокументРезультат.КлючПараметровПечати = "ПАРАМЕТРЫ_ПЕЧАТИ_СписокДляСверкиСВоенкоматом";
		ДокументРезультат.ОриентацияСтраницы = ОриентацияСтраницы.Портрет;
		
		ДатаОтчета = '00010101';
		
		УстановитьДатуОтчета(НастройкиОтчета, ДатаОтчета);
		
		ДанныеОтчета = Новый ДеревоЗначений;
		
		КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;
		МакетКомпоновки = КомпоновщикМакета.Выполнить(ЭтотОбъект.СхемаКомпоновкиДанных, НастройкиОтчета, ДанныеРасшифровки,, Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
		
		// Создадим и инициализируем процессор компоновки.
		ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
		ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, , ДанныеРасшифровки, Истина);
		
		ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
		ПроцессорВывода.УстановитьОбъект(ДанныеОтчета);
		
		// Обозначим начало вывода
		ПроцессорВывода.Вывести(ПроцессорКомпоновки, Истина);
		
		ВывестиМакетСписокДляСверкиСВоенкоматом(ДокументРезультат, ДанныеОтчета, ДатаОтчета);
		
		ДопСвойства = КомпоновщикНастроек.ПользовательскиеНастройки.ДополнительныеСвойства;
		ДопСвойства.Вставить("ОтчетПустой", ДанныеОтчета.Строки.Количество() = 0);
		
		
	КонецПроцедуры
	
	#КонецОбласти
	
	
	#Область СлужебныеПроцедурыИФункции
	
	Процедура ИнициализироватьОтчет() Экспорт
		
		ЗарплатаКадрыОбщиеНаборыДанных.ЗаполнитьОбщиеИсточникиДанныхОтчета(ЭтотОбъект);
		
	КонецПроцедуры
	
	// Для общей формы "Форма отчета" подсистемы "Варианты отчетов".
	Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
		
		Настройки.События.ПриСозданииНаСервере = Истина;
		
	КонецПроцедуры
	
	// Вызывается в обработчике одноименного события формы отчета после выполнения кода формы.
	//
	// Параметры:
	//   Форма - УправляемаяФорма - Форма отчета.
	//   Отказ - Передается из параметров обработчика "как есть".
	//   СтандартнаяОбработка - Передается из параметров обработчика "как есть".
	//
	// См. также:
	//   "УправляемаяФорма.ПриСозданииНаСервере" в синтакс-помощнике.
	//
	Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
		
		ИнициализироватьОтчет();
		ЗначениеВДанныеФормы(ЭтотОбъект, Форма.Отчет);
		
	КонецПроцедуры
	
		
	////////////////////////////////////////////////////////////////////////////////
	// Функции формирования отчета по макету СписокДляСверкиСВоенкоматом.
	
	Процедура ВывестиМакетСписокДляСверкиСВоенкоматом(ДокументРезультат, ДанныеОтчета, ДатаОтчета)
		
		ДокументРезультат.ОриентацияСтраницы = ОриентацияСтраницы.Ландшафт;
		
		Макет = ?(ДатаОтчета < '20170801',
		УправлениеПечатью.МакетПечатнойФормы("Отчет.ВоинскийУчетОбщий.ПФ_MXL_СписокДляСверкиСВоенкоматом"),
		УправлениеПечатью.МакетПечатнойФормы("Отчет.ВоинскийУчетОбщий.ПФ_MXL_СписокДляСверкиСВоенкоматом2017"));
		
		Военкомат 		= Макет.ПолучитьОбласть("Военкомат");
		ПустаяСтрока  	= Макет.ПолучитьОбласть("ПустаяСтрока");
		АдресВоенкомата = Макет.ПолучитьОбласть("АдресВоенкомата");
		Заголовок 		= Макет.ПолучитьОбласть("Заголовок");
		Шапка 			= Макет.ПолучитьОбласть("Шапка");
		СтрокаТаблицы 	= Макет.ПолучитьОбласть("СтрокаТаблицы");
		Подвал 			= Макет.ПолучитьОбласть("Подвал");
		
		ВыводимыеОбласти = Новый Массив;
		ВыводимыеОбласти.Добавить(СтрокаТаблицы);
		ВыводимыеОбласти.Добавить(Подвал);
		
		Запрос = Новый Запрос;
		Запрос.Текст = "ВЫБРАТЬ
		               |	РодственникиФизическихЛиц.СтепеньРодства КАК СтепеньРодства,
		               |	РодственникиФизическихЛиц.Наименование КАК Наименование,
		               |	РодственникиФизическихЛиц.ДатаРождения КАК ДатаРождения,
		               |	РодственникиФизическихЛиц.Владелец КАК ФизическоеЛицо
		               |ИЗ
		               |	Справочник.РодственникиФизическихЛиц КАК РодственникиФизическихЛиц
		               |;
		               |
		               |////////////////////////////////////////////////////////////////////////////////
		               |ВЫБРАТЬ
		               |	ОбразованиеФизическихЛиц.Владелец КАК ФизическоеЛицо,
		               |	ОбразованиеФизическихЛиц.ВидОбразования КАК ВидОбразования,
		               |	ОбразованиеФизическихЛиц.УчебноеЗаведение КАК УчебноеЗаведение,
		               |	ОбразованиеФизическихЛиц.Специальность КАК Специальность,
		               |	ОбразованиеФизическихЛиц.ВидДокумента КАК ВидДокумента,
		               |	ОбразованиеФизическихЛиц.Серия КАК Серия,
		               |	ОбразованиеФизическихЛиц.Номер КАК Номер,
		               |	ОбразованиеФизическихЛиц.ДатаВыдачи КАК ДатаВыдачи,
		               |	ОбразованиеФизическихЛиц.Начало КАК Начало,
		               |	ОбразованиеФизическихЛиц.Окончание КАК Окончание,
		               |	ОбразованиеФизическихЛиц.Квалификация КАК Квалификация
		               |ИЗ
		               |	Справочник.ОбразованиеФизическихЛиц КАК ОбразованиеФизическихЛиц";
		
		РезультатыЗапроса = Запрос.ВыполнитьПакет();
		
		ВыборкаРодственники = РезультатыЗапроса[0].Выбрать();
		ВыборкаОбразования = РезультатыЗапроса[1].Выбрать();
		
		
		Для Каждого ДанныеОрганизации Из ДанныеОтчета.Строки Цикл
			
			Если ДокументРезультат.ВысотаТаблицы > 0 Тогда
				ДокументРезультат.ВывестиГоризонтальныйРазделительСтраниц();
			КонецЕсли;
			
			ПараметрыЗаголовка = ПараметрыЗаголовкаСтруктура(ДатаОтчета, ДанныеОрганизации.Организация, ДанныеОрганизации.Военкомат);
			
			ЗаполнитьЗначенияСвойств(Военкомат.Параметры, ДанныеОрганизации);
			ЗаполнитьЗначенияСвойств(АдресВоенкомата.Параметры, ДанныеОрганизации);
			ЗаполнитьЗначенияСвойств(Заголовок.Параметры, ПараметрыЗаголовка);
			ЗаполнитьЗначенияСвойств(Подвал.Параметры, ПараметрыЗаголовка);
			
			ДокументРезультат.Вывести(Военкомат);
			
			Если ЗначениеЗаполнено(ДанныеОрганизации.ВоенкоматАдрес) Тогда 
				ДокументРезультат.Вывести(АдресВоенкомата);
			Иначе 
				ДокументРезультат.Вывести(ПустаяСтрока);
			КонецЕсли;
			
			ДокументРезультат.Вывести(Заголовок);
			ДокументРезультат.Вывести(Шапка);
			
			КоличествоСтрок = ДанныеОрганизации.Строки.Количество();
			
			Для Каждого ТекСтрока Из ДанныеОрганизации.Строки Цикл 
				
				Если ТекСтрока.СистемныеПоляНомерПоПорядкуВГруппировке < КоличествоСтрок 
					И Не ОбщегоНазначения.ПроверитьВыводТабличногоДокумента(ДокументРезультат, СтрокаТаблицы) Тогда
					ДокументРезультат.ВывестиГоризонтальныйРазделительСтраниц();
				ИначеЕсли ТекСтрока.СистемныеПоляНомерПоПорядкуВГруппировке = КоличествоСтрок
					И Не ОбщегоНазначения.ПроверитьВыводТабличногоДокумента(ДокументРезультат, ВыводимыеОбласти) Тогда
					ДокументРезультат.ВывестиГоризонтальныйРазделительСтраниц();
				КонецЕсли;
				СтруктураПоиска = Новый Структура("ФизическоеЛицо", ТекСтрока.ФизическоеЛицо); 
				ВидОбразования = "";
				Пока ВыборкаОбразования.НайтиСледующий(СтруктураПоиска) Цикл
				
					СтрокаВидОбразования = Строка(ВыборкаОбразования.ВидОбразования) + ", " +
											Строка(ВыборкаОбразования.УчебноеЗаведение) + ", " +
											"Год окончания: " + Год(ВыборкаОбразования.Окончание) + ", " +
											"Специальность: " + Строка(ВыборкаОбразования.Специальность) + ", " +
											Строка(ВыборкаОбразования.ВидДокумента) + " " + Строка(ВыборкаОбразования.Серия) + " " + Строка(ВыборкаОбразования.Номер) + " Выдан: " + Формат(ВыборкаОбразования.ДатаВыдачи, "ДФ=dd.MM.yyyy");
											
					ВидОбразования = ВидОбразования + СтрокаВидОбразования + Символы.ПС;
				                                             
				КонецЦикла;
				СоставСемьи = "";
				Пока ВыборкаРодственники.НайтиСледующий(СтруктураПоиска) Цикл
				
					СтрокаСоставаСемьи = Строка(ВыборкаРодственники.СтепеньРодства) + ": " +
											Строка(ВыборкаРодственники.Наименование) + ", " +
											"Дата рождения: " + Формат(ВыборкаРодственники.ДатаРождения, "ДФ=dd.MM.yyyy");
					
											
											СоставСемьи = СоставСемьи + СтрокаСоставаСемьи +  Символы.ПС;
				
				КонецЦикла; 
				
				ЗаполнитьЗначенияСвойств(СтрокаТаблицы.Параметры, ТекСтрока);
				СтрокаТаблицы.Параметры.ВидОбразования = ВидОбразования;
				СтрокаТаблицы.Параметры.СоставСемьи = СоставСемьи;
				
				СтрокаТаблицы.Параметры.ДатаРождения = Формат(ТекСтрока.ДатаРождения, "ДЛФ=Д");
				
				ДокументРезультат.Вывести(СтрокаТаблицы);
				
			КонецЦикла;
			
			ДокументРезультат.Вывести(Подвал);
			
		КонецЦикла;
		
	КонецПроцедуры
	
	////////////////////////////////////////////////////////////////////////////////
	// Универсальные процедуры и Функции.
	
	Процедура УстановитьДатуОтчета(НастройкиОтчета, ДатаОтчета)
		
		ЗначениеПараметраПериод = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("Период"));
		
		Если ЗначениеПараметраПериод <> Неопределено Тогда
			
			УстановитьДатуОтчета = Ложь;
			
			Если ТипЗнч(ЗначениеПараметраПериод.Значение) = Тип("Неопределено") Тогда
				УстановитьДатуОтчета = Истина;
			КонецЕсли;
			
			Если ТипЗнч(ЗначениеПараметраПериод.Значение) = Тип("Дата")
				И ЗначениеПараметраПериод.Значение = '00010101' Тогда
				УстановитьДатуОтчета = Истина;
			КонецЕсли; 
			
			Если ТипЗнч(ЗначениеПараметраПериод.Значение) = Тип("СтандартнаяДатаНачала")
				И Дата(ЗначениеПараметраПериод.Значение) = '00010101' Тогда
				УстановитьДатуОтчета = Истина;
			КонецЕсли; 
			
			Если УстановитьДатуОтчета Тогда
				ЗначениеПараметраПериод.Значение = ТекущаяДатаСеанса();
			КонецЕсли; 
			
			ДатаОтчета = Дата(ЗначениеПараметраПериод.Значение);
			
		КонецЕсли;
		
	КонецПроцедуры
	
	Процедура УстановитьПериодОтчета(НастройкиОтчета, ДатаОтчета)
		
		ЗначениеПараметраПериодОтчета = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ПериодОтчета"));
		
		Если ЗначениеПараметраПериодОтчета <> Неопределено И ЗначениеПараметраПериодОтчета.Значение <> '00010101' Тогда
			
			НачалоПериода = ЗначениеПараметраПериодОтчета.Значение.ДатаНачала;
			КонецПериода  = ЗначениеПараметраПериодОтчета.Значение.ДатаОкончания;
			
			Если НачалоПериода = '00010101' Тогда
				ЗначениеПараметраПериодОтчета.Значение.ДатаНачала = НачалоМесяца(ТекущаяДатаСеанса());
			КонецЕсли;
			
			Если КонецПериода = '00010101' Тогда
				ЗначениеПараметраПериодОтчета.Значение.ДатаОкончания  = КонецМесяца(ТекущаяДатаСеанса());
			КонецЕсли;
			
			ЗначениеПараметраПериод = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("Период"));
			
			Если ЗначениеПараметраПериод <> Неопределено Тогда
				ЗначениеПараметраПериод.Значение = НачалоДня(ЗначениеПараметраПериодОтчета.Значение.ДатаОкончания);
			КонецЕсли;	
			
			ДатаОтчета = Дата(ЗначениеПараметраПериод.Значение);
			
		КонецЕсли;
		
	КонецПроцедуры
	
	Функция ПараметрыЗаголовкаСтруктура(ДатаОтчета, Организация, Военкомат = Неопределено)
		
		ПараметрыЗаголовка = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Организация, "Наименование, НаименованиеПолное");
		
		ПолноеНаименованиеОрганизации = ?(ЗначениеЗаполнено(ПараметрыЗаголовка.НаименованиеПолное), ПараметрыЗаголовка.НаименованиеПолное, ПараметрыЗаголовка.Наименование);
		
		ПараметрыЗаголовка.Вставить("ДатаОтчета", ДатаОтчета);
		ПараметрыЗаголовка.Вставить("Организация", Организация);
		ПараметрыЗаголовка.Вставить("ПолноеНаименованиеОрганизации", ПолноеНаименованиеОрганизации);
		ПараметрыЗаголовка.Вставить("ЮрАдресОрганизации", УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(Организация, Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации, ДатаОтчета));
		ПараметрыЗаголовка.Вставить("ФактАдресОрганизации", УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(Организация, Справочники.ВидыКонтактнойИнформации.ФактАдресОрганизации, ДатаОтчета));
		ПараметрыЗаголовка.Вставить("ПочтовыйАдресОрганизации", УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(Организация, Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресОрганизации, ДатаОтчета));
		ПараметрыЗаголовка.Вставить("Военкомат", Военкомат);
		
		ЗаполнитьПодписантов(ПараметрыЗаголовка, Организация, ДатаОтчета);
		
		Возврат ПараметрыЗаголовка;
		
	КонецФункции
	
	Процедура ЗаполнитьПодписантов(ПараметрыЗаголовка, Организация, ДатаОтчета)
		
		ПараметрыЗаполнения = Новый Структура("Руководитель,РуководительРасшифровкаПодписи,ДолжностьРуководителя,ОтветственныйЗаВУР,ФИОРуководителя,"
		+ "ОтветственныйЗаВУРРасшифровкаПодписи,ДолжностьОтветственногоЗаВУР,ФИООтветственногоЗаВУР");
		КлючиОтветственныхЛиц = "";
		
		НастройкиОтчета = ЭтотОбъект.КомпоновщикНастроек.ПолучитьНастройки();
		
		ПараметрРуководитель = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("Руководитель"));	
		Если ПараметрРуководитель <> Неопределено И ПараметрРуководитель.Использование Тогда
			Если ЗначениеЗаполнено(ПараметрРуководитель.Значение) Тогда
				ПараметрыЗаполнения.Руководитель = ПараметрРуководитель.Значение;
			КонецЕсли; 
		Иначе
			КлючиОтветственныхЛиц = "Руководитель";
		КонецЕсли;
		
		ПараметрДолжностьРуководителя = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ДолжностьРуководителя"));	
		Если ПараметрДолжностьРуководителя <> Неопределено И ПараметрДолжностьРуководителя.Использование Тогда
			ПараметрыЗаполнения.ДолжностьРуководителя = ПараметрДолжностьРуководителя.Значение;
		Иначе
			КлючиОтветственныхЛиц = ?(ПустаяСтрока(КлючиОтветственныхЛиц), "", КлючиОтветственныхЛиц + ",") + "ДолжностьРуководителяСтрокой";
		КонецЕсли;
		
		ПараметрОтветственныйЗаВУР = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ОтветственныйЗаВУР"));	
		Если ПараметрОтветственныйЗаВУР <> Неопределено И ПараметрОтветственныйЗаВУР.Использование Тогда
			Если ЗначениеЗаполнено(ПараметрОтветственныйЗаВУР.Значение) Тогда
				ПараметрыЗаполнения.ОтветственныйЗаВУР = ПараметрОтветственныйЗаВУР.Значение;
			КонецЕсли; 
		Иначе
			КлючиОтветственныхЛиц = ?(ПустаяСтрока(КлючиОтветственныхЛиц), "", КлючиОтветственныхЛиц + ",") + "ОтветственныйЗаВУР";
		КонецЕсли;
		
		ПараметрДолжностьОтветственногоЗаВУР = НастройкиОтчета.ПараметрыДанных.НайтиЗначениеПараметра(Новый ПараметрКомпоновкиДанных("ДолжностьОтветственногоЗаВУР"));	
		Если ПараметрДолжностьОтветственногоЗаВУР <> Неопределено И ПараметрДолжностьОтветственногоЗаВУР.Использование Тогда
			ПараметрыЗаполнения.ДолжностьОтветственногоЗаВУР = ПараметрДолжностьОтветственногоЗаВУР.Значение;
		Иначе
			КлючиОтветственныхЛиц = ?(ПустаяСтрока(КлючиОтветственныхЛиц), "", КлючиОтветственныхЛиц + ",") + "ДолжностьОтветственногоЗаВУРСтрокой";
		КонецЕсли;
		
		Если Не ПустаяСтрока(КлючиОтветственныхЛиц) Тогда
			
			ОтветственныеЛица = Новый Структура("Организация," + КлючиОтветственныхЛиц, Организация);
			ЗарплатаКадры.ПолучитьЗначенияПоУмолчанию(ОтветственныеЛица, ДатаОтчета);
			
			ЗаполнитьЗначенияСвойств(ПараметрыЗаполнения, ОтветственныеЛица);
			Если ОтветственныеЛица.Свойство("ДолжностьРуководителяСтрокой") И ЗначениеЗаполнено(ОтветственныеЛица.ДолжностьРуководителяСтрокой) Тогда
				ПараметрыЗаполнения.ДолжностьРуководителя = ОтветственныеЛица.ДолжностьРуководителяСтрокой;
			КонецЕсли;
			Если ОтветственныеЛица.Свойство("ДолжностьОтветственногоЗаВУРСтрокой") И ЗначениеЗаполнено(ОтветственныеЛица.ДолжностьОтветственногоЗаВУРСтрокой) Тогда
				ПараметрыЗаполнения.ДолжностьОтветственногоЗаВУР = ОтветственныеЛица.ДолжностьОтветственногоЗаВУРСтрокой;
			КонецЕсли; 
			
		КонецЕсли; 
		
		МассивФизЛиц = Новый Массив;
		Если ЗначениеЗаполнено(ПараметрыЗаполнения.Руководитель) Тогда
			МассивФизЛиц.Добавить(ПараметрыЗаполнения.Руководитель);
		КонецЕсли; 
		Если ЗначениеЗаполнено(ПараметрыЗаполнения.ОтветственныйЗаВУР) Тогда
			МассивФизЛиц.Добавить(ПараметрыЗаполнения.ОтветственныйЗаВУР);
		КонецЕсли; 
		
		Если МассивФизЛиц.Количество() > 0 Тогда
			
			ФИОФизЛиц = ЗарплатаКадры.СоответствиеФИОФизЛицСсылкам(ДатаОтчета, МассивФизЛиц);
			
			ФИОРуководителя = ФИОФизЛиц[ПараметрыЗаполнения.Руководитель];
			Если ЗначениеЗаполнено(ФИОРуководителя) Тогда
				ПараметрыЗаполнения.РуководительРасшифровкаПодписи = ФизическиеЛицаЗарплатаКадры.РасшифровкаПодписи(ФИОРуководителя);
				ПараметрыЗаполнения.ФИОРуководителя = ФИОРуководителя.Фамилия + " " + ФИОРуководителя.Имя + " " + ФИОРуководителя.Отчество;
			КонецЕсли; 
			
			ФИООтветственногоЗаВУР = ФИОФизЛиц[ПараметрыЗаполнения.ОтветственныйЗаВУР];
			Если ЗначениеЗаполнено(ФИООтветственногоЗаВУР) Тогда
				ПараметрыЗаполнения.ОтветственныйЗаВУРРасшифровкаПодписи = ФизическиеЛицаЗарплатаКадры.РасшифровкаПодписи(ФИООтветственногоЗаВУР);
				ПараметрыЗаполнения.ФИООтветственногоЗаВУР = ФИООтветственногоЗаВУР.Фамилия + " " + ФИООтветственногоЗаВУР.Имя + " " + ФИООтветственногоЗаВУР.Отчество;
			КонецЕсли; 
			
		КонецЕсли; 
		
		Для каждого КлючИЗначение Из ПараметрыЗаполнения Цикл
			ПараметрыЗаголовка.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение);
		КонецЦикла;
		
	КонецПроцедуры
	
	Функция ТелефоныПодписантов(ПараметрыЗаголовка)
		
		МассивФизическихЛиц = Новый Массив;
		Если ЗначениеЗаполнено(ПараметрыЗаголовка.Руководитель) Тогда 
			МассивФизическихЛиц.Добавить(ПараметрыЗаголовка.Руководитель);
		КонецЕсли;
		Если ЗначениеЗаполнено(ПараметрыЗаголовка.ОтветственныйЗаВУР) Тогда 
			МассивФизическихЛиц.Добавить(ПараметрыЗаголовка.ОтветственныйЗаВУР);
		КонецЕсли;
		
		ТелефоныПодписантов = Новый Соответствие;
		Если МассивФизическихЛиц.Количество() = 0 Тогда 
			Возврат ТелефоныПодписантов;
		КонецЕсли;
		
		РабочиеТелефоныПодписантов = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъектов(МассивФизическихЛиц,	
		Перечисления.ТипыКонтактнойИнформации.Телефон, 
		Справочники.ВидыКонтактнойИнформации.ТелефонРабочийФизическиеЛица);
		
		Для Каждого ДанныеПодписанта Из РабочиеТелефоныПодписантов Цикл 
			ТелефоныПодписантов.Вставить(ДанныеПодписанта.Объект, НСтр("ru='тел'") + ". " + ДанныеПодписанта.Представление);
		КонецЦикла;
		
		Возврат ТелефоныПодписантов;
		
	КонецФункции
	
	// СтандартныеПодсистемы.ВариантыОтчетов

// См. ВариантыОтчетовПереопределяемый.НастроитьВариантыОтчетов.
//
Процедура НастроитьВариантыОтчета(Настройки, НастройкиОтчета) Экспорт
	
	НастройкиОтчета.ОпределитьНастройкиФормы = Истина;
	НастройкиВарианта = ВариантыОтчетов.ОписаниеВарианта(Настройки, НастройкиОтчета, "СписокДляСверкиСВоенкоматом");
	НастройкиВарианта.Описание =
		НСтр("ru = 'Сведения о воинском учете из личных карточек военнослужащих запаса 
		|для предоставления в военкомат'");
КонецПроцедуры

	#КонецОбласти
	
#КонецЕсли
