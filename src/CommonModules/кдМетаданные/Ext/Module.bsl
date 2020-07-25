﻿
Функция ПолучитьКаталогиКонфигурации(Конфигурация) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	кд_НастройкиКонфиграции.КаталогИсходныхФайлов,
	|	кд_НастройкиКонфиграции.КаталогМетаданных
	|ИЗ
	|	РегистрСведений.кд_НастройкиКонфиграции КАК кд_НастройкиКонфиграции
	|ГДЕ
	|	кд_НастройкиКонфиграции.Конфигурация = &Конфигурация";
	Запрос.УстановитьПараметр("Конфигурация", Конфигурация);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Новый Структура("КаталогИсходныхФайлов,КаталогМетаданных");
		ЗаполнитьЗначенияСвойств(Результат, Выборка);
		Если ПустаяСтрока(Результат.КаталогМетаданных) Тогда
			Результат.КаталогМетаданных = Результат.КаталогИсходныхФайлов;
		КонецЕсли;
	Иначе
		Результат = Неопределено;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Проверяет, что сейчас начыинается указанный узел
Функция ЭтоУзелXML(ЧтениеXML, ИмяУзла)
	Возврат ЧтениеXML.ТипУзла = ТипУзлаXML.НачалоЭлемента И ЧтениеXML.Имя = ИмяУзла;
КонецФункции

// Проверяет, что сейчас заканчивается указанный узел
Функция ЭтоКонецУзлаXML(ЧтениеXML, ИмяУзла)
	Возврат ЧтениеXML.ТипУзла = ТипУзлаXML.КонецЭлемента И ЧтениеXML.Имя = ИмяУзла;
КонецФункции

Процедура ПропуститьДоУзлаXML(ЧтениеXML, ИмяУзла)
	
	Пока НЕ ЭтоУзелXML(ЧтениеXML, ИмяУзла) Цикл
		ЧтениеXML.Пропустить();
		ЧтениеXML.Прочитать();
	КонецЦикла;
	
КонецПроцедуры

Процедура ПропуститьТекущийУзелXML(ЧтениеXML)
	
	ЧтениеXML.Пропустить();
	ЧтениеXML.Прочитать();
	
КонецПроцедуры

// Считывает соответствие имен узлов их обрабатываемым значениям
Функция ПрочитатьОписаниеСоответствия(ЧтениеXML, ИмяЭлемента)
	
	СоответствиеСвойств = Новый Соответствие;
	
	Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, ИмяЭлемента) Цикл
		Если ЧтениеXML.ТипУзла = ТипУзлаXML.НачалоЭлемента Тогда
			ИмяСвойства = ЧтениеXML.Имя;
			ЗначениеСвойства = ПрочитатьЗначениеXML(ЧтениеXML);
			Если ЗначениеЗаполнено(ЗначениеСвойства) Тогда
				СоответствиеСвойств.Вставить(ИмяСвойства, ЗначениеСвойства);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	ЧтениеXML.Прочитать();
	
	Возврат СоответствиеСвойств;
	
КонецФункции

