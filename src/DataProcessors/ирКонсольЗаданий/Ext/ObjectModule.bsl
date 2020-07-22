﻿//ирПортативный Перем ирПортативный Экспорт;
//ирПортативный Перем ирОбщий Экспорт;
//ирПортативный Перем ирСервер Экспорт;
//ирПортативный Перем ирКэш Экспорт;
//ирПортативный Перем ирПривилегированный Экспорт;

Перем ТаблицаАктивныхФоновыхЗаданий Экспорт;

Функция ДлительностьФоновогоЗадания(ФоновоеЗадание) Экспорт 
	
	#Если Сервер И Не Сервер Тогда
		ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору();
	#КонецЕсли
	Если Не ЗначениеЗаполнено(ФоновоеЗадание.Конец) Тогда
		Длительность = ТекущаяДата() - ФоновоеЗадание.Начало;
	Иначе
		Длительность = ФоновоеЗадание.Конец - ФоновоеЗадание.Начало;
	КонецЕсли; 
	Возврат Длительность;
	
КонецФункции

Процедура ОбновитьСтрокуФоновогоЗадания(Знач СтрокаСпискаФоновыхЗаданий, Знач ФоновоеЗадание = Неопределено, Знач Длительность = Неопределено) Экспорт 
	
	Если ФоновоеЗадание = Неопределено Тогда
		ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(Новый УникальныйИдентификатор(СтрокаСпискаФоновыхЗаданий.Идентификатор));
	КонецЕсли; 
	Если Длительность = Неопределено Тогда
		Длительность = ДлительностьФоновогоЗадания(ФоновоеЗадание);
	КонецЕсли; 
	СтрокаСпискаФоновыхЗаданий.Наименование = ФоновоеЗадание.Наименование;
	СтрокаСпискаФоновыхЗаданий.Ключ = ФоновоеЗадание.Ключ;
	СтрокаСпискаФоновыхЗаданий.ИмяМетода = ФоновоеЗадание.ИмяМетода;
	СтрокаСпискаФоновыхЗаданий.Начало = ФоновоеЗадание.Начало;
	СтрокаСпискаФоновыхЗаданий.Конец = ФоновоеЗадание.Конец;
	СтрокаСпискаФоновыхЗаданий.Длительность = Длительность;
	СтрокаСпискаФоновыхЗаданий.Сервер = ФоновоеЗадание.Расположение;
	Если ФоновоеЗадание.ИнформацияОбОшибке <> Неопределено Тогда
		СтрокаСпискаФоновыхЗаданий.Ошибка = ПодробноеПредставлениеОшибки(ФоновоеЗадание.ИнформацияОбОшибке);
	КонецЕсли;
	Если ФоновоеЗадание.Состояние = СостояниеФоновогоЗадания.Активно Тогда
		СтрокаАктивногоФоновогоЗадания = ТаблицаАктивныхФоновыхЗаданий.Найти(ФоновоеЗадание.УникальныйИдентификатор, "Идентификатор");
		Если СтрокаАктивногоФоновогоЗадания <> Неопределено Тогда
			СтрокаСпискаФоновыхЗаданий.НомерСеанса = СтрокаАктивногоФоновогоЗадания.НомерСеанса;
			СтрокаСпискаФоновыхЗаданий.НомерСоединения = СтрокаАктивногоФоновогоЗадания.НомерСоединения;
		КонецЕсли; 
	КонецЕсли; 
	СтрокаСпискаФоновыхЗаданий.Идентификатор = ФоновоеЗадание.УникальныйИдентификатор;
	СтрокаСпискаФоновыхЗаданий.СостояниеЗадания = ФоновоеЗадание.Состояние;
	СтрокаСпискаФоновыхЗаданий.СостояниеПредставление = ФоновоеЗадание.Состояние;
	СтрокаСпискаФоновыхЗаданий.РазделениеДанных = ФоновоеЗадание.РазделениеДанных;
	СтрокаСпискаФоновыхЗаданий.РазделениеДанныхПредставление = ирОбщий.РасширенноеПредставлениеЗначенияЛкс(ФоновоеЗадание.РазделениеДанных);

КонецПроцедуры

Функция ОтборДляЖурналаПоСтрокеЗадания(Знач ТекущаяСтрока) Экспорт 
	
	СтруктураОтбора = Новый Структура;
	СтруктураОтбора.Вставить("ИмяПриложения", "BackgroundJob");
	Если ЗначениеЗаполнено(ТекущаяСтрока.НомерСеанса) Тогда
		СтруктураОтбора.Вставить("Сеанс", ТекущаяСтрока.НомерСеанса);
	КонецЕсли;
	Возврат СтруктураОтбора;

КонецФункции

Процедура ОткрытьОшибкиЖРПоЗаданию(Знач ВыбраннаяСтрока) Экспорт 
	
	СтруктураОтбора = ОтборДляЖурналаПоСтрокеЗадания(ВыбраннаяСтрока);
	СтруктураОтбора.Вставить("Уровень", "Ошибка");
	АнализЖурналаРегистрации = ирОбщий.ПолучитьОбъектПоПолномуИмениМетаданныхЛкс("Обработка.ирАнализЖурналаРегистрации");
	#Если Сервер И Не Сервер Тогда
		АнализЖурналаРегистрации = Обработки.ирАнализЖурналаРегистрации.Создать();
	#КонецЕсли
	АнализЖурналаРегистрации.ОткрытьСОтбором(ВыбраннаяСтрока.Начало, ВыбраннаяСтрока.Конец, СтруктураОтбора);

КонецПроцедуры

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

