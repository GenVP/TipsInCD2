﻿//ирПортативный Перем ирПортативный Экспорт;
//ирПортативный Перем ирОбщий Экспорт;
//ирПортативный Перем ирСервер Экспорт;
//ирПортативный Перем ирКэш Экспорт;
//ирПортативный Перем ирПривилегированный Экспорт;

Процедура ОбновитьНайденныеСсылки(МассивСсылок, СсылкиНаОбъект = Неопределено, ИскатьСовместные = Ложь) Экспорт

	#Если Сервер И Не Сервер Тогда
		МассивСсылок = Новый Массив;
	#КонецЕсли
	Если СсылкиНаОбъект = Неопределено Тогда
		СсылкиНаОбъект = ЭтотОбъект.СсылкиНаОбъект;
	КонецЕсли; 
	НайденныеСсылки = Новый ТаблицаЗначений;
	#Если Клиент Тогда
	Состояние("Поиск ссылок...");
	#КонецЕсли 
	ирПривилегированный.НайтиПоСсылкамЛкс(МассивСсылок, НайденныеСсылки);
	#Если Клиент Тогда
	Состояние("");
	#КонецЕсли
	#Если Сервер И Не Сервер Тогда
		НайденныеСсылки = Новый ТаблицаЗначений;
	#КонецЕсли
	Если ИскатьСовместные И МассивСсылок.Количество() > 1 Тогда
		ИтогиПоДанным = НайденныеСсылки.Скопировать(, "Данные, Метаданные");
		ИтогиПоДанным.Колонки.Добавить("Количество");
		ИтогиПоДанным.ЗаполнитьЗначения(1, "Количество");
		ИтогиПоДанным.Свернуть("Данные, Метаданные", "Количество");
		КоличествоИскомыхСсылок = МассивСсылок.Количество();
		СоответствиеДанных = Новый Соответствие;
		Для Каждого СтрокаИтога Из ИтогиПоДанным Цикл
			Если СтрокаИтога.Количество = КоличествоИскомыхСсылок Тогда
				Если СтрокаИтога.Данные = Неопределено Тогда
					КлючСоответствия = СтрокаИтога.Метаданные;
				Иначе
					КлючСоответствия = СтрокаИтога.Данные;
				КонецЕсли; 
				СоответствиеДанных[КлючСоответствия] = 1;
			КонецЕсли;
		КонецЦикла;
		ИтогиПоДанным = Неопределено;
	КонецЕсли; 
	СсылкиНаОбъект.Очистить();
	Для Каждого СтрокаНайденного Из НайденныеСсылки Цикл
		Если СоответствиеДанных <> Неопределено Тогда  
			Если СтрокаНайденного.Данные = Неопределено Тогда
				КлючСоответствия = СтрокаНайденного.Метаданные;
			Иначе
				КлючСоответствия = СтрокаНайденного.Данные;
			КонецЕсли; 
			Если СоответствиеДанных[КлючСоответствия] <> Неопределено Тогда
				СоответствиеДанных[КлючСоответствия] = Неопределено;
			Иначе
				Продолжить;
			КонецЕсли;
			ИскомаяСсылка = Неопределено;
		Иначе
			ИскомаяСсылка = СтрокаНайденного.Ссылка;
		КонецЕсли; 
		СтрокаТЧ = СсылкиНаОбъект.Добавить();
		НайденнаяСсылка = ЗначениеИзСтрокиВнутр(СтрокаНайденного.Данные);
		СтрокаТЧ.Метаданные = СтрокаНайденного.Метаданные;
		КорневойТипСсылки = ирОбщий.ПервыйФрагментЛкс(СтрокаТЧ.Метаданные);
		Если КорневойТипСсылки = "РегистрСведений" Тогда 
			СтрокаТЧ.Данные = СтрокаНайденного.Данные;
		Иначе
			СтрокаТЧ.Данные = НайденнаяСсылка;
		КонецЕсли;
		Если НайденнаяСсылка = Неопределено Тогда
			НайденнаяСсылка = СтрокаТЧ.Метаданные;
		КонецЕсли; 
		МетаданныеСсылки = Метаданные.НайтиПоПолномуИмени(СтрокаТЧ.Метаданные);
		СтрокаТЧ.ТипДанных = МетаданныеСсылки.Представление();
		СтрокаТЧ.Ссылка = ИскомаяСсылка;
		СтрокаТЧ.ТипМетаданных = ирОбщий.ПервыйФрагментЛкс(СтрокаТЧ.Метаданные);
		СтрокаТЧ.Пометка = 1;
	КонецЦикла;
	