Функция ПрочитатьОписаниеТипа(ЧтениеXML, ИмяЭлемента)
	
	ПростыеТипы = Новый Соответствие;
	ПростыеТипы.Вставить("xs:string", "Строка");
	ПростыеТипы.Вставить("xs:decimal", "Число");
	ПростыеТипы.Вставить("xs:boolean", "Булево");
	ПростыеТипы.Вставить("xs:dateTime", "Дата");
	
	ТипыСсылок = Новый Соответствие;
	ТипыСсылок.Вставить("cfg:EnumRef", "Перечисление");
	ТипыСсылок.Вставить("cfg:CatalogRef", "Справочник");
	ТипыСсылок.Вставить("cfg:DocumentRef", "Документ");
	//ТипыСсылок.Вставить("cfg:Characteristic", "");
	ТипыСсылок.Вставить("cfg:ChartOfCharacteristicTypesRef", "ПланВидовХарактеристик");
	
	// Чтение описания типов
	Типы = Новый Массив;
	
	Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, ИмяЭлемента) Цикл
		
		Если ЭтоУзелXML(ЧтениеXML, "v8:Type") ИЛИ ЭтоУзелXML(ЧтениеXML, "v8:TypeSet") Тогда
			ТипXML = ПрочитатьЗначениеXML(ЧтениеXML);
			ПростойТип = ПростыеТипы[ТипXML];
			Если ПростойТип <> Неопределено Тогда
				Типы.Добавить(Тип(ПростойТип));
			Иначе
				КорневойТипXML = ирОбщий.ПервыйФрагментЛкс(ТипXML, ".");
				КорневойТип = ТипыСсылок[КорневойТипXML];
				Если КорневойТип = Неопределено Тогда
					Сообщить("Не известный тип " + ТипXML);
				Иначе
					Типы.Добавить(СтрЗаменить(ТипXML, КорневойТипXML, КорневойТип));
				КонецЕсли;
			КонецЕсли;
		Иначе
			ПропуститьТекущийУзелXML(ЧтениеXML);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Типы;
	
КонецФункции

Функция ПрочитатьЗначениеXML(ЧтениеXML)
	
	ИмяЭлемента = ЧтениеXML.Имя;
	ЧтениеXML.Прочитать();
	Если ЭтоКонецУзлаXML(ЧтениеXML, ИмяЭлемента) Тогда
		Значение = ""; // Пустой узел
	ИначеЕсли ЧтениеXML.ТипУзла = ТипУзлаXML.Текст Тогда
		Значение = ЧтениеXML.Значение;
		ЧтениеXML.Прочитать();
	ИначеЕсли ЭтоУзелXML(ЧтениеXML, "v8:Type") ИЛИ ЭтоУзелXML(ЧтениеXML, "v8:TypeSet") Тогда
		Значение = ПрочитатьОписаниеТипа(ЧтениеXML, ИмяЭлемента);
	Иначе
		Сообщить("Найдено неизвестное описание значения " + ЧтениеXML.Имя);
		ЕстьОшибки = Истина;
		Пока ЭтоУзелXML(ЧтениеXML, ИмяЭлемента) Цикл
			ПропуститьТекущийУзелXML(ЧтениеXML);
		КонецЦикла;
	КонецЕсли;
	
	ЧтениеXML.Прочитать();
	
	Возврат Значение;
	
КонецФункции

Функция ПрочитатьСвойствоСтруктуры(ЧтениеXML, ОписаниеЭлемента)
	
	ИмяЗначения = ЧтениеXML.Имя;
	Если ОписаниеЭлемента.Свойство(ИмяЗначения) Тогда
		Значение = ПрочитатьЗначениеXML(ЧтениеXML);
		ОписаниеЭлемента.Вставить(ИмяЗначения, Значение);
	Иначе
		ПропуститьТекущийУзелXML(ЧтениеXML);
	КонецЕсли;
	
КонецФункции

Функция ПрочитатьPropertiesXML(ЧтениеXML, СписокПолей)
	
	ОписаниеЭлемента = Новый Структура(СписокПолей);
	
	ПропуститьДоУзлаXML(ЧтениеXML, "Properties");
	ЧтениеXML.Прочитать();
	
	Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "Properties") Цикл
		ПрочитатьСвойствоСтруктуры(ЧтениеXML, ОписаниеЭлемента);
	КонецЦикла;
	ЧтениеXML.Прочитать();
	
	Возврат ОписаниеЭлемента;
	
КонецФункции

