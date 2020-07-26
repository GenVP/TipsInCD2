﻿Функция ПолучитьКоллекциюОбъектов(МетаданныеРодителя, ИмяКоллекции, Настройки = Неопределено) Экспорт
	
	ТаблицаМетаданных = ПолучитьМетаданныеИзКэша(МетаданныеРодителя);
	Если ТаблицаМетаданных = Неопределено Тогда
		Если Настройки = Неопределено Тогда
			Настройки = ПолучитьНастройкиМетаданныхКонфигурации(МетаданныеРодителя["Конфигурация"]);
		КонецЕсли;
		ТаблицаМетаданных = ПолучитьТаблицуМетаданныхИзФайла(Настройки, МетаданныеРодителя);
		СохранитьМетаданныеВКэше(МетаданныеРодителя, ТаблицаМетаданных);
	КонецЕсли;
	
	ОтборОбъектов = Новый Структура("КорневойТип", ИмяКоллекции);
	Если ИмяКоллекции = "Макет" И МетаданныеРодителя["ПолноеИмя"] = Неопределено Тогда
		ОтборОбъектов.КорневойТип = "ОбщийМакет";
	КонецЕсли;
	НайденныеОбъекты = ТаблицаМетаданных.НайтиСтроки(ОтборОбъектов);
	
	Возврат НайденныеОбъекты;
	
КонецФункции

Функция ПолучитьВсеОбщиеРеквизиты(Настройки)
	
	МетаданныеРодителя = Новый Соответствие;
	МетаданныеРодителя.Вставить("Конфигурация", Настройки.Конфигурация);
	МетаданныеРодителя.Вставить("ПолноеИмя", "ОбщийРеквизит.#All");
	
	ТаблицаОбщихРеквизитов = ПолучитьМетаданныеИзКэша(МетаданныеРодителя);
	Если ТаблицаОбщихРеквизитов = Неопределено Тогда
		ТаблицаОбщихРеквизитов = ПолучитьТаблицуМетаданныхИзФайла(Настройки, МетаданныеРодителя);
		СохранитьМетаданныеВКэше(МетаданныеРодителя, ТаблицаОбщихРеквизитов);
	КонецЕсли;
	
	Возврат ТаблицаОбщихРеквизитов;
	
КонецФункции

Функция ПолучитьМетаданныеИзКэша(МетаданныеРодителя) Экспорт
	
	кд_МетаданныеКонфигурация = гл_кдКэш()[МетаданныеРодителя["Конфигурация"]];
	Если кд_МетаданныеКонфигурация = Неопределено Тогда
		кд_МетаданныеКонфигурация = Новый Соответствие;
		гл_кдКэш()[МетаданныеРодителя["Конфигурация"]] = кд_МетаданныеКонфигурация;
	КонецЕсли;
	
	Если ПустаяСтрока(МетаданныеРодителя["ПолноеИмя"]) ИЛИ ПустаяСтрока(МетаданныеРодителя["ПолноеИмяРодителя"]) Тогда
		кд_Метаданные = кд_МетаданныеКонфигурация[Строка(МетаданныеРодителя["ПолноеИмя"])];
	Иначе
		кд_Метаданные = кд_МетаданныеКонфигурация[МетаданныеРодителя["ПолноеИмяРодителя"]];
	КонецЕсли;
	
	Возврат кд_Метаданные;
	
КонецФункции

Процедура СохранитьМетаданныеВКэше(МетаданныеРодителя, МетаданныеОбъекта) Экспорт
	
	кд_МетаданныеКонфигурация = гл_кдКэш()[МетаданныеРодителя["Конфигурация"]];
	Если кд_МетаданныеКонфигурация = Неопределено Тогда
		кд_МетаданныеКонфигурация = Новый Соответствие;
		гл_кдКэш()[МетаданныеРодителя["Конфигурация"]] = кд_МетаданныеКонфигурация;
	КонецЕсли;
	
	Если ПустаяСтрока(МетаданныеРодителя["ПолноеИмя"]) ИЛИ ПустаяСтрока(МетаданныеРодителя["ПолноеИмяРодителя"]) Тогда
		кд_МетаданныеКонфигурация[Строка(МетаданныеРодителя["ПолноеИмя"])] = МетаданныеОбъекта;
	Иначе
		кд_МетаданныеКонфигурация[МетаданныеРодителя["ПолноеИмяРодителя"]] = МетаданныеОбъекта;
	КонецЕсли;
	
