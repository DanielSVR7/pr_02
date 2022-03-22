use master;
GO
    /*** Создание базы данных ***/
if DB_ID('College') is NOT NULL
	drop database College;		
GO
create database College;			
GO

use College;

	/*** Создание таблицы Users ***/
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = 'Users')
	DROP TABLE Users;						
GO
CREATE TABLE Users
(	UserID          INT             NOT NULL IDENTITY,	
    FullName        NVARCHAR(150)   NOT NULL,
    Login           NVARCHAR(16)    NOT NULL,     
    Password        NVARCHAR(16)    NOT NULL,
	CONSTRAINT PK_Users
		PRIMARY KEY (UserID)
);
GO

	/*** Создание таблицы Specialties ***/
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = 'Specialties')
	DROP TABLE Specialties;						
GO
CREATE TABLE Specialties
(	SpecialtyCode           NVARCHAR(8)       NOT NULL,			
    SpecialtyName           NVARCHAR(150)     NOT NULL,     
    SpecialtyReduction      NVARCHAR(3)       NOT NULL,
	CONSTRAINT PK_Specialties
		PRIMARY KEY (SpecialtyCode)
);
GO

	/*** Создание таблицы Groups ***/
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = 'Groups')
	DROP TABLE Groups;						
GO
CREATE TABLE Groups
(   GroupID         INT             NOT NULL IDENTITY,
	SpecialtyCode   NVARCHAR(8)     NOT NULL,	     
	GroupNumber     NVARCHAR(3)     NOT NULL,	
	CONSTRAINT PK_Groups
		PRIMARY KEY (GroupID),
    CONSTRAINT FK_Groups_Specialties
        FOREIGN KEY (SpecialtyCode)
            REFERENCES Specialties (SpecialtyCode)
);
GO

	/*** Создание таблицы Genders ***/
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = 'Genders')
	DROP TABLE Genders;						
GO
CREATE TABLE Genders
(   GenderID       CHAR(1)          NOT NULL,
	GenderName     VARCHAR(8)       NOT NULL,	     
	CONSTRAINT PK_Genders
		PRIMARY KEY (GenderID),
);
GO


	/*** Создание таблицы Students ***/
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = 'Students')
	DROP TABLE Students;						
GO
CREATE TABLE Students
(	StudentID     INT	   	NOT NULL IDENTITY,
    Surname       NVARCHAR(50)      NOT NULL,	     
	FirstName     NVARCHAR(50)      NOT NULL,	
    LastName      NVARCHAR(50),
    Birthday      DATETIME2         NOT NULL,
    GroupID       INT               NOT NULL,
    GenderID      CHAR(1)           NOT NULL,
    GPA           FLOAT(2)  CHECK (GPA >= 1 AND GPA <=5),

	CONSTRAINT PK_Students
		PRIMARY KEY (StudentID),
    CONSTRAINT FK_Students_Genders
        FOREIGN KEY (GenderID)
            REFERENCES Genders (GenderID),
    CONSTRAINT FK_Students_Groups
        FOREIGN KEY (GroupID)
            REFERENCES Groups (GroupID)
);
GO


INSERT INTO Specialties (SpecialtyCode, SpecialtyName, SpecialtyReduction) 
VALUES 
    ('09.02.06', 'Сетевое и системное администрирование', 'САД'),
    ('09.02.07', 'Информационные системы и программирование', 'ИСП'),
    ('10.02.05', 'Обеспечение информационной безопасности автоматизированных систем', 'ОИБ'),
    ('54.02.01', 'Дизайн', 'ДИЗ'),
    ('42.02.01', 'Реклама', 'РКЛ'),
    ('15.02.12', 'Монтаж, техническое обслуживание и ремонт промышленного оборудования', 'МТО'),
    ('20.02.02', 'Защита в чрезвычайных ситуациях', 'ЗЧС'),
    ('15.02.14', 'Оснащение средствами автоматизации технологических процессов и производств', 'ОСА'),
    ('20.02.04', 'Пожарная безопасность', 'ПБ');

INSERT INTO Groups (SpecialtyCode, GroupNumber)
VALUES
    ('09.02.06', '911'),
    ('09.02.06', '921'),
    ('09.02.06', '941'),
    ('09.02.06', '942'),

    ('09.02.07', '911'),
    ('09.02.07', '912'),
    ('09.02.07', '913'),
    ('09.02.06', '921'),
    ('09.02.06', '922'),

    ('10.02.05', '921'),
    ('10.02.05', '922'),
    ('10.02.05', '931'),
    ('10.02.05', '941'),
    ('10.02.05', '912'),
    ('10.02.05', '913'),

    ('54.02.01', '911'),
    ('54.02.01', '912'),
    ('54.02.01', '913'),
    ('54.02.01', '921'),
    ('54.02.01', '922'),
    ('54.02.01', '923'),
    
    ('42.02.01', '911'),
    ('42.02.01', '912'),
    

    ('15.02.12', '911'),
    ('15.02.12', '912'),
    ('42.02.01', '921'),

    ('20.02.02', '911'),
    ('20.02.02', '912'),
    ('20.02.02', '921'),
    ('20.02.02', '922'),

    ('15.02.14', '911'),
    ('15.02.14', '921'),

    ('20.02.04', '911'),
    ('20.02.04', '912'),
    ('20.02.04', '913');