Функция ПрочитатьAttribute(ЧтениеXML, ТаблицаМетаданных, ПолноеИмяТЧ)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "Attribute") Тогда
		Возврат Ложь;
	КонецЕсли;
	ЧтениеXML.Прочитать();
	
	ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, "Name,Type");
	ЧтениеXML.Прочитать();
	
	СтрокаМетаданных = ТаблицаМетаданных.Добавить();
	СтрокаМетаданных.КорневойТип = ПолноеИмяТЧ + "Реквизит";
	СтрокаМетаданных.ПолноеИмя = ОписаниеЭлемента.Name;
	СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
	СтрокаМетаданных.Тип = ОписаниеЭлемента.Type;
	
	Возврат Истина;
	
КонецФункции

Функция ПрочитатьDimension(ЧтениеXML, ТаблицаМетаданных)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "Dimension") Тогда
		Возврат Ложь;
	КонецЕсли;
	ЧтениеXML.Прочитать();
	
	ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, "Name,Type");
	ЧтениеXML.Прочитать();
	
	СтрокаМетаданных = ТаблицаМетаданных.Добавить();
	СтрокаМетаданных.КорневойТип = "Измерение";
	СтрокаМетаданных.ПолноеИмя = ОписаниеЭлемента.Name;
	СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
	СтрокаМетаданных.Тип = ОписаниеЭлемента.Type;
	
	Возврат Истина;
	
КонецФункции

Функция ПрочитатьResource(ЧтениеXML, ТаблицаМетаданных)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "Resource") Тогда
		Возврат Ложь;
	КонецЕсли;
	ЧтениеXML.Прочитать();
	
	ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, "Name,Type");
	ЧтениеXML.Прочитать();
	
	СтрокаМетаданных = ТаблицаМетаданных.Добавить();
	СтрокаМетаданных.КорневойТип = "Resource";
	СтрокаМетаданных.ПолноеИмя = ОписаниеЭлемента.Name;
	СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
	СтрокаМетаданных.Тип = ОписаниеЭлемента.Type;
	
	Возврат Истина;
	
КонецФункции

Функция ПрочитатьTabularSection(ЧтениеXML, ТаблицаМетаданных, ПолноеИмяОбъекта)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "TabularSection") Тогда
		Возврат Ложь;
	КонецЕсли;
	ЧтениеXML.Прочитать();
	
	ПолноеИмяТЧ = "";
	Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "TabularSection") Цикл
		Если ЭтоУзелXML(ЧтениеXML, "Properties") Тогда
			
			ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, "Name");
			ПолноеИмяТЧ = "ТабличнаяЧасть." + ОписаниеЭлемента.Name;
			СтрокаМетаданных = ТаблицаМетаданных.Добавить();
			СтрокаМетаданных.КорневойТип = "ТабличнаяЧасть";
			СтрокаМетаданных.ПолноеИмяРодителя = ПолноеИмяОбъекта;
			СтрокаМетаданных.ПолноеИмя = ПолноеИмяТЧ;
			СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
			
		ИначеЕсли ЭтоУзелXML(ЧтениеXML, "ChildObjects") Тогда
			ЧтениеXML.Прочитать();
			
			Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "ChildObjects") Цикл
				Если НЕ ПрочитатьAttribute(ЧтениеXML, ТаблицаМетаданных, ПолноеИмяТЧ + ".") Тогда
					ПропуститьТекущийУзелXML(ЧтениеXML);
				КонецЕсли;
			КонецЦикла;
			ЧтениеXML.Прочитать();
			
		Иначе
			ПропуститьТекущийУзелXML(ЧтениеXML);
		КонецЕсли;
	КонецЦикла;
	ЧтениеXML.Прочитать();
	
	Возврат Истина;
	
КонецФункции