КонецПроцедуры

Функция ПолучитьТаблицуМетаданныхИзФайла(Настройки, ОписаниеМетаданных)
	
	ТаблицаМетаданных = Неопределено;
	ИмяФайла = ИмяФайлаПоМетаданным(Настройки, ОписаниеМетаданных["ПолноеИмя"]);
	
	Если Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВФайлах Тогда
		ПолноеИмяФайла = Настройки.КаталогМетаданных + ПолучитьРазделительПути() + ИмяФайла + ".idx";
		ТестФайл = Новый Файл(ПолноеИмяФайла);
		Если ТестФайл.Существует() Тогда
			ТаблицаМетаданных = ирОбщий.ЗагрузитьЗначениеИзФайлаЛкс(ПолноеИмяФайла);
		КонецЕсли;
		
	ИначеЕсли Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВБазеДанных Тогда
		МенеджерМетаданных = РегистрыСведений.кд_Метаданные.СоздатьМенеджерЗаписи();
		МенеджерМетаданных.Конфигурация = Настройки.Конфигурация;
		МенеджерМетаданных.ПолноеИмя = ОписаниеМетаданных["ПолноеИмя"];
		Попытка
			МенеджерМетаданных.Прочитать();
			Если МенеджерМетаданных.Выбран() Тогда
				ТаблицаМетаданных = МенеджерМетаданных.Метаданные.Получить();
			КонецЕсли;
		Исключение
			Сообщить("Не удалось получить индекс метаданных из базе для " + Настройки.Конфигурация + ", " + ОписаниеМетаданных["ПолноеИмя"]);
		КонецПопытки;
	КонецЕсли;
	
	Если ТаблицаМетаданных = Неопределено Тогда
		Если ОписаниеМетаданных["ПолноеИмя"] = "ОбщийРеквизит.#All" Тогда
			ТаблицаМетаданных = ЗаполнитьОбщиеРеквизитыПоФайлам(Настройки);
		Иначе
			ТаблицаМетаданных = ЗаполнитьМетаданныеПоФайлу(Настройки, ИмяФайла, ОписаниеМетаданных["ПолноеИмя"]);
		КонецЕсли;
		
		Если Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВФайлах Тогда
			ОбеспечитьКаталог(Настройки.КаталогМетаданных, ПолноеИмяФайла);
			ирОбщий.СохранитьЗначениеВФайлЛкс(ТаблицаМетаданных, ПолноеИмяФайла);
			
		ИначеЕсли Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВБазеДанных Тогда
			МенеджерМетаданных.Конфигурация = Настройки.Конфигурация;
			МенеджерМетаданных.ПолноеИмя = ОписаниеМетаданных["ПолноеИмя"];
			МенеджерМетаданных.Метаданные = Новый ХранилищеЗначения(ТаблицаМетаданных);
			Попытка
				МенеджерМетаданных.Записать();
			Исключение
				Сообщить("Не удалось сохранить индекс метаданных в базе для " + МенеджерМетаданных.Конфигурация + ", " + МенеджерМетаданных.ПолноеИмя);
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;
	
	Возврат ТаблицаМетаданных;
	
КонецФункции

