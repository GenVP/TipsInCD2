﻿
Функция ВсеКорневыеТипы()
	
	СоответствиеТипов = гл_кдКэш()["КорневыеТипы"];
	Если СоответствиеТипов = Неопределено Тогда
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
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "ОпределяемыйТип";
		СтрокаТЗ.ЕдEng = "DefinedType";
		СтрокаТЗ.МнEng = "DefinedTypes";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "Модуль";
		СтрокаТЗ.ЕдEng = "Module";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульМенеджера";
		СтрокаТЗ.ЕдEng = "ManagerModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульОбъекта";
		СтрокаТЗ.ЕдEng = "ObjectModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульКоманды";
		СтрокаТЗ.ЕдEng = "CommandModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульНабораЗаписей";
		СтрокаТЗ.ЕдEng = "RecordSetModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульМенеджераЗначения";
		СтрокаТЗ.ЕдEng = "ValueManagerModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульСеанса";
		СтрокаТЗ.ЕдEng = "SessionModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульВнешнегоСоединения";
		СтрокаТЗ.ЕдEng = "ExternalConnectionModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульУправляемогоПриложения";
		СтрокаТЗ.ЕдEng = "ManagedApplicationModule";
		
		СтрокаТЗ = СоответствиеТипов.Добавить();
		СтрокаТЗ.Ед = "МодульОбычногоПриложения";
		СтрокаТЗ.ЕдEng = "OrdinaryApplicationModule";
		
		гл_кдКэш()["КорневыеТипы"] = СоответствиеТипов;
		
	КонецЕсли;
	
	Возврат СоответствиеТипов;
	
КонецФункции

Функция ПолучитьКоллекциюОбъектов(МетаданныеРодителя, ИмяКоллекции, Настройки = Неопределено) Экспорт
	
	//+ТЕСТ
	Если гл_кдКэш()["РежимОтладки"] Тогда
		_НачалоЗамера = ТекущаяУниверсальнаяДатаВМиллисекундах();
	КонецЕсли;
	//-ТЕСТ
	
	ТаблицаМетаданных = ПолучитьТаблицуМетаданных(Настройки, МетаданныеРодителя, ИмяКоллекции);
	
	Если ИмяКоллекции = "Метод" Тогда
		НайденныеОбъекты = ТаблицаМетаданных;
	Иначе
		ОтборОбъектов = Новый Структура("КорневойТип", ИмяКоллекции);
		Если ИмяКоллекции = "Макет" И МетаданныеРодителя["ПолноеИмя"] = Неопределено Тогда
			ОтборОбъектов.КорневойТип = "ОбщийМакет"; // Особенность ИР
		КонецЕсли;
		НайденныеОбъекты = ТаблицаМетаданных.НайтиСтроки(ОтборОбъектов);
	КонецЕсли;
	
	//+ТЕСТ
	Если гл_кдКэш()["РежимОтладки"] Тогда
		_КонецЗамера = ТекущаяУниверсальнаяДатаВМиллисекундах();
		_ПолноеИмя = Строка(МетаданныеРодителя["ПолноеИмяРодителя"]);
		Если ПустаяСтрока(_ПолноеИмя) Тогда
			_ПолноеИмя = Строка(МетаданныеРодителя["ПолноеИмя"]);
		КонецЕсли;
		Сообщить("Время получения " + ИмяКоллекции + " " + _ПолноеИмя + ": " + (_КонецЗамера - _НачалоЗамера));
	КонецЕсли;
	//+ТЕСТ
	
	Возврат НайденныеОбъекты;
	
КонецФункции