GO

INSERT INTO Genders (GenderID, GenderName)
VALUES
    ('м', 'Мужской'),
    ('ж','Женский');
GO

INSERT INTO Students (Surname, FirstName, LastName, Birthday, GroupID, GenderID, GPA) 
VALUES
('Борисова',  'Виктория',  'Вячеславовна',  '09.12.2000',  1, 'ж', 4.07),
('Орлова',  'Валерия',  'Мирославовна',  '05.12.2002',  1, 'ж', 3.31),
('Зубков',  'Денис',  'Александрович',  '02.06.2001',  1, 'м', 4.62),
('Филиппов',  'Кирилл',  'Артёмович',  '15.03.2002',  1, 'м', 4.11),
('Куприянов',  'Арсений',  'Максимович',  '28.11.2001',  1, 'м', 3.19),
('Покровская',  'Диана',  'Васильевна',  '06.01.2002',  1, 'м', 3.39),
('Богомолова',  'Мария',  'Никитична',  '01.10.2000',  1, 'ж', 4.85),
('Рогова',  'Юлия',  'Дмитриевна',  '14.05.2000',  1, 'ж', 3.55),
('Николаева',  'Фатима',  'Михайловна',  '04.11.2003',  1, 'ж', 4.46),
('Кузьмина',  'Татьяна',  'Марковна',  '17.10.2001',  1, 'ж', 4.10),
('Костин',  'Михаил',  'Ярославович',  '21.01.2001',  1, 'м', 4.13),
('Чистяков',  'Гордей',  'Алексеевич',  '07.06.2001',  1, 'м', 4.89),
('Казанцева',  'Амира',  'Петровна',  '27.10.2000',  1, 'ж', 3.99),
('Егоров',  'Иван',  'Сергеевич',  '29.06.2000',  1, 'м', 4.65),
('Давыдова',  'Ксения',  'Максимовна',  '27.04.2002',  1, 'ж', 3.50),
('Шаповалов',  'Давид',  'Владимирович',  '24.04.2000',  1, 'м', 4.30),
('Зимина',  'Алина',  'Кирилловна',  '19.05.2000',  1, 'ж', 3.63),
('Кононов',  'Алексей',  'Денисович',  '18.11.2002',  1, 'м', 3.09),
('Балашова',  'Василиса',  'Владиславовна',  '13.05.1999',  1, 'ж', 4.32),
('Васильева',  'Мария',  'Денисовна',  '07.10.1999',  1, 'ж', 4.66),
('Волошин',  'Али',  'Артемьевич',  '18.01.2002',  1, 'м', 4.42),
('Цветков',  'Илья',  'Дмитриевич',  '28.09.2002',  1, 'м', 4.78),
('Александрова',  'Дарина',  'Ильинична',  '09.07.2001',  2, 'ж', 4.43),
('Баранов',  'Ярослав',  'Алексеевич',  '12.03.1999',  2, 'м', 4.25),
('Шевелева',  'Евгения',  'Фёдоровна',  '21.09.2003',  2, 'ж', 3.53),
('Латышев',  'Вячеслав',  'Иванович',  '27.02.2001',  2, 'м', 4.75),
('Григорьева',  'Варвара',  'Артёмовна',  '23.04.2001',  2, 'ж', 4.28),
('Балашов',  'Егор',  'Артемьевич',  '01.09.2000',  2, 'м', 3.54),
('Маслов',  'Артём',  'Святославович',  '28.11.1999',  2, 'м', 3.88),
('Миронов',  'Тимур',  'Павлович',  '30.03.2000',  2, 'м', 3.39),
('Сорокин',  'Илья',  'Мирославович',  '10.01.2000',  2, 'м', 3.54),
('Куликова',  'Мария',  'Макаровна',  '23.12.1999',  2, 'ж', 4.81),
('Королева',  'Анна',  'Леонидовна',  '19.11.2000',  2, 'ж', 3.97),
('Еремина',  'Юлия',  'Марковна',  '04.02.1999',  2, 'ж', 4.58),
('Токарев',  'Михаил',  'Романович',  '28.06.1999',  2, 'м', 4.70),
('Леонова',  'Анна',  'Артемьевна',  '26.05.2001',  2, 'ж', 4.16),
('Покровский',  'Марк',  'Александрович',  '13.09.2001',  2, 'м', 3.79),
('Новиков',  'Василий',  'Львович',  '17.04.2001',  2, 'м', 3.24),
('Иванова',  'Татьяна',  'Ивановна',  '25.01.2003',  2, 'ж', 3.66),
('Калинина',  'Вера',  'Александровна',  '23.05.2000',  2, 'ж', 4.04),
('Коротков',  'Андрей',  'Даниилович',  '06.05.2000',  2, 'м', 3.96),
('Тихонов',  'Илья',  'Билалович',  '16.07.2000',  2, 'м', 4.31),
('Юдин',  'Артём',  'Маркович',  '08.07.1999',  2, 'м', 3.20),
('Антонов',  'Михаил',  'Ильич',  '25.12.2000',  2, 'м', 4.46),
('Романов',  'Алексей',  'Арсентьевич',  '27.11.1999',  2, 'м', 4.26),
('Моисеев',  'Ярослав',  'Михайлович',  '30.04.1999',  2, 'м', 3.53),
('Воробьева',  'Виктория',  'Елисеевна',  '03.10.1999',  2, 'ж', 3.67),
('Филиппов',  'Егор',  'Саввич',  '13.12.2000',  2, 'м', 4.47),
('Глебова',  'Полина',  'Даниэльевна',  '01.07.1999',  2, 'ж', 3.27),
('Позднякова',  'Алиса',  'Захаровна',  '08.10.2002',  2, 'ж', 4.18),
('Александров',  'Максим',  'Львович',  '07.11.2002',  2, 'м', 3.47),
('Тарасов',  'Роман',  'Львович',  '11.03.2002',  3, 'м', 3.36),
('Сахаров',  'Константин',  'Артёмович',  '07.12.2001',  3, 'м', 4.30),
('Михайлов',  'Михаил',  'Фёдорович',  '27.04.2003',  3, 'м', 3.90),
('Кузнецов',  'Сергей',  'Владиславович',  '06.02.2001',  3, 'м', 3.35),
('Крылова',  'Анна',  'Артёмовна',  '12.08.2003',  3, 'ж', 3.06),
('Коновалов',  'Дмитрий',  'Михайлович',  '15.08.2003',  3, 'м', 4.89),
('Савельева',  'Злата',  'Сергеевна',  '16.06.1999',  3, 'ж', 3.23),
('Русаков',  'Тимофей',  'Савельевич',  '09.07.2003',  3, 'м', 3.55),
('Попова',  'Евгения',  'Юрьевна',  '13.07.1999',  3, 'ж', 3.54),
('Попов',  'Кирилл',  'Глебович',  '29.06.2002',  3, 'м', 4.04),
('Краснов',  'Андрей',  'Александрович',  '29.04.2000',  3, 'м', 4.10),
('Горюнова',  'Арина',  'Юрьевна',  '18.05.2000',  3, 'ж', 3.65),
('Медведев',  'Марк',  'Германович',  '01.09.2001',  3, 'м', 3.12),
('Пантелеев',  'Семён',  'Матвеевич',  '29.10.2003',  3, 'м', 4.07),
('Смирнов',  'Всеволод',  'Андреевич',  '14.02.2001',  3, 'м', 4.18),
('Орлов',  'Виктор',  'Андреевич',  '15.10.2003',  3, 'м', 4.60),
('Краснова',  'Дарья',  'Игоревна',  '15.04.2003',  3, 'ж', 3.00),
('Бирюкова',  'Анастасия',  'Романовна',  '28.05.2000',  3, 'ж', 3.82),
('Кудряшова',  'Софья',  'Александровна',  '13.11.1999',  4, 'ж', 3.48),
('Лосева',  'Полина',  'Александровна',  '14.11.2001',  4, 'ж', 3.03),
('Филиппова',  'Ульяна',  'Глебовна',  '23.11.1999',  4, 'ж', 4.65),
('Сухов',  'Богдан',  'Романович',  '21.11.1999',  4, 'м', 3.49),
('Сафонов',  'Владимир',  'Григорьевич',  '30.11.1999',  4, 'м', 4.78),
('Комарова',  'Амелия',  'Николаевна',  '11.11.2001',  4, 'ж', 4.97),
('Баженова',  'Есения',  'Александровна',  '12.09.2003',  4, 'ж', 3.79),
('Дружинин',  'Давид',  'Кириллович',  '30.05.2003',  4, 'м', 4.18),
('Осипова',  'Анна',  'Тимофеевна',  '11.07.2000',  4, 'ж', 4.55),
('Захаров',  'Марк',  'Константинович',  '24.02.2000',  4, 'м', 4.03),
('Филимонов',  'Мирон',  'Александрович',  '04.01.2000',  4, 'м', 3.83),
('Крылова',  'Милана',  'Глебовна',  '16.03.2001',  4, 'ж', 4.03),
('Ковалев',  'Евгений',  'Романович',  '20.08.2002',  4, 'м', 4.97),
('Григорьева',  'Ольга',  'Тимофеевна',  '06.10.2000',  4, 'ж', 3.79),
('Александрова',  'Агния',  'Сергеевна',  '23.10.2000',  4, 'ж', 3.87),
('Хомякова',  'Мария',  'Мироновна',  '22.04.2002',  4, 'ж', 4.76),
('Михайлова',  'Мария',  'Ильинична',  '25.04.2002',  4, 'ж', 3.33),
('Волков',  'Георгий',  'Арсентьевич',  '18.08.2002',  4, 'м', 4.03),
('Корнеев',  'Артемий',  'Романович',  '11.12.2001',  4, 'м', 3.14),
('Киселев',  'Иван',  'Кириллович',  '24.04.2001',  4, 'м', 4.03),
('Волкова',  'Елизавета',  'Матвеевна',  '14.06.2003',  4, 'ж', 3.14),
('Коновалов',  'Кирилл',  'Андреевич',  '06.04.2000',  4, 'м', 3.29),
('Романова',  'Ева',  'Павловна',  '09.08.2001',  4, 'ж', 3.76),
('Иванова',  'Дарья',  'Антоновна',  '20.06.2001',  4, 'ж', 4.17),
('Горюнов',  'Андрей',  'Денисович',  '28.12.1999',  5, 'м', 3.46),
('Кулагина',  'Анастасия',  'Евгеньевна',  '26.04.2003',  5, 'ж', 3.30),
('Костин',  'Роберт',  'Дмитриевич',  '17.12.2000',  5, 'м', 3.87),
('Ульянова',  'Алиса',  'Максимовна',  '04.10.1999',  5, 'ж', 3.34),
('Григорьев',  'Кирилл',  'Даниилович',  '04.08.2001',  5, 'м', 3.03),
('Федотов',  'Арсений',  'Макарович',  '18.03.2003',  5, 'м', 3.49),
('Скворцов',  'Дмитрий',  'Тимофеевич',  '01.05.1999',  5, 'м', 4.72),
('Свешников',  'Владимир',  'Семёнович',  '15.02.2001',  5, 'м', 4.84),
('Зверева',  'Виктория',  'Андреевна',  '03.03.1999',  5, 'ж', 3.04),
('Тарасова',  'Варвара',  'Романовна',  '19.10.2002',  5, 'ж', 4.40),
('Иванова',  'Маргарита',  'Николаевна',  '21.02.2001',  5, 'ж', 3.86),
('Кузнецова',  'Алёна',  'Дмитриевна',  '11.08.1999',  5, 'ж', 4.65),
('Кузнецов',  'Иван',  'Вячеславович',  '30.07.2002',  5, 'м', 4.98),
('Зотов',  'Василий',  'Егорович',  '21.11.2003',  5, 'м', 4.25),
('Яковлева',  'Ксения',  'Святославовна',  '09.05.2001',  5, 'ж', 3.47),
('Виноградов',  'Михаил',  'Миронович',  '03.09.2001',  5, 'м', 3.96),
('Григорьев',  'Егор',  'Артемьевич',  '16.11.2000',  5, 'м', 3.03),
('Смирнова',  'Анна',  'Максимовна',  '11.05.2000',  5, 'ж', 3.42),
('Филатов',  'Лев',  'Максимович',  '28.05.2002',  5, 'м', 4.34),
('Орлов',  'Макар',  'Эмильевич',  '15.05.1999',  5, 'м', 3.35),
('Молчанова',  'Маргарита',  'Сергеевна',  '23.09.2003',  5, 'ж', 3.47),
('Малышева',  'Софья',  'Ильинична',  '21.04.2001',  5, 'ж', 4.78),
('Поляков',  'Кирилл',  'Владимирович',  '18.05.2002',  5, 'м', 4.84),
('Казаков',  'Леонид',  'Александрович',  '06.02.2000',  5, 'м', 4.15),
('Козлов',  'Артём',  'Германович',  '14.03.2000',  5, 'м', 3.60),
('Панин',  'Георгий',  'Евгеньевич',  '15.12.2000',  5, 'м', 3.19),
('Кузнецов',  'Михаил',  'Михайлович',  '23.01.2001',  5, 'м', 4.66),
('Дементьева',  'Мария',  'Максимовна',  '20.08.2001',  5, 'ж', 4.96),
('Самойлов',  'Лев',  'Владимирович',  '07.07.2002',  6, 'м', 3.32),
('Миронова',  'Вероника',  'Михайловна',  '19.03.2000',  6, 'ж', 4.41),
('Осипов',  'Мирон',  'Романович',  '15.11.1999',  6, 'м', 3.44),
('Кудряшов',  'Александр',  'Маркович',  '23.02.2002',  6, 'м', 3.05),
('Гусев',  'Роман',  'Васильевич',  '01.01.2000',  6, 'м', 3.17),
('Соколова',  'Милана',  'Тимофеевна',  '16.03.2002',  6, 'ж', 4.55),
('Алексеев',  'Никита',  'Даниилович',  '09.12.2003',  6, 'м', 3.61),
('Васильев',  'Матвей',  'Алексеевич',  '18.07.1999',  6, 'м', 3.89),
('Федоров',  'Кирилл',  'Кириллович',  '16.03.1999',  6, 'м', 3.44),
('Кузнецова',  'Ксения',  'Романовна',  '16.08.1999',  6, 'ж', 3.48),
('Старостин',  'Артём',  'Семёнович',  '25.06.2000',  6, 'м', 4.73),
('Никитин',  'Адам',  'Александрович',  '05.01.2001',  6, 'м', 3.92),
('Фролов',  'Сергей',  'Вадимович',  '06.01.2000',  6, 'м', 3.51),
('Грачев',  'Дмитрий',  'Артёмович',  '26.12.2003',  6, 'м', 3.17),
('Федосеева',  'Елизавета',  'Сергеевна',  '04.01.2001',  6, 'ж', 3.51),
('Леонтьева',  'Оливия',  'Владимировна',  '04.12.2000',  6, 'ж', 4.51),
('Трифонова',  'Любовь',  'Андреевна',  '01.07.2001',  6, 'ж', 3.72),
('Иванова',  'Анастасия',  'Александровна',  '27.06.2003',  6, 'ж', 3.82),
('Демидов',  'Марк',  'Романович',  '25.03.2000',  6, 'м', 3.02),
('Журавлев',  'Тимофей',  'Матвеевич',  '27.06.2001',  6, 'м', 3.29),
('Зорина',  'Ксения',  'Петровна',  '22.08.2002',  6, 'ж', 5.00),
('Богомолова',  'Таисия',  'Марковна',  '12.04.2002',  6, 'ж', 4.78),
('Смирнова',  'Кристина',  'Арсентьевна',  '23.12.2003',  6, 'ж', 3.23),
('Ильинский',  'Ярослав',  'Ильич',  '01.01.1999',  6, 'м', 4.53),
('Быкова',  'Камилла',  'Кирилловна',  '15.09.1999',  6, 'ж', 3.58),
('Кузнецова',  'Алиса',  'Денисовна',  '03.05.2000',  6, 'ж', 4.42),
('Кулакова',  'Анастасия',  'Леоновна',  '29.09.2002',  6, 'ж', 4.60),
('Сурков',  'Сергей',  'Максимович',  '01.06.2003',  6, 'м', 4.15),
('Исаев',  'Максим',  'Артемьевич',  '16.05.1999',  6, 'м', 4.50),
('Мартынов',  'Тимофей',  'Артёмович',  '01.11.2001',  6, 'м', 3.45),
('Чижова',  'Майя',  'Дмитриевна',  '23.04.2003',  6, 'ж', 4.61),
('Моисеева',  'Анастасия',  'Давидовна',  '29.05.2003',  6, 'ж', 3.34),
('Михайлов',  'Илья',  'Эмильевич',  '06.06.2001',  6, 'м', 4.23),
('Черняева',  'Марьяна',  'Тимофеевна',  '07.10.2000',  6, 'ж', 3.64),
('Бородина',  'Анастасия',  'Родионовна',  '13.12.2003',  6, 'ж', 3.72),
('Орлов',  'Артём',  'Ярославович',  '19.04.2001',  6, 'м', 3.55),
('Скворцов',  'Даниил',  'Семёнович',  '17.02.2003',  6, 'м', 4.64),
('Журавлева',  'Ульяна',  'Сергеевна',  '11.07.1999',  6, 'ж', 4.23),
('Корнев',  'Марк',  'Романович',  '13.05.2002',  7, 'м', 3.79),
('Титова',  'Вероника',  'Артёмовна',  '09.10.1999',  7, 'ж', 4.30),
('Беляева',  'Вероника',  'Арсентьевна',  '08.06.1999',  7, 'ж', 3.25),
('Зуев',  'Никита',  'Яковлевич',  '05.02.2002',  7, 'м', 4.29),
('Лавров',  'Артём',  'Давидович',  '20.03.2002',  7, 'м', 4.70),
('Соколова',  'Дарья',  'Александровна',  '12.03.2000',  7, 'ж', 3.01),
('Семенова',  'Ульяна',  'Артёмовна',  '03.04.1999',  7, 'ж', 4.68),
('Афанасьева',  'Диана',  'Мироновна',  '15.06.1999',  7, 'ж', 4.47),
('Свиридова',  'Мария',  'Арсентьевна',  '19.01.2000',  7, 'ж', 4.81),
('Носова',  'Лилия',  'Артёмовна',  '25.05.2001',  7, 'ж', 3.81),
('Сорокина',  'Кристина',  'Богдановна',  '26.03.2002',  7, 'ж', 4.53),
('Беляков',  'Мирон',  'Андреевич',  '04.11.2000',  7, 'м', 3.76),
('Русанова',  'Анна',  'Ивановна',  '25.07.2002',  7, 'ж', 4.77),
('Марков',  'Матвей',  'Денисович',  '26.01.1999',  7, 'м', 3.17),
('Мухин',  'Леонид',  'Павлович',  '09.04.2003',  7, 'м', 3.82),
('Николаев',  'Вячеслав',  'Серафимович',  '19.06.1999',  7, 'м', 3.22),
('Максимова',  'Олеся',  'Фёдоровна',  '21.03.2001',  7, 'ж', 3.03),
('Мухин',  'Максим',  'Александрович',  '02.01.2001',  7, 'м', 4.57),
('Балашов',  'Степан',  'Адамович',  '21.07.2002',  7, 'м', 3.24),
('Максимова',  'Зоя',  'Марковна',  '19.11.2000',  7, 'ж', 3.90),
('Николаева',  'Елизавета',  'Фёдоровна',  '31.07.2002',  7, 'ж', 3.88),
('Карташова',  'Дарья',  'Михайловна',  '05.08.2000',  7, 'ж', 3.85),
('Наумов',  'Макар',  'Тимурович',  '03.06.2003',  7, 'м', 4.95),
('Полякова',  'Ева',  'Макаровна',  '09.02.1999',  10, 'ж', 4.65),
('Яковлев',  'Тимофей',  'Глебович',  '03.08.2000',  10, 'м', 4.22),
('Васильева',  'Малика',  'Глебовна',  '03.03.2003',  10, 'ж', 4.23),
('Егорова',  'Ирина',  'Артёмовна',  '13.06.2003',  10, 'ж', 3.95),
('Соколов',  'Всеволод',  'Георгиевич',  '26.09.1999',  10, 'м', 4.95),
('Мельникова',  'Василиса',  'Романовна',  '15.04.2001',  10, 'ж', 4.90),
('Павлова',  'Анастасия',  'Владиславовна',  '22.08.2001',  10, 'ж', 3.83),
('Фомина',  'Алиса',  'Львовна',  '06.12.2002',  10, 'ж', 4.43),
('Некрасова',  'Виктория',  'Дмитриевна',  '18.07.2000',  10, 'ж', 3.93),
('Николаева',  'Есения',  'Кирилловна',  '15.01.1999',  10, 'ж', 4.23),
('Баженов',  'Иван',  'Богданович',  '22.11.2002',  10, 'м', 4.99),
('Алехина',  'Александра',  'Григорьевна',  '23.07.2003',  10, 'ж', 3.89),
('Леонтьев',  'Тимофей',  'Алексеевич',  '08.07.2000',  10, 'м', 3.88),
('Шаповалова',  'Диана',  'Дмитриевна',  '20.11.2000',  10, 'ж', 4.94),
('Иванов',  'Александр',  'Романович',  '11.01.2000',  10, 'м', 3.65),
('Евдокимова',  'Виктория',  'Артёмовна',  '15.07.2001',  10, 'ж', 4.29),
('Молчанов',  'Максим',  'Кириллович',  '18.07.2003',  10, 'м', 4.91),
('Куприянова',  'Анна',  'Захаровна',  '17.07.2002',  10, 'ж', 4.24),
('Калмыкова',  'Полина',  'Андреевна',  '10.07.2003',  10, 'ж', 3.42),
('Седов',  'Михаил',  'Егорович',  '06.11.2001',  10, 'м', 3.16),
('Суханова',  'Ульяна',  'Павловна',  '09.02.2003',  10, 'ж', 3.59),
('Павлова',  'Анна',  'Павловна',  '04.02.2003',  10, 'ж', 3.59),
('Крылова',  'Варвара',  'Александровна',  '31.03.2003',  10, 'ж', 3.18),
('Тимофеев',  'Василий',  'Львович',  '12.08.2000',  10, 'м', 3.55),
('Емельянова',  'Полина',  'Алексеевна',  '20.09.2002',  10, 'ж', 4.01),
('Сафонова',  'Екатерина',  'Алексеевна',  '02.11.2000',  10, 'ж', 4.28),
('Колесникова',  'Мария',  'Владиславовна',  '30.06.2002',  11, 'ж', 4.13),
('Григорьева',  'Полина',  'Руслановна',  '17.07.2001',  11, 'ж', 4.20),
('Васильев',  'Мирослав',  'Алексеевич',  '25.04.2001',  11, 'м', 3.18),
('Соколова',  'Станислава',  'Алексеевна',  '01.12.1999',  11, 'ж', 4.42),
('Бондарева',  'Ясмина',  'Михайловна',  '19.08.1999',  11, 'ж', 4.76),
('Макарова',  'Мария',  'Дмитриевна',  '07.12.2001',  11, 'ж', 3.39),
('Николаева',  'Алиса',  'Андреевна',  '21.08.2000',  11, 'ж', 3.53),
('Еремеев',  'Николай',  'Демидович',  '17.05.2001',  11, 'м', 4.73),
('Данилова',  'Алёна',  'Давидовна',  '16.11.2003',  11, 'ж', 4.09),
('Егоров',  'Ярослав',  'Арсентьевич',  '20.07.2003',  11, 'м', 4.48),
('Полякова',  'Анна',  'Арсентьевна',  '31.05.2002',  11, 'ж', 3.61),
('Кузнецова',  'Валерия',  'Всеволодовна',  '02.07.2001',  11, 'ж', 3.62),
('Агафонова',  'Светлана',  'Михайловна',  '03.03.1999',  11, 'ж', 4.25),
('Данилов',  'Богдан',  'Михайлович',  '16.10.2002',  11, 'м', 4.27),
('Новиков',  'Лев',  'Николаевич',  '20.03.2001',  11, 'м', 3.98),
('Чернышева',  'Александра',  'Тимофеевна',  '09.06.2001',  11, 'ж', 4.41),
('Фролов',  'Владимир',  'Никитич',  '02.05.2003',  12, 'м', 4.26),
('Тимофеева',  'Милана',  'Алиевна',  '29.07.2002',  12, 'ж', 4.64),
('Козлова',  'София',  'Ильинична',  '05.05.1999',  12, 'ж', 4.44),
('Емельянов',  'Алексей',  'Владиславович',  '29.04.2002',  12, 'м', 3.56),
('Мартынов',  'Артём',  'Тимофеевич',  '29.09.2001',  12, 'м', 3.63),
('Абрамова',  'Елизавета',  'Степановна',  '04.06.1999',  12, 'ж', 4.27),
('Афанасьева',  'Анастасия',  'Романовна',  '22.11.2002',  12, 'ж', 3.59),
('Островский',  'Иван',  'Александрович',  '24.02.2003',  12, 'м', 4.58),
('Васильева',  'Полина',  'Романовна',  '29.10.1999',  12, 'ж', 3.64),
('Крылова',  'Василиса',  'Матвеевна',  '04.07.2002',  12, 'ж', 4.42),
('Козлов',  'Степан',  'Ибрагимович',  '15.07.2003',  12, 'м', 3.29),
('Королева',  'Ясмина',  'Сергеевна',  '10.03.2001',  12, 'ж', 3.69),
('Афанасьева',  'Ксения',  'Романовна',  '11.06.2002',  12, 'ж', 3.02),
('Евсеев',  'Лев',  'Маркович',  '21.12.2001',  12, 'м', 3.92),
('Соколова',  'София',  'Дмитриевна',  '23.08.2000',  13, 'ж', 4.34),
('Герасимов',  'Ибрагим',  'Георгиевич',  '18.04.2000',  13, 'м', 4.86),
('Андреева',  'Мария',  'Марковна',  '18.11.2000',  13, 'ж', 4.58),
('Попова',  'Арина',  'Максимовна',  '25.03.2002',  13, 'ж', 3.51),
('Лазарев',  'Михаил',  'Иванович',  '27.12.1999',  13, 'м', 3.87),
('Федотова',  'Ольга',  'Артёмовна',  '06.12.1999',  13, 'ж', 3.08),
('Беляева',  'Алёна',  'Макаровна',  '07.08.2002',  13, 'ж', 3.49),
('Зуева',  'Елизавета',  'Егоровна',  '28.05.2003',  13, 'ж', 4.56),
('Тарасов',  'Никита',  'Артурович',  '15.07.2000',  13, 'м', 3.50),
('Иванов',  'Тимур',  'Захарович',  '08.12.2000',  13, 'м', 4.59),
('Кулешов',  'Илья',  'Даниилович',  '11.11.2003',  13, 'м', 4.79),
('Игнатьев',  'Константин',  'Эрикович',  '06.10.2002',  13, 'м', 3.87),
('Комаров',  'Мирон',  'Дмитриевич',  '08.07.2003',  13, 'м', 3.32),
('Нефедов',  'Максим',  'Давидович',  '15.03.2002',  13, 'м', 3.25),
('Некрасов',  'Дмитрий',  'Демидович',  '22.03.1999',  13, 'м', 3.35),
('Пантелеева',  'Александра',  'Сергеевна',  '28.02.2002',  14, 'ж', 3.39),
('Осипов',  'Артём',  'Никитич',  '21.04.2001',  14, 'м', 4.23),
('Еремин',  'Павел',  'Кириллович',  '01.09.2003',  14, 'м', 4.88),
('Ковалева',  'Елена',  'Артёмовна',  '19.03.2001',  14, 'ж', 3.85),
('Терехов',  'Леонид',  'Богданович',  '13.09.2001',  14, 'м', 3.46),
('Капустина',  'Виктория',  'Родионовна',  '21.09.2003',  14, 'ж', 4.18),
('Максимова',  'Елена',  'Глебовна',  '22.05.2001',  14, 'ж', 4.91),
('Фролова',  'Алиса',  'Давидовна',  '25.03.2000',  14, 'ж', 4.82),
('Кузнецов',  'Егор',  'Константинович',  '11.03.2002',  14, 'м', 4.87),
('Семин',  'Матвей',  'Алексеевич',  '19.12.1999',  14, 'м', 4.63),
('Горбачева',  'Василиса',  'Андреевна',  '28.08.2001',  14, 'ж', 4.32),
('Скворцова',  'Лилия',  'Антоновна',  '28.07.2000',  14, 'ж', 4.84),
('Мартынов',  'Иван',  'Михайлович',  '30.03.2000',  14, 'м', 4.85),
('Мальцева',  'Мария',  'Марковна',  '24.12.2002',  14, 'ж', 3.70),
('Максимова',  'Диана',  'Михайловна',  '15.05.2000',  14, 'ж', 4.39),
('Смирнова',  'Елизавета',  'Антоновна',  '18.12.2001',  14, 'ж', 4.19),
('Сидоров',  'Михаил',  'Сергеевич',  '27.03.1999',  14, 'м', 4.21),
('Нестерова',  'Ульяна',  'Александровна',  '15.07.1999',  14, 'ж', 4.58),
('Иванов',  'Семён',  'Всеволодович',  '19.04.2002',  16, 'м', 3.13),
('Голубев',  'Денис',  'Никитич',  '04.02.2000',  16, 'м', 3.29),
('Савин',  'Денис',  'Игоревич',  '22.08.1999',  16, 'м', 3.85),
('Андреева',  'Виктория',  'Владиславовна',  '12.11.2002',  16, 'ж', 3.24),
('Попов',  'Денис',  'Семёнович',  '01.07.2002',  16, 'м', 4.40),
('Ананьева',  'Лидия',  'Григорьевна',  '11.12.1999',  16, 'ж', 4.14),
('Калашников',  'Николай',  'Глебович',  '06.12.2002',  16, 'м', 3.44),
('Соколова',  'Арина',  'Антоновна',  '25.09.2001',  17, 'ж', 3.75),
('Иванова',  'Таисия',  'Филипповна',  '28.11.2003',  17, 'ж', 4.25),
('Лебедева',  'Вероника',  'Михайловна',  '11.04.2000',  17, 'ж', 3.07),
('Гришина',  'Эмилия',  'Тимофеевна',  '01.07.2003',  17, 'ж', 3.25),
('Морозова',  'Анна',  'Эмировна',  '30.10.2002',  17, 'ж', 4.38),
('Волкова',  'Есения',  'Савельевна',  '11.01.2002',  18, 'ж', 4.06),
('Алексеев',  'Кирилл',  'Ярославович',  '03.07.2001',  18, 'м', 3.91),
('Горбунов',  'Данила',  'Даниилович',  '09.03.2001',  18, 'м', 3.53),
('Шишкин',  'Александр',  'Михайлович',  '18.12.1999',  18, 'м', 3.17),
('Тихонова',  'Мария',  'Глебовна',  '21.02.2000',  18, 'ж', 4.91),
('Тарасов',  'Даниил',  'Даниилович',  '09.11.2002',  18, 'м', 3.26),
('Воронцова',  'Эмма',  'Евгеньевна',  '15.12.1999',  18, 'ж', 4.10),
('Литвинова',  'Мирослава',  'Романовна',  '10.07.2002',  18, 'ж', 3.49),
('Смирнова',  'Серафима',  'Львовна',  '09.12.2003',  18, 'ж', 3.31),
('Смирнова',  'Алиса',  'Фёдоровна',  '26.06.2001',  18, 'ж', 4.72),
('Горячева',  'София',  'Артёмовна',  '04.11.2000',  18, 'ж', 4.79),
('Андреева',  'Милана',  'Марковна',  '07.12.2000',  19, 'ж', 3.21),
('Волкова',  'Ева',  'Андреевна',  '23.06.2003',  19, 'ж', 4.41),
('Ильинская',  'Дарья',  'Максимовна',  '03.01.2001',  19, 'м', 3.96),
('Захаров',  'Владимир',  'Константинович',  '12.05.1999',  19, 'м', 4.88),
('Степанова',  'Юлия',  'Дмитриевна',  '05.09.2002',  19, 'ж', 3.88),
('Максимов',  'Мирон',  'Михайлович',  '22.07.2002',  19, 'м', 4.37);
GO