Функция ОткрытьФайлМетаданных(ПолноеИмяФайла)
	
	ЧтениеXML = Новый ЧтениеXML();
	ЧтениеXML.ОткрытьФайл(ПолноеИмяФайла);
	
	ЧтениеXML.Прочитать();
	Если ЧтениеXML.ТипУзла = ТипУзлаXML.ОбъявлениеXML Тогда
		ЧтениеXML.Прочитать();
	КонецЕсли;
	Если ЭтоУзелXML(ЧтениеXML, "MetaDataObject") Тогда
		ЧтениеXML.Прочитать();
		ЧтениеXML.Прочитать();
		Возврат ЧтениеXML;
	КонецЕсли;
	
	ВызватьИсключение "КД2: Некорректный формат файла " + ПолноеИмяФайла;
	
КонецФункции

Функция ОписаниеМетаданныхОбъектаПоФайлу(ПолноеИмяФайла, СписокПолей)
	
	ЧтениеXML = ОткрытьФайлМетаданных(ПолноеИмяФайла);
	ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, СписокПолей);
	ЧтениеXML.Закрыть();
	Возврат ОписаниеЭлемента;
	
КонецФункции

Процедура ЗагрузитьПредопределенныеЗначенияОбъектаПоФайлу(ТаблицаМетаданных, ПолноеИмяФайла, ТипЭлемента)
	
	ЧтениеXML = Новый ЧтениеXML();
	ЧтениеXML.ОткрытьФайл(ПолноеИмяФайла);
	
	ЧтениеXML.Прочитать();
	Если НЕ ЭтоУзелXML(ЧтениеXML, "PredefinedData") Тогда
		Возврат;
	КонецЕсли;
	
	ЧтениеXML.Прочитать();
	
	ОписаниеЭлемента = Новый Структура("Name");
	Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "PredefinedData") Цикл
		ЧтениеXML.Прочитать();
		Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "Item") Цикл
			ПрочитатьСвойствоСтруктуры(ЧтениеXML, ОписаниеЭлемента);
		КонецЦикла;
		ЧтениеXML.Прочитать();
		
		СтрокаМетаданных = ТаблицаМетаданных.Добавить();
		СтрокаМетаданных.КорневойТип = "Предопределенные";
		СтрокаМетаданных.ПолноеИмя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Тип = ирОбщий.БыстрыйМассивЛкс(ТипЭлемента);
	КонецЦикла;
	
КонецПроцедуры