Функция ПолучитьТаблицуМетаданных(Настройки, ОписаниеМетаданных, ИмяКоллекции) Экспорт
	
	Конфигурация = ОписаниеМетаданных["Конфигурация"];
	
	ПолноеИмяОбъекта = ОписаниеМетаданных["ПолноеИмяРодителя"];
	Если ПолноеИмяОбъекта = Неопределено Тогда
		ПолноеИмяОбъекта = ОписаниеМетаданных["ПолноеИмя"];
	КонецЕсли;
	Если ПолноеИмяОбъекта = Неопределено Тогда
		ОбъектИндекса = ИмяКоллекции; // Для коллекций конфигурации - Справочник, Документ и т.д.
	Иначе
		ОбъектИндекса = ПолноеИмяОбъекта;
	КонецЕсли;
	
	ТаблицаМетаданных = Неопределено;
	
	Если ЗагрузитьИндексМетаданныеИзКэша(Конфигурация, ОбъектИндекса, ТаблицаМетаданных) Тогда
		Возврат ТаблицаМетаданных;
	КонецЕсли;
	
	Если Настройки = Неопределено Тогда
		Настройки = ПолучитьНастройкиМетаданныхКонфигурации(Конфигурация);
	КонецЕсли;
	
	Если ЗагрузитьИндексМетаданныхИзРегистра(Настройки, ОбъектИндекса, ТаблицаМетаданных) Тогда
		Возврат ТаблицаМетаданных;
	КонецЕсли;
	
	ИмяФайла = кдМетаданныеXML.ИмяФайлаПоМетаданным(Настройки, ОбъектИндекса);
	
	Если ЗагрузитьИндексМетаданныхИзФайла(Настройки, ОбъектИндекса, ИмяФайла, ТаблицаМетаданных) Тогда
		Возврат ТаблицаМетаданных;
	КонецЕсли;
	
	Если ОписаниеМетаданных["ПолноеИмя"] = "ОбщийРеквизит.#All" Тогда
		ТаблицаМетаданных = кдМетаданныеXML.ЗаполнитьОбщиеРеквизитыПоФайлам(Настройки);
	ИначеЕсли ИмяКоллекции = "Метод" Тогда
		ТаблицаМетаданных = кдМетаданныеXML.ЗаполнитьМетодыПоФайлу(Настройки, ИмяФайла, ОбъектИндекса);
	Иначе
		ТаблицаМетаданных = кдМетаданныеXML.ЗаполнитьМетаданныеПоФайлу(Настройки, ИмяФайла, ОбъектИндекса);
	КонецЕсли;
	
	Если ТаблицаМетаданных <> Неопределено Тогда
		СохранитьИндексМетаданныхВКэше(Конфигурация, ОбъектИндекса, ТаблицаМетаданных);
		СохранитьИндексМетаданныхВРегистре(Настройки, ОбъектИндекса, ТаблицаМетаданных);
		СохранитьИндексМетаданныхВФайле(Настройки, ОбъектИндекса, ИмяФайла, ТаблицаМетаданных);
	КонецЕсли;
	
	Возврат ТаблицаМетаданных;
	
КонецФункции

Функция ЗагрузитьИндексМетаданныеИзКэша(Конфигурация, ОбъектИндекса, ТаблицаМетаданных)
	
	кд_МетаданныеКонфигурация = гл_кдКэш()[Конфигурация];
	Если кд_МетаданныеКонфигурация = Неопределено Тогда
		кд_МетаданныеКонфигурация = Новый Соответствие;
		гл_кдКэш()[Конфигурация] = кд_МетаданныеКонфигурация;
	КонецЕсли;
	
	ТаблицаМетаданных = кд_МетаданныеКонфигурация[ОбъектИндекса];
	
	Возврат ТаблицаМетаданных <> Неопределено;
	
КонецФункции

