﻿&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	#Если ВебКлиент Тогда
		Сообщить("Команда недоступна в вебклиенте");
	#Иначе
		ОткрытьФорму("Обработка.ирПортативный.Форма.ПерезапускСеансаУправляемая");
	#КонецЕсли 

КонецПроцедуры