Функция ЗаполнитьМетаданныеПоФайлу(КаталогиКонфигурации, ИмяФайла, ПолноеИмяОбъекта)
	
	СоответствиеКорневыхТипов = Новый Соответствие;
	СоответствиеКорневыхТипов.Вставить("CommonModule"              , "ОбщийМодуль");
	СоответствиеКорневыхТипов.Вставить("CommonAttribute"           , "ОбщийРеквизит");
	СоответствиеКорневыхТипов.Вставить("SessionParameter"          , "ПараметрСеанса");
	СоответствиеКорневыхТипов.Вставить("ExchangePlan"              , "ПланОбмена");
	СоответствиеКорневыхТипов.Вставить("Constant"                  , "Константа");
	СоответствиеКорневыхТипов.Вставить("Catalog"                   , "Справочник");
	СоответствиеКорневыхТипов.Вставить("Document"                  , "Документ");
	//СоответствиеКорневыхТипов.Вставить("Sequence"                  , "Последовательность");
	СоответствиеКорневыхТипов.Вставить("Enum"                      , "Перечисление");
	СоответствиеКорневыхТипов.Вставить("ChartOfCharacteristicTypes", "ПланВидовХарактеристик");
	СоответствиеКорневыхТипов.Вставить("ChartOfAccounts"           , "ПланСчетов");
	СоответствиеКорневыхТипов.Вставить("ChartOfCalculationTypes"   , "ПланВидовРасчета");
	СоответствиеКорневыхТипов.Вставить("InformationRegister"       , "РегистрСведений");
	СоответствиеКорневыхТипов.Вставить("AccumulationRegister"      , "РегистрНакопления");
	СоответствиеКорневыхТипов.Вставить("AccountingRegister"        , "РегистрБухгалтерии");
	СоответствиеКорневыхТипов.Вставить("CalculationRegister"       , "РегистрРасчета");
	СоответствиеКорневыхТипов.Вставить("BusinessProcess"           , "БизнесПроцесс");
	СоответствиеКорневыхТипов.Вставить("Task"                      , "Задача");
	
	ТаблицаМетаданных = Новый ТаблицаЗначений;
	ТаблицаМетаданных.Колонки.Добавить("КорневойТип"); // Вид объекта - "Справочник", "Реквизит", "ТабличнаяЧасть", "ТабличнаяЧасть.<имя ТЧ>.Реквизит"
	ТаблицаМетаданных.Колонки.Добавить("ПолноеИмяРодителя"); // Метаданные родителя для подчиненных коллекций (реквизитов ТЧ, измерений, ...) - "ТабличнаяЧасть.<имя ТЧ>"
	ТаблицаМетаданных.Колонки.Добавить("ПолноеИмя"); // Полное имя - "Справочник.Валюты", "<имя реквизита>", "ТабличнаяЧасть.<имя ТЧ>", "<имя реквизита ТЧ>"
	ТаблицаМетаданных.Колонки.Добавить("Имя"); // имя - "Валюты", "<имя реквизита>", "<имя ТЧ>", "<имя реквизита ТЧ>"
	ТаблицаМетаданных.Колонки.Добавить("Тип"); // Массив типов. Элементы: для простых типов - Тип, для ссылочных - строка
	
	Разделитель = ПолучитьРазделительПути();
	
	ПолноеИмяФайла = КаталогиКонфигурации.КаталогИсходныхФайлов + Разделитель + ИмяФайла + ".xml";
	
	ЧтениеXML = ОткрытьФайлМетаданных(ПолноеИмяФайла);
	
	Если ИмяФайла = "Configuration" Тогда
		
		ПропуститьДоУзлаXML(ЧтениеXML, "ChildObjects");
		ЧтениеXML.Прочитать();
		
		Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "ChildObjects") Цикл
			КорневойТип = СоответствиеКорневыхТипов[ЧтениеXML.Имя];
			ИмяОбъекта = ПрочитатьЗначениеXML(ЧтениеXML);
			Если КорневойТип <> Неопределено Тогда
				//ТЕСТ
				Если КорневойТип = "ОбщийМодуль" Тогда
					ИмяФайлаОбъекта = КаталогиКонфигурации.КаталогИсходныхФайлов + Разделитель +
						"CommonModules" + Разделитель + ИмяОбъекта + ".xml";
					Если ОписаниеМетаданныхОбъектаПоФайлу(ИмяФайлаОбъекта, "Global").Global Тогда
						Продолжить; // глобавльные модуле не добавляются в метаданные
					КонецЕсли;
				КонецЕсли;
				//ТЕСТ
				
				СтрокаМетаданных = ТаблицаМетаданных.Добавить();
				СтрокаМетаданных.КорневойТип = КорневойТип;
				СтрокаМетаданных.ПолноеИмя = КорневойТип + "." + ИмяОбъекта;
				СтрокаМетаданных.Имя = ИмяОбъекта;
				
				//ТЕСТ
				Если КорневойТип = "ПараметрСеанса" Тогда
					// Прочитать тип метаданных
					ИмяФайлаОбъекта = КаталогиКонфигурации.КаталогИсходныхФайлов + Разделитель +
						"SessionParameters" + Разделитель + ИмяОбъекта + ".xml";
					СтрокаМетаданных.Тип = ОписаниеМетаданныхОбъектаПоФайлу(ИмяФайлаОбъекта, "Type").Type;
				// тип НЕ РАБОТАЕТ в подсказке ИР
				//ИначеЕсли КорневойТип = "Константа" Тогда
				//	// Прочитать тип метаданных
				//	ИмяФайлаОбъекта = КаталогиКонфигурации.КаталогИсходныхФайлов + Разделитель +
				//		"Constants" + Разделитель + ИмяОбъекта + ".xml";
				//	СтрокаМетаданных.Тип = ОписаниеМетаданныхОбъектаПоФайлу(ИмяФайлаОбъекта, "Type").Type;
				КонецЕсли;
				//ТЕСТ
			КонецЕсли;
		КонецЦикла;
	Иначе
		ПропуститьДоУзлаXML(ЧтениеXML, "ChildObjects");
		ЧтениеXML.Прочитать();
		
		Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "ChildObjects") Цикл
			Если НЕ ПрочитатьAttribute(ЧтениеXML, ТаблицаМетаданных, "")
			   И НЕ ПрочитатьDimension(ЧтениеXML, ТаблицаМетаданных)
			   И НЕ ПрочитатьResource(ЧтениеXML, ТаблицаМетаданных)
			   И НЕ ПрочитатьTabularSection(ЧтениеXML, ТаблицаМетаданных, ПолноеИмяОбъекта)
			Тогда
				ЧтениеXML.Пропустить();
				ЧтениеXML.Прочитать();
			КонецЕсли;
		КонецЦикла;
		
		//ТЕСТ
		МассивФрагментов = ирОбщий.СтрРазделитьЛкс(ПолноеИмяОбъекта);
		Если МассивФрагментов[0] = "Справочник" Тогда
			ИмяФайлаОбъекта = КаталогиКонфигурации.КаталогИсходныхФайлов + Разделитель +
				"Catalogs" + Разделитель + МассивФрагментов[1] + Разделитель + "Ext" + Разделитель + "Predefined.xml";
			ЗагрузитьПредопределенныеЗначенияОбъектаПоФайлу(ТаблицаМетаданных, ИмяФайлаОбъекта, ПолноеИмяОбъекта);
		КонецЕсли;
		//ТЕСТ
	КонецЕсли;
	
	ЧтениеXML.Закрыть();
	
	ПолноеИмяФайла = ОбеспечитьКаталогиФайла(КаталогиКонфигурации.КаталогМетаданных + Разделитель, ИмяФайла + ".idx");
	
	ЗаписьXML = Новый ЗаписьXML();
	ЗаписьXML.ОткрытьФайл(ПолноеИмяФайла);
	СериализаторXDTO.ЗаписатьXML(ЗаписьXML, ТаблицаМетаданных);
	ЗаписьXML.Закрыть();
	
	Возврат ТаблицаМетаданных;
	