Функция ЗагрузитьИндексМетаданныхИзРегистра(Настройки, ОбъектИндекса, ТаблицаМетаданных)
	
	Если Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВБазеДанных Тогда
		МенеджерМетаданных = РегистрыСведений.кд_Метаданные.СоздатьМенеджерЗаписи();
		МенеджерМетаданных.Конфигурация = Настройки.Конфигурация;
		МенеджерМетаданных.ПолноеИмя = ОбъектИндекса;
		Попытка
			МенеджерМетаданных.Прочитать();
			Если МенеджерМетаданных.Выбран() Тогда
				ТаблицаМетаданных = МенеджерМетаданных.Метаданные.Получить();
				Возврат ТаблицаМетаданных <> Неопределено;
			КонецЕсли;
		Исключение
			Сообщить("Не удалось получить индекс метаданных из БД для " + Настройки.Конфигурация + ", " + ОбъектИндекса);
		КонецПопытки;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

Функция ЗагрузитьИндексМетаданныхИзФайла(Настройки, ОбъектИндекса, ИмяФайла, ТаблицаМетаданных)
	
	Если Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВФайлах Тогда
		Если ИмяФайла = "Configuration" Тогда
			ИмяФайлаИндекса = ИмяФайла + "_" + ОбъектИндекса;
		Иначе
			ИмяФайлаИндекса = ИмяФайла;
		КонецЕсли;
		ПолноеИмяФайла = Настройки.КаталогМетаданных + ПолучитьРазделительПути() + ИмяФайлаИндекса + ".idx";
		ТестФайл = Новый Файл(ПолноеИмяФайла);
		Если ТестФайл.Существует() Тогда
			ТаблицаМетаданных = ирОбщий.ЗагрузитьЗначениеИзФайлаЛкс(ПолноеИмяФайла);
			Возврат ТаблицаМетаданных <> Неопределено;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

Процедура СохранитьИндексМетаданныхВКэше(Конфигурация, ОбъектИндекса, МетаданныеОбъекта) Экспорт
	
	кд_МетаданныеКонфигурация = гл_кдКэш()[Конфигурация];
	Если кд_МетаданныеКонфигурация = Неопределено Тогда
		кд_МетаданныеКонфигурация = Новый Соответствие;
		гл_кдКэш()[Конфигурация] = кд_МетаданныеКонфигурация;
	КонецЕсли;
	
	кд_МетаданныеКонфигурация[ОбъектИндекса] = МетаданныеОбъекта;
	
КонецПроцедуры

Процедура СохранитьИндексМетаданныхВРегистре(Настройки, ОбъектИндекса, ТаблицаМетаданных)
	
	Если Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВБазеДанных Тогда
		МенеджерМетаданных = РегистрыСведений.кд_Метаданные.СоздатьМенеджерЗаписи();
		МенеджерМетаданных.Конфигурация = Настройки.Конфигурация;
		МенеджерМетаданных.ПолноеИмя = ОбъектИндекса;
		МенеджерМетаданных.Метаданные = Новый ХранилищеЗначения(ТаблицаМетаданных);
		Попытка
			МенеджерМетаданных.Записать();
		Исключение
			Сообщить("Не удалось сохранить индекс метаданных в базе для " + МенеджерМетаданных.Конфигурация + ", " + ОбъектИндекса);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

Процедура СохранитьИндексМетаданныхВФайле(Настройки, ОбъектИндекса, ИмяФайла, ТаблицаМетаданных)
	
	Если Настройки.Индексировать = Перечисления.кд_ИндексированиеМетаданных.ВФайлах Тогда
		Если ИмяФайла = "Configuration" Тогда
			ИмяФайлаИндекса = ИмяФайла + "_" + ОбъектИндекса;
		Иначе
			ИмяФайлаИндекса = ИмяФайла;
		КонецЕсли;
		ПолноеИмяФайла = Настройки.КаталогМетаданных + ПолучитьРазделительПути() + ИмяФайлаИндекса + ".idx";
		ОбеспечитьКаталог(Настройки.КаталогМетаданных, ПолноеИмяФайла);
		ирОбщий.СохранитьЗначениеВФайлЛкс(ТаблицаМетаданных, ПолноеИмяФайла);
	КонецЕсли;
	