Функция ПолучитьНастройкиМетаданныхКонфигурации(Конфигурация) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	кд_НастройкиКонфиграции.КаталогИсходныхФайлов,
	|	кд_НастройкиКонфиграции.КаталогМетаданных,
	|	кд_НастройкиКонфиграции.Индексировать
	|ИЗ
	|	РегистрСведений.кд_НастройкиКонфиграции КАК кд_НастройкиКонфиграции
	|ГДЕ
	|	кд_НастройкиКонфиграции.Конфигурация = &Конфигурация";
	Запрос.УстановитьПараметр("Конфигурация", Конфигурация);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если НЕ Выборка.Следующий() Тогда
		ВызватьИсключение "Не найдены настройки для конфигурации " + Конфигурация;
	КонецЕсли;
	
	КорневыеТипы = гл_кдКэш()["КорневыеТипы"];
	Если КорневыеТипы = Неопределено Тогда
		КорневыеТипы = ТаблицаСоответствияКорневыхТипов();
		гл_кдКэш()["КорневыеТипы"] = КорневыеТипы;
	КонецЕсли;
	
	Настройки = Новый Структура;
	Настройки.Вставить("Конфигурация", Конфигурация);
	Настройки.Вставить("КорневыеТипы", КорневыеТипы);
	Настройки.Вставить("КаталогИсходныхФайлов", Выборка.КаталогИсходныхФайлов);
	Настройки.Вставить("КаталогМетаданных", Выборка.КаталогМетаданных);
	Если ПустаяСтрока(Настройки.КаталогМетаданных) Тогда
		Настройки.КаталогМетаданных = Настройки.КаталогИсходныхФайлов;
	КонецЕсли;
	Настройки.Вставить("Индексировать", Выборка.Индексировать);
	
	Возврат Настройки;
	
КонецФункции

Функция ТаблицаСоответствияКорневыхТипов()
	
	СоответствиеТипов = Новый ТаблицаЗначений;
	СоответствиеТипов.Колонки.Добавить("Ед");
	СоответствиеТипов.Колонки.Добавить("ЕдEng");
	СоответствиеТипов.Колонки.Добавить("МнEng");
	СоответствиеТипов.Колонки.Добавить("ЕстьПредопределенные", Новый ОписаниеТипов("Булево"));
	СоответствиеТипов.Колонки.Добавить("ЕстьОбщийРеквизит", Новый ОписаниеТипов("Булево"));
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ОбщийМодуль";
	СтрокаТЗ.ЕдEng = "CommonModule";
	СтрокаТЗ.МнEng = "CommonModules";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ОбщийРеквизит";
	СтрокаТЗ.ЕдEng = "CommonAttribute";
	СтрокаТЗ.МнEng = "CommonAttributes";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ПараметрСеанса";
	СтрокаТЗ.ЕдEng = "SessionParameter";
	СтрокаТЗ.МнEng = "SessionParameters";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Константа";
	СтрокаТЗ.ЕдEng = "Constant";
	СтрокаТЗ.МнEng = "Constants";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ПланОбмена";
	СтрокаТЗ.ЕдEng = "ExchangePlan";
	СтрокаТЗ.МнEng = "ExchangePlans";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Справочник";
	СтрокаТЗ.ЕдEng = "Catalog";
	СтрокаТЗ.МнEng = "Catalogs";
	СтрокаТЗ.ЕстьПредопределенные = Истина;
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Документ";
	СтрокаТЗ.ЕдEng = "Document";
	СтрокаТЗ.МнEng = "Documents";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Перечисление";
	СтрокаТЗ.ЕдEng = "Enum";
	СтрокаТЗ.МнEng = "Enums";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ПланВидовХарактеристик";
	СтрокаТЗ.ЕдEng = "ChartOfCharacteristicTypes";
	СтрокаТЗ.МнEng = "ChartsOfCharacteristicTypes";
	СтрокаТЗ.ЕстьПредопределенные = Истина;
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ПланСчетов";
	СтрокаТЗ.ЕдEng = "ChartOfAccounts";
	СтрокаТЗ.МнEng = "ChartsOfAccounts";
	СтрокаТЗ.ЕстьПредопределенные = Истина;
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ПланВидовРасчета";
	СтрокаТЗ.ЕдEng = "ChartOfCalculationTypes";
	СтрокаТЗ.МнEng = "ChartsOfCalculationTypes";
	СтрокаТЗ.ЕстьПредопределенные = Истина;
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "РегистрСведений";
	СтрокаТЗ.ЕдEng = "InformationRegister";
	СтрокаТЗ.МнEng = "InformationRegisters";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "РегистрНакопления";
	СтрокаТЗ.ЕдEng = "AccumulationRegister";
	СтрокаТЗ.МнEng = "AccumulationRegisters";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "РегистрБухгалтерии";
	СтрокаТЗ.ЕдEng = "AccountingRegister";
	СтрокаТЗ.МнEng = "AccountingRegisters";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "РегистрРасчета";
	СтрокаТЗ.ЕдEng = "CalculationRegister";
	СтрокаТЗ.МнEng = "CalculationRegisters";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "БизнесПроцесс";
	СтрокаТЗ.ЕдEng = "BusinessProcess";
	СтрокаТЗ.МнEng = "BusinessProcesses";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Задача";
	СтрокаТЗ.ЕдEng = "Task";
	СтрокаТЗ.МнEng = "Tasks";
	СтрокаТЗ.ЕстьОбщийРеквизит = Истина;
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Обработка";
	СтрокаТЗ.ЕдEng = "DataProcessor";
	СтрокаТЗ.МнEng = "DataProcessors";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Отчет";
	СтрокаТЗ.ЕдEng = "Report";
	СтрокаТЗ.МнEng = "Reports";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ОбщийМакет";
	СтрокаТЗ.ЕдEng = "CommonTemplate";
	СтрокаТЗ.МнEng = "CommonTemplates";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "Макет";
	СтрокаТЗ.ЕдEng = "Template";
	СтрокаТЗ.МнEng = "Templates";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "ЖурналДокументов";
	СтрокаТЗ.ЕдEng = "DocumentJournal";
	СтрокаТЗ.МнEng = "DocumentJournals";
	
	СтрокаТЗ = СоответствиеТипов.Добавить();
	СтрокаТЗ.Ед = "РегламентноеЗадание";
	СтрокаТЗ.ЕдEng = "ScheduledJob";
	СтрокаТЗ.МнEng = "ScheduledJobs";
	
	Возврат СоответствиеТипов;
	