КонецФункции

Функция ОбеспечитьКаталогиФайла(КорневойКаталог, ИмяФайла)
	
	Разделитель = ПолучитьРазделительПути();
	КаталогФайла = КорневойКаталог;
	ЧастиФайла = СтроковыеФункции.РазложитьСтрокуВМассивПодстрок(ИмяФайла, ПолучитьРазделительПути());
	Для ИндексКаталога = 0 По ЧастиФайла.Количество() - 2 Цикл
		КаталогФайла = КаталогФайла + ЧастиФайла[ИндексКаталога] + Разделитель;
		ТестКаталог = Новый Файл(КаталогФайла);
		Если НЕ ТестКаталог.Существует() ИЛИ НЕ ТестКаталог.ЭтоКаталог() Тогда
			СоздатьКаталог(КаталогФайла);
		КонецЕсли;
	КонецЦикла;
	
	Возврат КорневойКаталог + ИмяФайла;
	
КонецФункции

Функция ПолучитьТаблицуМетаданныхИзФайла(ОписаниеМетаданных)
	
	КаталогиКонфигурации = ПолучитьКаталогиКонфигурации(ОписаниеМетаданных["Конфигурация"]); // ПовтИсп
	Если КаталогиКонфигурации = Неопределено Тогда
		ВызватьИсключение "Не заданы каталоги для конфгурации " + ОписаниеМетаданных["Конфигурация"];
	КонецЕсли;
	
	ИмяФайла = ИмяФайлаПоМетаданным(ОписаниеМетаданных["ПолноеИмя"]); // ПовтИсп
	ПолноеИмяФайла = КаталогиКонфигурации.КаталогМетаданных + ПолучитьРазделительПути() + ИмяФайла + ".idx";
	ТестФайл = Новый Файл(ПолноеИмяФайла);
	Если ТестФайл.Существует() Тогда
		ТаблицаМетаданных = ирОбщий.ЗагрузитьЗначениеИзФайлаЛкс(ПолноеИмяФайла);
	Иначе
		ТаблицаМетаданных = ЗаполнитьМетаданныеПоФайлу(КаталогиКонфигурации, ИмяФайла, ОписаниеМетаданных["ПолноеИмя"]);
	КонецЕсли;
	
	Возврат ТаблицаМетаданных;
	