КонецПроцедуры

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
	
	Настройки = Новый Структура;
	Настройки.Вставить("Конфигурация", Конфигурация);
	Настройки.Вставить("КорневыеТипы", ВсеКорневыеТипы());
	Настройки.Вставить("КаталогИсходныхФайлов", Выборка.КаталогИсходныхФайлов);
	Настройки.Вставить("КаталогМетаданных", Выборка.КаталогМетаданных);
	Если ПустаяСтрока(Настройки.КаталогМетаданных) Тогда
		Настройки.КаталогМетаданных = Настройки.КаталогИсходныхФайлов;
	КонецЕсли;
	Настройки.Вставить("Индексировать", Выборка.Индексировать);
	
	Возврат Настройки;
	
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

Процедура ЗаменитьОбщиеТипы(Конфигурация, МассивТипов) Экспорт
	
	Если МассивТипов.Количество() = 1 Тогда
		Тип = МассивТипов[0];
		Если ТипЗнч(Тип) = Тип("Строка") Тогда
			
			Если Лев(Тип, 18) = "cfg:Characteristic" Тогда
				ИмяТипа = Сред(Тип, 20);
				
				МетаданныеРодителя = Новый Соответствие;
				МетаданныеРодителя.Вставить("Конфигурация", Конфигурация);
				Коллекция = кдМетаданные.ПолучитьКоллекциюОбъектов(МетаданныеРодителя, "ПланВидовХарактеристик");
				Для Каждого СтрокаКоллекции Из Коллекция Цикл
					Если СтрокаКоллекции.Имя = ИмяТипа И СтрокаКоллекции.Тип <> Неопределено Тогда
						МассивТипов.Удалить(0);
						Для Каждого НовыйТип Из СтрокаКоллекции.Тип Цикл
							МассивТипов.Добавить(НовыйТип);
						КонецЦикла;
						Возврат;
					КонецЕсли;
				КонецЦикла;
				Сообщить("Не найдено описание типа " + Тип);
				
			ИначеЕсли Лев(Тип, 15) = "cfg:DefinedType" Тогда
				//ИмяТипа = Сред(Тип, 17);
				//
				//МетаданныеРодителя = Новый Соответствие;
				//МетаданныеРодителя.Вставить("Конфигурация", Конфигурация);
				//Коллекция = кдМетаданные.ПолучитьКоллекциюОбъектов(МетаданныеРодителя, "ОпределяемыйТип");
				//Для Каждого СтрокаКоллекции Из Коллекция Цикл
				//	Если СтрокаКоллекции.Имя = ИмяТипа И СтрокаКоллекции.Тип <> Неопределено Тогда
						МассивТипов.Удалить(0);
				//		Для Каждого НовыйТип Из СтрокаКоллекции.Тип Цикл
				//			МассивТипов.Добавить(НовыйТип);
				//		КонецЦикла;
				//		Возврат;
				//	КонецЕсли;
				//КонецЦикла;
				//Сообщить("Не найдено описание типа " + Тип);
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

Функция ЗаполнитьСтруктуруТипа(СтруктураТипаСвойства, Тип, ТаблицаОбщихТипов) Экспорт
	
	КорневойТип = ирОбщий.ПервыйФрагментЛкс(Тип);
	
	СтрокаТипа = ВсеКорневыеТипы().Найти(КорневойТип, "Ед");
	Если СтрокаТипа = Неопределено Тогда
		Сообщить("Не известный тип: " + Тип);
		Возврат Ложь;
	КонецЕсли;
	
	СтрокаОбщегоТипа = ТаблицаОбщихТипов.Найти(СтрокаТипа.Ед + "Ссылка", "БазовыйТип");
	
	ОписаниеМетаданных = Новый Соответствие;
	ОписаниеМетаданных.Вставить("ПолноеИмя", Тип);
	
	СтруктураТипаСвойства.Метаданные = ОписаниеМетаданных;
	СтруктураТипаСвойства.ИмяОбщегоТипа = СтрокаОбщегоТипа.Слово;
	
	Возврат Истина;
	
КонецФункции