КонецФункции

Функция ПоискКорневогоТипа(КорневыеТипы, КорневойТипПоиска, КолонкаПоиска)
	
	СтрокаТаблицы = КорневыеТипы.Найти(КорневойТипПоиска, КолонкаПоиска);
	Если СтрокаТаблицы = Неопределено Тогда
		Результат = Неопределено;
	Иначе
		Результат = СтрокаТаблицы;
	КонецЕсли;
	
	Возврат СтрокаТаблицы;
	
КонецФункции

Функция ИмяФайлаПоМетаданным(Настройки, ПолноеИмя)
	
	Если ПолноеИмя = Неопределено Тогда
		ИмяФайла = "Configuration";
	Иначе
		МассивФрагментов = ирОбщий.СтрРазделитьЛкс(ПолноеИмя);
		ИмяФайла = ПоискКорневогоТипа(Настройки.КорневыеТипы, МассивФрагментов[0], "Ед").МнEng + ПолучитьРазделительПути() + МассивФрагментов[1];
	КонецЕсли;
	
	Возврат ИмяФайла;
	
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

Функция ПрочитатьОписаниеТипа(ЧтениеXML, ИмяЭлемента)
	
	ПростыеТипы = Новый Соответствие;
	ПростыеТипы.Вставить("xs:string", "Строка");
	ПростыеТипы.Вставить("xs:decimal", "Число");
	ПростыеТипы.Вставить("xs:boolean", "Булево");
	ПростыеТипы.Вставить("xs:dateTime", "Дата");
	ПростыеТипы.Вставить("v8:FixedArray", "ФиксированныйМассив");
	ПростыеТипы.Вставить("v8:FixedStructure", "ФиксированнаяСтруктура");
	ПростыеТипы.Вставить("v8:FixedMap", "ФиксированноеСоответствие");
	ПростыеТипы.Вставить("v8:ValueStorage", "ХранилищеЗначения");
	ПростыеТипы.Вставить("v8:UUID", "УникальныйИдентификатор");

	
	ТипыСсылок = Новый Соответствие;
	ТипыСсылок.Вставить("cfg:ExchangePlanRef", "ПланОбмена");
	ТипыСсылок.Вставить("cfg:CatalogRef", "Справочник");
	ТипыСсылок.Вставить("cfg:DocumentRef", "Документ");
	ТипыСсылок.Вставить("cfg:EnumRef", "Перечисление");
	//ТипыСсылок.Вставить("cfg:Characteristic", "");
	ТипыСсылок.Вставить("cfg:ChartOfCharacteristicTypesRef", "ПланВидовХарактеристик");
	ТипыСсылок.Вставить("cfg:ChartOfAccountsRef", "ПланСчетов");
	ТипыСсылок.Вставить("cfg:ChartOfCalculationTypesRef", "ПланВидовРасчета");
	ТипыСсылок.Вставить("cfg:BusinessProcessRef", "БизнесПроцесс");
	ТипыСсылок.Вставить("cfg:TaskRef", "Задача");
	
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