КонецФункции

Функция ПолучитьКоллекциюОбъектов(МетаданныеРодителя, ИмяКоллекции) Экспорт
	
	ТаблицаМетаданных = кд_глПолучитьМетаданныеИзКэша(МетаданныеРодителя);
	Если ТаблицаМетаданных = Неопределено Тогда
		ТаблицаМетаданных = ПолучитьТаблицуМетаданныхИзФайла(МетаданныеРодителя);
		кд_СохранитьМетаданныеВКэше(МетаданныеРодителя, ТаблицаМетаданных);
	КонецЕсли;
	
	НайденныеОбъекты = ТаблицаМетаданных.НайтиСтроки(Новый Структура("КорневойТип", ИмяКоллекции));
	
	Возврат НайденныеОбъекты;
	
КонецФункции

Функция ИмяФайлаПоМетаданным(ПолноеИмя)
	
	СоответствиеКорневыхТипов = Новый Соответствие;  // ПовтИсп
	СоответствиеКорневыхТипов.Вставить("ОбщийМодуль", "CommonModules");
	СоответствиеКорневыхТипов.Вставить("ПланОбмена", "ExchangePlans");
	СоответствиеКорневыхТипов.Вставить("Константа", "Constants");
	СоответствиеКорневыхТипов.Вставить("Справочник", "Catalogs");
	СоответствиеКорневыхТипов.Вставить("Документ", "Documents");
	//СоответствиеКорневыхТипов.Вставить("Последовательность", "Sequence");
	СоответствиеКорневыхТипов.Вставить("Перечисление", "Enums");
	СоответствиеКорневыхТипов.Вставить("ПланВидовХарактеристик", "ChartsOfCharacteristicTypes");
	СоответствиеКорневыхТипов.Вставить("ПланСчетов", "ChartsOfAccounts");
	СоответствиеКорневыхТипов.Вставить("ПланВидовРасчета", "ChartsOfCalculationTypes");
	СоответствиеКорневыхТипов.Вставить("РегистрСведений", "InformationRegisters");
	СоответствиеКорневыхТипов.Вставить("РегистрНакопления", "AccumulationRegisters");
	СоответствиеКорневыхТипов.Вставить("РегистрБухгалтерии", "AccountingRegisters");
	СоответствиеКорневыхТипов.Вставить("РегистрРасчета", "CalculationRegisters");
	СоответствиеКорневыхТипов.Вставить("БизнесПроцесс", "BusinessProcesses");
	СоответствиеКорневыхТипов.Вставить("Задача", "Tasks");
	
	Если ПолноеИмя = Неопределено Тогда
		ИмяФайла = "Configuration";
	Иначе
		МассивФрагментов = ирОбщий.СтрРазделитьЛкс(ПолноеИмя);
		ИмяФайла = СоответствиеКорневыхТипов[МассивФрагментов[0]] + ПолучитьРазделительПути() + МассивФрагментов[1];
	КонецЕсли;
	
	Возврат ИмяФайла;
	
КонецФункции