КонецПроцедуры // ОбновитьНайденныеСсылки()

Процедура ОткрытьСсылающийсяОбъектВРедактореОбъектаБД(ТекущаяСтрока, ИскомаяСсылка = Неопределено) Экспорт
	
	Если ИскомаяСсылка = Неопределено Тогда
		ИскомаяСсылка = ТекущаяСтрока.Ссылка;
	КонецЕсли; 
	Если ирОбщий.ЛиКорневойТипСсылочногоОбъектаБДЛкс(ТекущаяСтрока.ТипМетаданных) Тогда
		КлючОбъекта = ТекущаяСтрока.Данные;
	ИначеЕсли ирОбщий.ЛиКорневойТипКонстантыЛкс(ТекущаяСтрока.ТипМетаданных) Тогда
		КлючОбъекта = ирОбщий.ОбъектБДПоКлючуЛкс(ТекущаяСтрока.Метаданные);
	Иначе // Регистр сведений
		КлючОбъекта = ирОбщий.ОбъектБДПоКлючуЛкс(ТекущаяСтрока.Метаданные, ЗначениеИзСтрокиВнутр(ТекущаяСтрока.Данные));
	КонецЕсли; 
	ирОбщий.ОткрытьСсылкуВРедактореОбъектаБДЛкс(КлючОбъекта, ИскомаяСсылка);

КонецПроцедуры

Функция РедактироватьМодифицированныйОбъект(ОбъектБД, пИскомоеЗначение = Неопределено, КлючУникальности = Неопределено) Экспорт 

	Форма = ПолучитьФорму(,, КлючУникальности);
	ЭтотОбъект.ПараметрКлючИлиОбъект = ОбъектБД;
	ЭтотОбъект.ПараметрПрочитатьОбъект = Ложь;
	ЭтотОбъект.ПараметрИскомоеЗначение = пИскомоеЗначение;
	Форма.Открыть();
	Возврат Форма;

КонецФункции

//ирПортативный лФайл = Новый Файл(ИспользуемоеИмяФайла);
//ирПортативный ПолноеИмяФайлаБазовогоМодуля = Лев(лФайл.Путь, СтрДлина(лФайл.Путь) - СтрДлина("Модули\")) + "ирПортативный.epf";
//ирПортативный #Если Клиент Тогда
//ирПортативный 	Контейнер = Новый Структура();
//ирПортативный 	Оповестить("ирПолучитьБазовуюФорму", Контейнер);
//ирПортативный 	Если Не Контейнер.Свойство("ирПортативный", ирПортативный) Тогда
//ирПортативный 		ирПортативный = ВнешниеОбработки.ПолучитьФорму(ПолноеИмяФайлаБазовогоМодуля);
//ирПортативный 		ирПортативный.Открыть();
//ирПортативный 	КонецЕсли; 
//ирПортативный #Иначе
//ирПортативный 	ирПортативный = ВнешниеОбработки.Создать(ПолноеИмяФайлаБазовогоМодуля, Ложь); // Это будет второй экземпляр объекта
//ирПортативный #КонецЕсли
//ирПортативный ирОбщий = ирПортативный.ПолучитьОбщийМодульЛкс("ирОбщий");
//ирПортативный ирКэш = ирПортативный.ПолучитьОбщийМодульЛкс("ирКэш");
//ирПортативный ирСервер = ирПортативный.ПолучитьОбщийМодульЛкс("ирСервер");
//ирПортативный ирПривилегированный = ирПортативный.ПолучитьОбщийМодульЛкс("ирПривилегированный");

ЭтотОбъект.ПараметрПрочитатьОбъект = Истина;
ЭтотОбъект.СвязиИПараметрыВыбора = Истина;
ЭтотОбъект.ТолькоПростойТип = Истина;