Функция ПрочитатьСоответствие(ЧтениеXML)
	
	СоответствиеСвойств = Новый Соответствие;
	
	ИмяЭлемента = ЧтениеXML.Имя;
	
	ЧтениеXML.Прочитать();
	Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, ИмяЭлемента) Цикл
		ИмяСвойства = ЧтениеXML.Имя;
		ЗначениеСвойства = ПрочитатьЗначениеXML(ЧтениеXML);
		Если ЗначениеЗаполнено(ЗначениеСвойства) Тогда
			СоответствиеСвойств.Вставить(ИмяСвойства, ЗначениеСвойства);
		КонецЕсли;
	КонецЦикла;
	ЧтениеXML.Прочитать();
	
	Возврат СоответствиеСвойств;
	
КонецФункции

Функция ПрочитатьPropertiesXML(ЧтениеXML, СписокПолей)
	
	ОписаниеЭлемента = Новый Структура(СписокПолей);
	
	ПропуститьДоУзлаXML(ЧтениеXML, "Properties");
	ЧтениеXML.Прочитать();
	
	Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "Properties") Цикл
		Если ЭтоУзелXML(ЧтениеXML, "Content") И ОписаниеЭлемента.Свойство(ЧтениеXML.Имя) Тогда
			ЧтениеXML.Прочитать();
			ЭлементыСостав = Новый Массив;
			Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "Content") Цикл
				ЭлементСостава = ПрочитатьСоответствие(ЧтениеXML);
				ЭлементыСостав.Добавить(ЭлементСостава);
			КонецЦикла;
			ЧтениеXML.Прочитать();
			ОписаниеЭлемента.Content = ЭлементыСостав;
		Иначе
			ПрочитатьСвойствоСтруктуры(ЧтениеXML, ОписаниеЭлемента);
		КонецЕсли;
	КонецЦикла;
	ЧтениеXML.Прочитать();
	
	Возврат ОписаниеЭлемента;
	
КонецФункции

