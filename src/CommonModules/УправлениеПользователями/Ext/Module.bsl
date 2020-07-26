﻿
// Функция возвращает значение по умолчанию для передаваемого пользователя и настройки.
//
// Параметры:
//  Пользователь - текущий пользователь программы
//  Настройка    - признак, для которого возвращается значение по умолчанию
//
// Возвращаемое значение:
//  Значение по умолчанию для настройки.
//
Функция ПолучитьЗначениеПоУмолчанию(Пользователь, Настройка, ПустоеЗначение = Ложь) Экспорт

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	Запрос.УстановитьПараметр("Настройка"   , Настройка);
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ПолноеИмяФайла КАК Значение
	|ИЗ
	|	РегистрСведений.ФайлыПользователей КАК РегистрЗначениеПрав
	|
	|ГДЕ
	|	Пользователь = &Пользователь
	| И ТипФайла    = &Настройка";

	Выборка = Запрос.Выполнить().Выбрать();

	Если Выборка.Количество() = 0 Тогда
		
		Если Настройка = "ОткрыватьПриЗапускеПанельФункций" Тогда
			Возврат Истина;
		
		ИначеЕсли Настройка = "ПоказыватьОписанияПанелиФункций" Тогда
			Возврат Ложь;
			
		КонецЕсли;
		
		Возврат ПустоеЗначение;

	ИначеЕсли Выборка.Следующий() Тогда

		Если НЕ ЗначениеЗаполнено(Выборка.Значение) Тогда
			Возврат ПустоеЗначение;
		Иначе
			
			Если ПустаяСтрока(Выборка.Значение) Тогда
				Возврат ПустоеЗначение;
			Иначе
				Возврат Выборка.Значение;
			КонецЕсли;
			
		КонецЕсли;

	Иначе
		Возврат ПустоеЗначение;

	КонецЕсли;

КонецФункции

// Функция возвращает булево значение по умолчанию для передаваемого пользователя и настройки.
//
// Параметры:
//  Пользователь - текущий пользователь программы
//  Настройка    - признак, для которого возвращается значение по умолчанию
//
// Возвращаемое значение:
//  Значение по умолчанию для настройки.
//
Функция ПолучитьБулевоЗначениеПоУмолчанию(Пользователь, Настройка, ЗначениеПоУмолчанию = Ложь) Экспорт
	
	ТекстЗапроса = "
	|ВЫБРАТЬ
	|	ФайлыПользователей.ЗначениеНастройки КАК ЗначениеНастройки
	|ИЗ
	|	РегистрСведений.ФайлыПользователей КАК ФайлыПользователей
	|ГДЕ
	|	  ФайлыПользователей.Пользователь = &Пользователь
	|	И ФайлыПользователей.ТипФайла     = &ТипФайла
	|";
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Пользователь", Пользователь);
	Запрос.УстановитьПараметр("ТипФайла",     Настройка);
	Запрос.Текст = ТекстЗапроса;
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		
		Возврат ЗначениеПоУмолчанию;
		
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.ЗначениеНастройки;
КонецФункции

// Процедура записывает значение по умолчанию для передаваемого пользователя и настройки.
//
// Параметры:
//  Пользователь - текущий пользователь программы
//  Настройка    - признак, для которого записывается значение по умолчанию
//  Значение     - значение по умолчанию (Строка)
//
// Возвращаемое значение:
//  Нет
//
Процедура УстановитьЗначениеПоУмолчанию(Пользователь, Настройка, Значение) Экспорт

	МенеджерЗаписи = РегистрыСведений.ФайлыПользователей.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Пользователь = Пользователь;
	МенеджерЗаписи.ТипФайла = Настройка;
	МенеджерЗаписи.ПолноеИмяФайла = Строка(Значение);
	МенеджерЗаписи.Записать(Истина);

КонецПроцедуры

// Процедура записывает булево значение по умолчанию для передаваемого пользователя и настройки.
//
// Параметры:
//  Пользователь - текущий пользователь программы
//  Настройка    - признак, для которого записывается значение по умолчанию
//  Значение     - значение по умолчанию (Булево)
//
// Возвращаемое значение:
//  Нет
//
Процедура УстановитьБулевоЗначениеПоУмолчанию(Пользователь, Настройка, Значение) Экспорт

	МенеджерЗаписи = РегистрыСведений.ФайлыПользователей.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Пользователь      = Пользователь;
	МенеджерЗаписи.ТипФайла          = Настройка;
	МенеджерЗаписи.ЗначениеНастройки = Значение;
	МенеджерЗаписи.Записать(Истина);

КонецПроцедуры