Функция ПрочитатьAttribute(ЧтениеXML, ТаблицаМетаданных, ПолноеИмяТЧ)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "Attribute") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Пока ЭтоУзелXML(ЧтениеXML, "Attribute") Цикл
		ЧтениеXML.Прочитать();
		ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, "Name,Type");
		ЧтениеXML.Прочитать();
		
		СтрокаМетаданных = ТаблицаМетаданных.Добавить();
		СтрокаМетаданных.КорневойТип = ПолноеИмяТЧ + "Реквизит";
		СтрокаМетаданных.ПолноеИмя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Тип = ОписаниеЭлемента.Type;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Функция ПрочитатьDimension(ЧтениеXML, ТаблицаМетаданных)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "Dimension") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Пока ЭтоУзелXML(ЧтениеXML, "Dimension") Цикл
		ЧтениеXML.Прочитать();
		ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, "Name,Type");
		ЧтениеXML.Прочитать();
		
		СтрокаМетаданных = ТаблицаМетаданных.Добавить();
		СтрокаМетаданных.КорневойТип = "Измерение";
		СтрокаМетаданных.ПолноеИмя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Тип = ОписаниеЭлемента.Type;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Функция ПрочитатьResource(ЧтениеXML, ТаблицаМетаданных)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "Resource") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Пока ЭтоУзелXML(ЧтениеXML, "Resource") Цикл
		ЧтениеXML.Прочитать();
		ОписаниеЭлемента = ПрочитатьPropertiesXML(ЧтениеXML, "Name,Type");
		ЧтениеXML.Прочитать();
		
		СтрокаМетаданных = ТаблицаМетаданных.Добавить();
		СтрокаМетаданных.КорневойТип = "Ресурс";
		СтрокаМетаданных.ПолноеИмя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Имя = ОписаниеЭлемента.Name;
		СтрокаМетаданных.Тип = ОписаниеЭлемента.Type;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Функция ПрочитатьTabularSection(ЧтениеXML, ТаблицаМетаданных, ПолноеИмяОбъекта)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "TabularSection") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Пока ЭтоУзелXML(ЧтениеXML, "TabularSection") Цикл
		
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
		
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Функция ПрочитатьTemplate(ЧтениеXML, ТаблицаМетаданных)
	
	Если НЕ ЭтоУзелXML(ЧтениеXML, "Template") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Пока ЭтоУзелXML(ЧтениеXML, "Template") Цикл
		ИмяМакета = ПрочитатьЗначениеXML(ЧтениеXML);
		
		СтрокаМетаданных = ТаблицаМетаданных.Добавить();
		СтрокаМетаданных.КорневойТип = "Макет";
		СтрокаМетаданных.ПолноеИмя = ИмяМакета;
		СтрокаМетаданных.Имя = ИмяМакета;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Процедура ДобавитьОбщиеРеквизиты(Настройки, ТаблицаМетаданных, ПолноеИмяОбъекта)
	
	ОбщиеРеквизитыОбъектов = ПолучитьВсеОбщиеРеквизиты(Настройки);
	Если ОбщиеРеквизитыОбъектов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого СтрокаРеквизита Из ОбщиеРеквизитыОбъектов Цикл
		Если (СтрокаРеквизита.АвтоИсп И СтрокаРеквизита.Состав.Найти(ПолноеИмяОбъекта) = Неопределено)
		 ИЛИ (НЕ СтрокаРеквизита.АвтоИсп И НЕ СтрокаРеквизита.Состав.Найти(ПолноеИмяОбъекта) = Неопределено) Тогда
			СтрокаМетаданных = ТаблицаМетаданных.Добавить();
			СтрокаМетаданных.КорневойТип = "ОбщиеРеквизиты";
			СтрокаМетаданных.ПолноеИмя = СтрокаРеквизита.Имя;
			СтрокаМетаданных.Имя = СтрокаРеквизита.Имя;
			СтрокаМетаданных.Тип = СтрокаРеквизита.Тип;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

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
	
	ТекстФайл = Новый Файл(ПолноеИмяФайла);
	Если НЕ ТекстФайл.Существует() Тогда
		Возврат;
	КонецЕсли;
	
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

Функция ЗаполнитьОбщиеРеквизитыПоФайлам(Настройки)
	
	Разделитель = ПолучитьРазделительПути();
	
	МетаданныеРодителя = Новый Соответствие;
	МетаданныеРодителя.Вставить("Конфигурация", Настройки.Конфигурация);
	
	ТаблицаОбщихРеквизитов = Новый ТаблицаЗначений;
	ТаблицаОбщихРеквизитов.Колонки.Добавить("Имя");
	ТаблицаОбщихРеквизитов.Колонки.Добавить("Тип");
	ТаблицаОбщихРеквизитов.Колонки.Добавить("АвтоИсп");
	ТаблицаОбщихРеквизитов.Колонки.Добавить("Состав");
	
	СтрокаКорневогоТипа = ПоискКорневогоТипа(Настройки.КорневыеТипы, "ОбщийРеквизит", "Ед");
	НайденныеОбъекты = ПолучитьКоллекциюОбъектов(МетаданныеРодителя, "ОбщийРеквизит", Настройки);
	Для Каждого СтрокаКоллекции Из НайденныеОбъекты Цикл
		ИмяФайла = Настройки.КаталогИсходныхФайлов + Разделитель +
			СтрокаКорневогоТипа.МнEng + Разделитель + СтрокаКоллекции .Имя + ".xml";
		ОписаниеРеквизита = ОписаниеМетаданныхОбъектаПоФайлу(ИмяФайла, "Type,AutoUse,Content");
		
		СтрокаРеквизита = ТаблицаОбщихРеквизитов.Добавить();
		СтрокаРеквизита.Имя = СтрокаКоллекции.Имя;
		СтрокаРеквизита.Тип = ОписаниеРеквизита.Type;
		СтрокаРеквизита.АвтоИсп = ОписаниеРеквизита.AutoUse = "Use";
		СтрокаРеквизита.Состав = Новый Массив;
		
		Для Каждого ЭлементСостава Из ОписаниеРеквизита.Content Цикл
			Если (СтрокаРеквизита.АвтоИсп И ЭлементСостава["xr:Use"] = "DontUse")
			 ИЛИ (НЕ СтрокаРеквизита.АвтоИсп И ЭлементСостава["xr:Use"] = "Use") Тогда
				МассивФрагментов = ирОбщий.СтрРазделитьЛкс(ЭлементСостава["xr:Metadata"], ".");
				СтрокаКорневогоТипаСостава = ПоискКорневогоТипа(Настройки.КорневыеТипы, МассивФрагментов[0], "ЕдEng");
				Если СтрокаКорневогоТипаСостава = Неопределено Тогда
					Сообщить("Не найден корневой тип элемента состава " + МассивФрагментов[0]);
				Иначе
					СтрокаРеквизита.Состав.Добавить(СтрокаКорневогоТипаСостава.Ед + "." + МассивФрагментов[1]);
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат ТаблицаОбщихРеквизитов;
	
КонецФункции

Функция ЗаполнитьМетаданныеПоФайлу(Настройки, ИмяФайла, ПолноеИмяОбъекта)
	
	ТаблицаМетаданных = Новый ТаблицаЗначений;
	ТаблицаМетаданных.Колонки.Добавить("КорневойТип"); // Вид объекта - "Справочник", "Реквизит", "ТабличнаяЧасть", "ТабличнаяЧасть.<имя ТЧ>.Реквизит"
	ТаблицаМетаданных.Колонки.Добавить("ПолноеИмяРодителя"); // Метаданные родителя для подчиненных коллекций (реквизитов ТЧ, измерений, ...) - "ТабличнаяЧасть.<имя ТЧ>"
	ТаблицаМетаданных.Колонки.Добавить("ПолноеИмя"); // Полное имя - "Справочник.Валюты", "<имя реквизита>", "ТабличнаяЧасть.<имя ТЧ>", "<имя реквизита ТЧ>"
	ТаблицаМетаданных.Колонки.Добавить("Имя"); // имя - "Валюты", "<имя реквизита>", "<имя ТЧ>", "<имя реквизита ТЧ>"
	ТаблицаМетаданных.Колонки.Добавить("Тип"); // Массив типов. Элементы: для простых типов - Тип, для ссылочных - строка
	
	Разделитель = ПолучитьРазделительПути();
	
	ПолноеИмяФайла = Настройки.КаталогИсходныхФайлов + Разделитель + ИмяФайла + ".xml";
	
	ЧтениеXML = ОткрытьФайлМетаданных(ПолноеИмяФайла);
	
	Если ИмяФайла = "Configuration" Тогда
		
		ПропуститьДоУзлаXML(ЧтениеXML, "ChildObjects");
		ЧтениеXML.Прочитать();
		
		Пока НЕ ЭтоКонецУзлаXML(ЧтениеXML, "ChildObjects") Цикл
			СтрокаКорневогоТипа = ПоискКорневогоТипа(Настройки.КорневыеТипы, ЧтениеXML.Имя, "ЕдEng");
			ИмяОбъекта = ПрочитатьЗначениеXML(ЧтениеXML);
			Если СтрокаКорневогоТипа <> Неопределено Тогда
				КорневойТип = СтрокаКорневогоТипа.Ед;
				//ТЕСТ
				Если КорневойТип = "ОбщийМодуль" Тогда
					ИмяФайлаОбъекта = Настройки.КаталогИсходныхФайлов + Разделитель +
						СтрокаКорневогоТипа.МнEng + Разделитель + ИмяОбъекта + ".xml";
					Если ОписаниеМетаданныхОбъектаПоФайлу(ИмяФайлаОбъекта, "Global").Global Тогда
						Продолжить; // глобальные модулм не добавляются в метаданные
					КонецЕсли;
				КонецЕсли;
				//ТЕСТ
				
				СтрокаМетаданных = ТаблицаМетаданных.Добавить();
				СтрокаМетаданных.КорневойТип = КорневойТип;
				СтрокаМетаданных.ПолноеИмя = КорневойТип + "." + ИмяОбъекта;
				СтрокаМетаданных.Имя = ИмяОбъекта;
				
				Если КорневойТип = "ПараметрСеанса" Тогда
					// Прочитать тип метаданных
					ИмяФайлаОбъекта = Настройки.КаталогИсходныхФайлов + Разделитель +
						СтрокаКорневогоТипа.МнEng + Разделитель + ИмяОбъекта + ".xml";
					СтрокаМетаданных.Тип = ОписаниеМетаданныхОбъектаПоФайлу(ИмяФайлаОбъекта, "Type").Type;
				КонецЕсли;
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
			   И НЕ ПрочитатьTemplate(ЧтениеXML, ТаблицаМетаданных)
			Тогда
				ПропуститьТекущийУзелXML(ЧтениеXML);
			КонецЕсли;
		КонецЦикла;
		
		МассивФрагментов = ирОбщий.СтрРазделитьЛкс(ПолноеИмяОбъекта);
		СтрокаКорневогоТипа = ПоискКорневогоТипа(Настройки.КорневыеТипы, МассивФрагментов[0], "Ед");
		
		Если СтрокаКорневогоТипа.ЕстьПредопределенные Тогда
			ИмяФайлаОбъекта = Настройки.КаталогИсходныхФайлов + Разделитель +
				СтрокаКорневогоТипа.МнEng + Разделитель + МассивФрагментов[1] + Разделитель + "Ext" + Разделитель + "Predefined.xml";
			ЗагрузитьПредопределенныеЗначенияОбъектаПоФайлу(ТаблицаМетаданных, ИмяФайлаОбъекта, ПолноеИмяОбъекта);
		КонецЕсли;
		
		Если СтрокакорневогоТипа.ЕстьОбщийРеквизит Тогда
			ДобавитьОбщиеРеквизиты(Настройки, ТаблицаМетаданных, ПолноеИмяОбъекта);
		КонецЕсли;
	КонецЕсли;
	
	ЧтениеXML.Закрыть();
	
	Возврат ТаблицаМетаданных;
	
КонецФункции

Процедура ОбеспечитьКаталог(КорневойКаталог, ПолноеИмяФайла)
	
	Разделитель = ПолучитьРазделительПути();
	КаталогФайла = КорневойКаталог + Разделитель;
	
	ЧастиФайла = СтроковыеФункции.РазложитьСтрокуВМассивПодстрок(Сред(ПолноеИмяФайла, СтрДлина(КорневойКаталог) + 2), Разделитель);
	Для ИндексКаталога = 0 По ЧастиФайла.Количество() - 2 Цикл
		КаталогФайла = КаталогФайла + ЧастиФайла[ИндексКаталога] + Разделитель;
		ТестКаталог = Новый Файл(КаталогФайла);
		Если НЕ ТестКаталог.Существует() ИЛИ НЕ ТестКаталог.ЭтоКаталог() Тогда
			СоздатьКаталог(КаталогФайла);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

