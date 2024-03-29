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
(	StudentID     INT	   	        NOT NULL IDENTITY,
    Surname       NVARCHAR(50)      NOT NULL,	     
	FirstName     NVARCHAR(50)      NOT NULL,	
    LastName      NVARCHAR(50),
    Birthday      DATETIME2         NOT NULL,
    GroupID       INT               NOT NULL,
    GenderID      CHAR(1)           NOT NULL,
    GPA           FLOAT(2)  CHECK (GPA >= 1 AND GPA <=5),
    PhotoPath     NVARCHAR(100),

	CONSTRAINT PK_Students
		PRIMARY KEY (StudentID),
    CONSTRAINT FK_Students_Genders
        FOREIGN KEY (GenderID)
            REFERENCES Genders (GenderID),
    CONSTRAINT FK_Students_Groups
        FOREIGN KEY (GroupID)
            REFERENCES Groups (GroupID)
                ON DELETE CASCADE
);
GO

INSERT INTO Users(FullName, Login, Password)
VALUES
    ('Свириденко Д.Д.', '1', '1'),
    ('Иванов И.И.', '123', '123');

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

INSERT INTO Students (Surname, FirstName, LastName, Birthday, GroupID, GenderID, GPA, PhotoPath) 
VALUES
('Борисова',  'Виктория',  'Вячеславовна',  '09.12.2000',  1, 'ж', 4.33, 'C:\Images\image_001.jpg'),
('Орлова',  'Валерия',  'Мирославовна',  '05.12.2002',  1, 'ж', 3.83, 'C:\Images\image_002.jpg'),
('Зубков',  'Денис',  'Александрович',  '02.06.2001',  1, 'м', 4.63, 'C:\Images\image_003.jpg'),
('Филиппов',  'Кирилл',  'Артёмович',  '15.03.2002',  1, 'м', 3.98, 'C:\Images\image_004.jpg'),
('Куприянов',  'Арсений',  'Максимович',  '28.11.2001',  1, 'м', 3.92, 'C:\Images\image_005.jpg'),
('Покровская',  'Диана',  'Васильевна',  '06.01.2002',  1, 'м', 3.31, 'C:\Images\image_006.jpg'),
('Богомолова',  'Мария',  'Никитична',  '01.10.2000',  1, 'ж', 3.09, 'C:\Images\image_007.jpg'),
('Рогова',  'Юлия',  'Дмитриевна',  '14.05.2000',  1, 'ж', 3.94, 'C:\Images\image_008.jpg'),
('Николаева',  'Фатима',  'Михайловна',  '04.11.2003',  1, 'ж', 4.48, 'C:\Images\image_009.jpg'),
('Кузьмина',  'Татьяна',  'Марковна',  '17.10.2001',  1, 'ж', 3.48, 'C:\Images\image_010.jpg'),
('Костин',  'Михаил',  'Ярославович',  '21.01.2001',  1, 'м', 4.90, 'C:\Images\image_011.jpg'),
('Чистяков',  'Гордей',  'Алексеевич',  '07.06.2001',  1, 'м', 4.96, 'C:\Images\image_012.jpg'),
('Казанцева',  'Амира',  'Петровна',  '27.10.2000',  1, 'ж', 4.78, 'C:\Images\image_013.jpg'),
('Егоров',  'Иван',  'Сергеевич',  '29.06.2000',  1, 'м', 4.56, 'C:\Images\image_014.jpg'),
('Давыдова',  'Ксения',  'Максимовна',  '27.04.2002',  1, 'ж', 4.56, 'C:\Images\image_015.jpg'),
('Шаповалов',  'Давид',  'Владимирович',  '24.04.2000',  1, 'м', 4.13, 'C:\Images\image_016.jpg'),
('Зимина',  'Алина',  'Кирилловна',  '19.05.2000',  1, 'ж', 4.00, 'C:\Images\image_017.jpg'),
('Кононов',  'Алексей',  'Денисович',  '18.11.2002',  1, 'м', 4.68, 'C:\Images\image_018.jpg'),
('Балашова',  'Василиса',  'Владиславовна',  '13.05.1999',  1, 'ж', 3.48, 'C:\Images\image_019.jpg'),
('Васильева',  'Мария',  'Денисовна',  '07.10.1999',  1, 'ж', 4.18, 'C:\Images\image_020.jpg'),
('Волошин',  'Али',  'Артемьевич',  '18.01.2002',  1, 'м', 3.56, 'C:\Images\image_021.jpg'),
('Цветков',  'Илья',  'Дмитриевич',  '28.09.2002',  1, 'м', 4.55, 'C:\Images\image_022.jpg'),
('Александрова',  'Дарина',  'Ильинична',  '09.07.2001',  2, 'ж', 3.37, 'C:\Images\image_023.jpg'),
('Баранов',  'Ярослав',  'Алексеевич',  '12.03.1999',  2, 'м', 4.55, 'C:\Images\image_024.jpg'),
('Шевелева',  'Евгения',  'Фёдоровна',  '21.09.2003',  2, 'ж', 3.26, 'C:\Images\image_025.jpg'),
('Латышев',  'Вячеслав',  'Иванович',  '27.02.2001',  2, 'м', 3.37, 'C:\Images\image_026.jpg'),
('Григорьева',  'Варвара',  'Артёмовна',  '23.04.2001',  2, 'ж', 4.90, 'C:\Images\image_027.jpg'),
('Балашов',  'Егор',  'Артемьевич',  '01.09.2000',  2, 'м', 3.48, 'C:\Images\image_028.jpg'),
('Маслов',  'Артём',  'Святославович',  '28.11.1999',  2, 'м', 4.86, 'C:\Images\image_029.jpg'),
('Миронов',  'Тимур',  'Павлович',  '30.03.2000',  2, 'м', 3.70, 'C:\Images\image_030.jpg'),
('Сорокин',  'Илья',  'Мирославович',  '10.01.2000',  2, 'м', 3.10, 'C:\Images\image_031.jpg'),
('Куликова',  'Мария',  'Макаровна',  '23.12.1999',  2, 'ж', 4.77, 'C:\Images\image_032.jpg'),
('Королева',  'Анна',  'Леонидовна',  '19.11.2000',  2, 'ж', 4.97, 'C:\Images\image_033.jpg'),
('Еремина',  'Юлия',  'Марковна',  '04.02.1999',  2, 'ж', 3.45, 'C:\Images\image_034.jpg'),
('Токарев',  'Михаил',  'Романович',  '28.06.1999',  2, 'м', 4.40, 'C:\Images\image_035.jpg'),
('Леонова',  'Анна',  'Артемьевна',  '26.05.2001',  2, 'ж', 4.87, 'C:\Images\image_036.jpg'),
('Покровский',  'Марк',  'Александрович',  '13.09.2001',  2, 'м', 3.01, 'C:\Images\image_037.jpg'),
('Новиков',  'Василий',  'Львович',  '17.04.2001',  2, 'м', 4.24, 'C:\Images\image_038.jpg'),
('Иванова',  'Татьяна',  'Ивановна',  '25.01.2003',  2, 'ж', 4.16, 'C:\Images\image_039.jpg'),
('Калинина',  'Вера',  'Александровна',  '23.05.2000',  2, 'ж', 3.05, 'C:\Images\image_040.jpg'),
('Коротков',  'Андрей',  'Даниилович',  '06.05.2000',  2, 'м', 4.22, 'C:\Images\image_041.jpg'),
('Тихонов',  'Илья',  'Билалович',  '16.07.2000',  2, 'м', 4.88, 'C:\Images\image_042.jpg'),
('Юдин',  'Артём',  'Маркович',  '08.07.1999',  2, 'м', 3.49, 'C:\Images\image_043.jpg'),
('Антонов',  'Михаил',  'Ильич',  '25.12.2000',  2, 'м', 3.61, 'C:\Images\image_044.jpg'),
('Романов',  'Алексей',  'Арсентьевич',  '27.11.1999',  2, 'м', 3.88, 'C:\Images\image_045.jpg'),
('Моисеев',  'Ярослав',  'Михайлович',  '30.04.1999',  2, 'м', 4.85, 'C:\Images\image_046.jpg'),
('Воробьева',  'Виктория',  'Елисеевна',  '03.10.1999',  2, 'ж', 3.38, 'C:\Images\image_047.jpg'),
('Филиппов',  'Егор',  'Саввич',  '13.12.2000',  2, 'м', 3.80, 'C:\Images\image_048.jpg'),
('Глебова',  'Полина',  'Даниэльевна',  '01.07.1999',  2, 'ж', 3.16, 'C:\Images\image_049.jpg'),
('Позднякова',  'Алиса',  'Захаровна',  '08.10.2002',  2, 'ж', 4.39, 'C:\Images\image_050.jpg'),
('Александров',  'Максим',  'Львович',  '07.11.2002',  2, 'м', 3.16, 'C:\Images\image_051.jpg'),
('Тарасов',  'Роман',  'Львович',  '11.03.2002',  3, 'м', 3.66, 'C:\Images\image_052.jpg'),
('Сахаров',  'Константин',  'Артёмович',  '07.12.2001',  3, 'м', 3.01, 'C:\Images\image_053.jpg'),
('Михайлов',  'Михаил',  'Фёдорович',  '27.04.2003',  3, 'м', 4.95, 'C:\Images\image_054.jpg'),
('Кузнецов',  'Сергей',  'Владиславович',  '06.02.2001',  3, 'м', 3.23, 'C:\Images\image_055.jpg'),
('Крылова',  'Анна',  'Артёмовна',  '12.08.2003',  3, 'ж', 3.25, 'C:\Images\image_056.jpg'),
('Коновалов',  'Дмитрий',  'Михайлович',  '15.08.2003',  3, 'м', 3.26, 'C:\Images\image_057.jpg'),
('Савельева',  'Злата',  'Сергеевна',  '16.06.1999',  3, 'ж', 3.19, 'C:\Images\image_058.jpg'),
('Русаков',  'Тимофей',  'Савельевич',  '09.07.2003',  3, 'м', 3.73, 'C:\Images\image_059.jpg'),
('Попова',  'Евгения',  'Юрьевна',  '13.07.1999',  3, 'ж', 3.39, 'C:\Images\image_060.jpg'),
('Попов',  'Кирилл',  'Глебович',  '29.06.2002',  3, 'м', 3.19, 'C:\Images\image_061.jpg'),
('Краснов',  'Андрей',  'Александрович',  '29.04.2000',  3, 'м', 4.44, 'C:\Images\image_062.jpg'),
('Горюнова',  'Арина',  'Юрьевна',  '18.05.2000',  3, 'ж', 4.02, 'C:\Images\image_063.jpg'),
('Медведев',  'Марк',  'Германович',  '01.09.2001',  3, 'м', 3.60, 'C:\Images\image_064.jpg'),
('Пантелеев',  'Семён',  'Матвеевич',  '29.10.2003',  3, 'м', 3.29, 'C:\Images\image_065.jpg'),
('Смирнов',  'Всеволод',  'Андреевич',  '14.02.2001',  3, 'м', 4.57, 'C:\Images\image_066.jpg'),
('Орлов',  'Виктор',  'Андреевич',  '15.10.2003',  3, 'м', 3.18, 'C:\Images\image_067.jpg'),
('Краснова',  'Дарья',  'Игоревна',  '15.04.2003',  3, 'ж', 3.72, 'C:\Images\image_068.jpg'),
('Бирюкова',  'Анастасия',  'Романовна',  '28.05.2000',  3, 'ж', 4.01, 'C:\Images\image_069.jpg'),
('Кудряшова',  'Софья',  'Александровна',  '13.11.1999',  4, 'ж', 4.41, 'C:\Images\image_070.jpg'),
('Лосева',  'Полина',  'Александровна',  '14.11.2001',  4, 'ж', 3.22, 'C:\Images\image_071.jpg'),
('Филиппова',  'Ульяна',  'Глебовна',  '23.11.1999',  4, 'ж', 3.32, 'C:\Images\image_072.jpg'),
('Сухов',  'Богдан',  'Романович',  '21.11.1999',  4, 'м', 3.46, 'C:\Images\image_073.jpg'),
('Сафонов',  'Владимир',  'Григорьевич',  '30.11.1999',  4, 'м', 4.30, 'C:\Images\image_074.jpg'),
('Комарова',  'Амелия',  'Николаевна',  '11.11.2001',  4, 'ж', 3.26, 'C:\Images\image_075.jpg'),
('Баженова',  'Есения',  'Александровна',  '12.09.2003',  4, 'ж', 4.38, 'C:\Images\image_076.jpg'),
('Дружинин',  'Давид',  'Кириллович',  '30.05.2003',  4, 'м', 4.76, 'C:\Images\image_077.jpg'),
('Осипова',  'Анна',  'Тимофеевна',  '11.07.2000',  4, 'ж', 3.72, 'C:\Images\image_078.jpg'),
('Захаров',  'Марк',  'Константинович',  '24.02.2000',  4, 'м', 4.00, 'C:\Images\image_079.jpg'),
('Филимонов',  'Мирон',  'Александрович',  '04.01.2000',  4, 'м', 3.11, 'C:\Images\image_080.jpg'),
('Крылова',  'Милана',  'Глебовна',  '16.03.2001',  4, 'ж', 3.93, 'C:\Images\image_081.jpg'),
('Ковалев',  'Евгений',  'Романович',  '20.08.2002',  4, 'м', 3.68, 'C:\Images\image_082.jpg'),
('Григорьева',  'Ольга',  'Тимофеевна',  '06.10.2000',  4, 'ж', 3.91, 'C:\Images\image_083.jpg'),
('Александрова',  'Агния',  'Сергеевна',  '23.10.2000',  4, 'ж', 3.42, 'C:\Images\image_084.jpg'),
('Хомякова',  'Мария',  'Мироновна',  '22.04.2002',  4, 'ж', 4.80, 'C:\Images\image_085.jpg'),
('Михайлова',  'Мария',  'Ильинична',  '25.04.2002',  4, 'ж', 3.30, 'C:\Images\image_086.jpg'),
('Волков',  'Георгий',  'Арсентьевич',  '18.08.2002',  4, 'м', 4.27, 'C:\Images\image_087.jpg'),
('Корнеев',  'Артемий',  'Романович',  '11.12.2001',  4, 'м', 4.07, 'C:\Images\image_088.jpg'),
('Киселев',  'Иван',  'Кириллович',  '24.04.2001',  4, 'м', 4.21, 'C:\Images\image_089.jpg'),
('Волкова',  'Елизавета',  'Матвеевна',  '14.06.2003',  4, 'ж', 4.83, 'C:\Images\image_090.jpg'),
('Коновалов',  'Кирилл',  'Андреевич',  '06.04.2000',  4, 'м', 4.72, 'C:\Images\image_091.jpg'),
('Романова',  'Ева',  'Павловна',  '09.08.2001',  4, 'ж', 4.97, 'C:\Images\image_092.jpg'),
('Иванова',  'Дарья',  'Антоновна',  '20.06.2001',  4, 'ж', 3.93, 'C:\Images\image_093.jpg'),
('Горюнов',  'Андрей',  'Денисович',  '28.12.1999',  5, 'м', 4.59, 'C:\Images\image_094.jpg'),
('Кулагина',  'Анастасия',  'Евгеньевна',  '26.04.2003',  5, 'ж', 4.06, 'C:\Images\image_095.jpg'),
('Костин',  'Роберт',  'Дмитриевич',  '17.12.2000',  5, 'м', 3.57, 'C:\Images\image_096.jpg'),
('Ульянова',  'Алиса',  'Максимовна',  '04.10.1999',  5, 'ж', 4.88, 'C:\Images\image_097.jpg'),
('Григорьев',  'Кирилл',  'Даниилович',  '04.08.2001',  5, 'м', 4.51, 'C:\Images\image_098.jpg'),
('Федотов',  'Арсений',  'Макарович',  '18.03.2003',  5, 'м', 4.50, 'C:\Images\image_099.jpg'),
('Скворцов',  'Дмитрий',  'Тимофеевич',  '01.05.1999',  5, 'м', 3.11, 'C:\Images\image_100.jpg'),
('Свешников',  'Владимир',  'Семёнович',  '15.02.2001',  5, 'м', 3.87, 'C:\Images\image_101.jpg'),
('Зверева',  'Виктория',  'Андреевна',  '03.03.1999',  5, 'ж', 4.66, 'C:\Images\image_102.jpg'),
('Тарасова',  'Варвара',  'Романовна',  '19.10.2002',  5, 'ж', 3.65, 'C:\Images\image_103.jpg'),
('Иванова',  'Маргарита',  'Николаевна',  '21.02.2001',  5, 'ж', 4.81, 'C:\Images\image_104.jpg'),
('Кузнецова',  'Алёна',  'Дмитриевна',  '11.08.1999',  5, 'ж', 3.58, 'C:\Images\image_105.jpg'),
('Кузнецов',  'Иван',  'Вячеславович',  '30.07.2002',  5, 'м', 3.82, 'C:\Images\image_106.jpg'),
('Зотов',  'Василий',  'Егорович',  '21.11.2003',  5, 'м', 3.41, 'C:\Images\image_107.jpg'),
('Яковлева',  'Ксения',  'Святославовна',  '09.05.2001',  5, 'ж', 4.20, 'C:\Images\image_108.jpg'),
('Виноградов',  'Михаил',  'Миронович',  '03.09.2001',  5, 'м', 4.17, 'C:\Images\image_109.jpg'),
('Григорьев',  'Егор',  'Артемьевич',  '16.11.2000',  5, 'м', 3.10, 'C:\Images\image_110.jpg'),
('Смирнова',  'Анна',  'Максимовна',  '11.05.2000',  5, 'ж', 3.34, 'C:\Images\image_111.jpg'),
('Филатов',  'Лев',  'Максимович',  '28.05.2002',  5, 'м', 4.70, 'C:\Images\image_112.jpg'),
('Орлов',  'Макар',  'Эмильевич',  '15.05.1999',  5, 'м', 3.43, 'C:\Images\image_113.jpg'),
('Молчанова',  'Маргарита',  'Сергеевна',  '23.09.2003',  5, 'ж', 3.09, 'C:\Images\image_114.jpg'),
('Малышева',  'Софья',  'Ильинична',  '21.04.2001',  5, 'ж', 3.67, 'C:\Images\image_115.jpg'),
('Поляков',  'Кирилл',  'Владимирович',  '18.05.2002',  5, 'м', 3.28, 'C:\Images\image_116.jpg'),
('Казаков',  'Леонид',  'Александрович',  '06.02.2000',  5, 'м', 3.58, 'C:\Images\image_117.jpg'),
('Козлов',  'Артём',  'Германович',  '14.03.2000',  5, 'м', 4.86, 'C:\Images\image_118.jpg'),
('Панин',  'Георгий',  'Евгеньевич',  '15.12.2000',  5, 'м', 3.76, 'C:\Images\image_119.jpg'),
('Кузнецов',  'Михаил',  'Михайлович',  '23.01.2001',  5, 'м', 4.12, 'C:\Images\image_001.jpg'),
('Дементьева',  'Мария',  'Максимовна',  '20.08.2001',  5, 'ж', 3.10, 'C:\Images\image_002.jpg'),
('Самойлов',  'Лев',  'Владимирович',  '07.07.2002',  6, 'м', 4.62, 'C:\Images\image_003.jpg'),
('Миронова',  'Вероника',  'Михайловна',  '19.03.2000',  6, 'ж', 4.20, 'C:\Images\image_004.jpg'),
('Осипов',  'Мирон',  'Романович',  '15.11.1999',  6, 'м', 4.27, 'C:\Images\image_005.jpg'),
('Кудряшов',  'Александр',  'Маркович',  '23.02.2002',  6, 'м', 3.10, 'C:\Images\image_006.jpg'),
('Гусев',  'Роман',  'Васильевич',  '01.01.2000',  6, 'м', 3.51, 'C:\Images\image_007.jpg'),
('Соколова',  'Милана',  'Тимофеевна',  '16.03.2002',  6, 'ж', 3.94, 'C:\Images\image_008.jpg'),
('Алексеев',  'Никита',  'Даниилович',  '09.12.2003',  6, 'м', 4.44, 'C:\Images\image_009.jpg'),
('Васильев',  'Матвей',  'Алексеевич',  '18.07.1999',  6, 'м', 4.03, 'C:\Images\image_010.jpg'),
('Федоров',  'Кирилл',  'Кириллович',  '16.03.1999',  6, 'м', 3.95, 'C:\Images\image_011.jpg'),
('Кузнецова',  'Ксения',  'Романовна',  '16.08.1999',  6, 'ж', 3.56, 'C:\Images\image_012.jpg'),
('Старостин',  'Артём',  'Семёнович',  '25.06.2000',  6, 'м', 4.78, 'C:\Images\image_013.jpg'),
('Никитин',  'Адам',  'Александрович',  '05.01.2001',  6, 'м', 4.94, 'C:\Images\image_014.jpg'),
('Фролов',  'Сергей',  'Вадимович',  '06.01.2000',  6, 'м', 4.70, 'C:\Images\image_015.jpg'),
('Грачев',  'Дмитрий',  'Артёмович',  '26.12.2003',  6, 'м', 3.92, 'C:\Images\image_016.jpg'),
('Федосеева',  'Елизавета',  'Сергеевна',  '04.01.2001',  6, 'ж', 3.34, 'C:\Images\image_017.jpg'),
('Леонтьева',  'Оливия',  'Владимировна',  '04.12.2000',  6, 'ж', 4.22, 'C:\Images\image_018.jpg'),
('Трифонова',  'Любовь',  'Андреевна',  '01.07.2001',  6, 'ж', 4.61, 'C:\Images\image_019.jpg'),
('Иванова',  'Анастасия',  'Александровна',  '27.06.2003',  6, 'ж', 4.70, 'C:\Images\image_020.jpg'),
('Демидов',  'Марк',  'Романович',  '25.03.2000',  6, 'м', 3.01, 'C:\Images\image_021.jpg'),
('Журавлев',  'Тимофей',  'Матвеевич',  '27.06.2001',  6, 'м', 3.04, 'C:\Images\image_022.jpg'),
('Зорина',  'Ксения',  'Петровна',  '22.08.2002',  6, 'ж', 4.98, 'C:\Images\image_023.jpg'),
('Богомолова',  'Таисия',  'Марковна',  '12.04.2002',  6, 'ж', 4.33, 'C:\Images\image_024.jpg'),
('Смирнова',  'Кристина',  'Арсентьевна',  '23.12.2003',  6, 'ж', 4.98, 'C:\Images\image_025.jpg'),
('Ильинский',  'Ярослав',  'Ильич',  '01.01.1999',  6, 'м', 3.10, 'C:\Images\image_026.jpg'),
('Быкова',  'Камилла',  'Кирилловна',  '15.09.1999',  6, 'ж', 4.77, 'C:\Images\image_027.jpg'),
('Кузнецова',  'Алиса',  'Денисовна',  '03.05.2000',  6, 'ж', 3.51, 'C:\Images\image_028.jpg'),
('Кулакова',  'Анастасия',  'Леоновна',  '29.09.2002',  6, 'ж', 3.53, 'C:\Images\image_029.jpg'),
('Сурков',  'Сергей',  'Максимович',  '01.06.2003',  6, 'м', 3.11, 'C:\Images\image_030.jpg'),
('Исаев',  'Максим',  'Артемьевич',  '16.05.1999',  6, 'м', 3.81, 'C:\Images\image_031.jpg'),
('Мартынов',  'Тимофей',  'Артёмович',  '01.11.2001',  6, 'м', 3.02, 'C:\Images\image_032.jpg'),
('Чижова',  'Майя',  'Дмитриевна',  '23.04.2003',  6, 'ж', 3.70, 'C:\Images\image_033.jpg'),
('Моисеева',  'Анастасия',  'Давидовна',  '29.05.2003',  6, 'ж', 3.49, 'C:\Images\image_034.jpg'),
('Михайлов',  'Илья',  'Эмильевич',  '06.06.2001',  6, 'м', 3.71, 'C:\Images\image_035.jpg'),
('Черняева',  'Марьяна',  'Тимофеевна',  '07.10.2000',  6, 'ж', 3.16, 'C:\Images\image_036.jpg'),
('Бородина',  'Анастасия',  'Родионовна',  '13.12.2003',  6, 'ж', 4.41, 'C:\Images\image_037.jpg'),
('Орлов',  'Артём',  'Ярославович',  '19.04.2001',  6, 'м', 3.76, 'C:\Images\image_038.jpg'),
('Скворцов',  'Даниил',  'Семёнович',  '17.02.2003',  6, 'м', 3.02, 'C:\Images\image_039.jpg'),
('Журавлева',  'Ульяна',  'Сергеевна',  '11.07.1999',  6, 'ж', 4.59, 'C:\Images\image_040.jpg'),
('Корнев',  'Марк',  'Романович',  '13.05.2002',  7, 'м', 4.07, 'C:\Images\image_041.jpg'),
('Титова',  'Вероника',  'Артёмовна',  '09.10.1999',  7, 'ж', 4.83, 'C:\Images\image_042.jpg'),
('Беляева',  'Вероника',  'Арсентьевна',  '08.06.1999',  7, 'ж', 4.71, 'C:\Images\image_043.jpg'),
('Зуев',  'Никита',  'Яковлевич',  '05.02.2002',  7, 'м', 4.33, 'C:\Images\image_044.jpg'),
('Лавров',  'Артём',  'Давидович',  '20.03.2002',  7, 'м', 4.36, 'C:\Images\image_045.jpg'),
('Соколова',  'Дарья',  'Александровна',  '12.03.2000',  7, 'ж', 4.79, 'C:\Images\image_046.jpg'),
('Семенова',  'Ульяна',  'Артёмовна',  '03.04.1999',  7, 'ж', 4.61, 'C:\Images\image_047.jpg'),
('Афанасьева',  'Диана',  'Мироновна',  '15.06.1999',  7, 'ж', 4.36, 'C:\Images\image_048.jpg'),
('Свиридова',  'Мария',  'Арсентьевна',  '19.01.2000',  7, 'ж', 3.65, 'C:\Images\image_049.jpg'),
('Носова',  'Лилия',  'Артёмовна',  '25.05.2001',  7, 'ж', 3.03, 'C:\Images\image_050.jpg'),
('Сорокина',  'Кристина',  'Богдановна',  '26.03.2002',  7, 'ж', 3.70, 'C:\Images\image_051.jpg'),
('Беляков',  'Мирон',  'Андреевич',  '04.11.2000',  7, 'м', 3.98, 'C:\Images\image_052.jpg'),
('Русанова',  'Анна',  'Ивановна',  '25.07.2002',  7, 'ж', 3.42, 'C:\Images\image_053.jpg'),
('Марков',  'Матвей',  'Денисович',  '26.01.1999',  7, 'м', 4.55, 'C:\Images\image_054.jpg'),
('Мухин',  'Леонид',  'Павлович',  '09.04.2003',  7, 'м', 4.35, 'C:\Images\image_055.jpg'),
('Николаев',  'Вячеслав',  'Серафимович',  '19.06.1999',  7, 'м', 4.20, 'C:\Images\image_056.jpg'),
('Максимова',  'Олеся',  'Фёдоровна',  '21.03.2001',  7, 'ж', 3.41, 'C:\Images\image_057.jpg'),
('Мухин',  'Максим',  'Александрович',  '02.01.2001',  7, 'м', 4.53, 'C:\Images\image_058.jpg'),
('Балашов',  'Степан',  'Адамович',  '21.07.2002',  7, 'м', 4.96, 'C:\Images\image_059.jpg'),
('Максимова',  'Зоя',  'Марковна',  '19.11.2000',  7, 'ж', 4.95, 'C:\Images\image_060.jpg'),
('Николаева',  'Елизавета',  'Фёдоровна',  '31.07.2002',  7, 'ж', 3.37, 'C:\Images\image_061.jpg'),
('Карташова',  'Дарья',  'Михайловна',  '05.08.2000',  7, 'ж', 3.70, 'C:\Images\image_062.jpg'),
('Наумов',  'Макар',  'Тимурович',  '03.06.2003',  7, 'м', 4.62, 'C:\Images\image_063.jpg'),
('Полякова',  'Ева',  'Макаровна',  '09.02.1999',  10, 'ж', 3.52, 'C:\Images\image_064.jpg'),
('Яковлев',  'Тимофей',  'Глебович',  '03.08.2000',  10, 'м', 3.28, 'C:\Images\image_065.jpg'),
('Васильева',  'Малика',  'Глебовна',  '03.03.2003',  10, 'ж', 4.90, 'C:\Images\image_066.jpg'),
('Егорова',  'Ирина',  'Артёмовна',  '13.06.2003',  10, 'ж', 3.93, 'C:\Images\image_067.jpg'),
('Соколов',  'Всеволод',  'Георгиевич',  '26.09.1999',  10, 'м', 4.97, 'C:\Images\image_068.jpg'),
('Мельникова',  'Василиса',  'Романовна',  '15.04.2001',  10, 'ж', 4.81, 'C:\Images\image_069.jpg'),
('Павлова',  'Анастасия',  'Владиславовна',  '22.08.2001',  10, 'ж', 4.41, 'C:\Images\image_070.jpg'),
('Фомина',  'Алиса',  'Львовна',  '06.12.2002',  10, 'ж', 4.05, 'C:\Images\image_071.jpg'),
('Некрасова',  'Виктория',  'Дмитриевна',  '18.07.2000',  10, 'ж', 4.32, 'C:\Images\image_072.jpg'),
('Николаева',  'Есения',  'Кирилловна',  '15.01.1999',  10, 'ж', 4.82, 'C:\Images\image_073.jpg'),
('Баженов',  'Иван',  'Богданович',  '22.11.2002',  10, 'м', 4.84, 'C:\Images\image_074.jpg'),
('Алехина',  'Александра',  'Григорьевна',  '23.07.2003',  10, 'ж', 3.47, 'C:\Images\image_075.jpg'),
('Леонтьев',  'Тимофей',  'Алексеевич',  '08.07.2000',  10, 'м', 3.80, 'C:\Images\image_076.jpg'),
('Шаповалова',  'Диана',  'Дмитриевна',  '20.11.2000',  10, 'ж', 4.04, 'C:\Images\image_077.jpg'),
('Иванов',  'Александр',  'Романович',  '11.01.2000',  10, 'м', 3.56, 'C:\Images\image_078.jpg'),
('Евдокимова',  'Виктория',  'Артёмовна',  '15.07.2001',  10, 'ж', 3.09, 'C:\Images\image_079.jpg'),
('Молчанов',  'Максим',  'Кириллович',  '18.07.2003',  10, 'м', 3.81, 'C:\Images\image_080.jpg'),
('Куприянова',  'Анна',  'Захаровна',  '17.07.2002',  10, 'ж', 4.25, 'C:\Images\image_081.jpg'),
('Калмыкова',  'Полина',  'Андреевна',  '10.07.2003',  10, 'ж', 3.83, 'C:\Images\image_082.jpg'),
('Седов',  'Михаил',  'Егорович',  '06.11.2001',  10, 'м', 4.21, 'C:\Images\image_083.jpg'),
('Суханова',  'Ульяна',  'Павловна',  '09.02.2003',  10, 'ж', 3.28, 'C:\Images\image_084.jpg'),
('Павлова',  'Анна',  'Павловна',  '04.02.2003',  10, 'ж', 3.68, 'C:\Images\image_085.jpg'),
('Крылова',  'Варвара',  'Александровна',  '31.03.2003',  10, 'ж', 4.61, 'C:\Images\image_086.jpg'),
('Тимофеев',  'Василий',  'Львович',  '12.08.2000',  10, 'м', 3.29, 'C:\Images\image_087.jpg'),
('Емельянова',  'Полина',  'Алексеевна',  '20.09.2002',  10, 'ж', 4.95, 'C:\Images\image_088.jpg'),
('Сафонова',  'Екатерина',  'Алексеевна',  '02.11.2000',  10, 'ж', 3.24, 'C:\Images\image_089.jpg'),
('Колесникова',  'Мария',  'Владиславовна',  '30.06.2002',  11, 'ж', 3.87, 'C:\Images\image_090.jpg'),
('Григорьева',  'Полина',  'Руслановна',  '17.07.2001',  11, 'ж', 4.41, 'C:\Images\image_091.jpg'),
('Васильев',  'Мирослав',  'Алексеевич',  '25.04.2001',  11, 'м', 3.32, 'C:\Images\image_092.jpg'),
('Соколова',  'Станислава',  'Алексеевна',  '01.12.1999',  11, 'ж', 3.88, 'C:\Images\image_093.jpg'),
('Бондарева',  'Ясмина',  'Михайловна',  '19.08.1999',  11, 'ж', 4.93, 'C:\Images\image_094.jpg'),
('Макарова',  'Мария',  'Дмитриевна',  '07.12.2001',  11, 'ж', 3.69, 'C:\Images\image_095.jpg'),
('Николаева',  'Алиса',  'Андреевна',  '21.08.2000',  11, 'ж', 3.43, 'C:\Images\image_096.jpg'),
('Еремеев',  'Николай',  'Демидович',  '17.05.2001',  11, 'м', 3.75, 'C:\Images\image_097.jpg'),
('Данилова',  'Алёна',  'Давидовна',  '16.11.2003',  11, 'ж', 4.55, 'C:\Images\image_098.jpg'),
('Егоров',  'Ярослав',  'Арсентьевич',  '20.07.2003',  11, 'м', 4.35, 'C:\Images\image_099.jpg'),
('Полякова',  'Анна',  'Арсентьевна',  '31.05.2002',  11, 'ж', 4.06, 'C:\Images\image_100.jpg'),
('Кузнецова',  'Валерия',  'Всеволодовна',  '02.07.2001',  11, 'ж', 4.65, 'C:\Images\image_101.jpg'),
('Агафонова',  'Светлана',  'Михайловна',  '03.03.1999',  11, 'ж', 4.88, 'C:\Images\image_102.jpg'),
('Данилов',  'Богдан',  'Михайлович',  '16.10.2002',  11, 'м', 3.83, 'C:\Images\image_103.jpg'),
('Новиков',  'Лев',  'Николаевич',  '20.03.2001',  11, 'м', 3.14, 'C:\Images\image_104.jpg'),
('Чернышева',  'Александра',  'Тимофеевна',  '09.06.2001',  11, 'ж', 3.38, 'C:\Images\image_105.jpg'),
('Фролов',  'Владимир',  'Никитич',  '02.05.2003',  12, 'м', 4.74, 'C:\Images\image_106.jpg'),
('Тимофеева',  'Милана',  'Алиевна',  '29.07.2002',  12, 'ж', 4.81, 'C:\Images\image_107.jpg'),
('Козлова',  'София',  'Ильинична',  '05.05.1999',  12, 'ж', 4.54, 'C:\Images\image_108.jpg'),
('Емельянов',  'Алексей',  'Владиславович',  '29.04.2002',  12, 'м', 4.32, 'C:\Images\image_109.jpg'),
('Мартынов',  'Артём',  'Тимофеевич',  '29.09.2001',  12, 'м', 3.11, 'C:\Images\image_110.jpg'),
('Абрамова',  'Елизавета',  'Степановна',  '04.06.1999',  12, 'ж', 3.08, 'C:\Images\image_111.jpg'),
('Афанасьева',  'Анастасия',  'Романовна',  '22.11.2002',  12, 'ж', 4.71, 'C:\Images\image_112.jpg'),
('Островский',  'Иван',  'Александрович',  '24.02.2003',  12, 'м', 4.04, 'C:\Images\image_113.jpg'),
('Васильева',  'Полина',  'Романовна',  '29.10.1999',  12, 'ж', 3.09, 'C:\Images\image_114.jpg'),
('Крылова',  'Василиса',  'Матвеевна',  '04.07.2002',  12, 'ж', 4.00, 'C:\Images\image_115.jpg'),
('Козлов',  'Степан',  'Ибрагимович',  '15.07.2003',  12, 'м', 3.41, 'C:\Images\image_116.jpg'),
('Королева',  'Ясмина',  'Сергеевна',  '10.03.2001',  12, 'ж', 3.87, 'C:\Images\image_117.jpg'),
('Афанасьева',  'Ксения',  'Романовна',  '11.06.2002',  12, 'ж', 4.95, 'C:\Images\image_118.jpg'),
('Евсеев',  'Лев',  'Маркович',  '21.12.2001',  12, 'м', 4.89, 'C:\Images\image_119.jpg'),
('Соколова',  'София',  'Дмитриевна',  '23.08.2000',  13, 'ж', 3.81, 'C:\Images\image_001.jpg'),
('Герасимов',  'Ибрагим',  'Георгиевич',  '18.04.2000',  13, 'м', 3.51, 'C:\Images\image_002.jpg'),
('Андреева',  'Мария',  'Марковна',  '18.11.2000',  13, 'ж', 4.68, 'C:\Images\image_003.jpg'),
('Попова',  'Арина',  'Максимовна',  '25.03.2002',  13, 'ж', 3.24, 'C:\Images\image_004.jpg'),
('Лазарев',  'Михаил',  'Иванович',  '27.12.1999',  13, 'м', 3.68, 'C:\Images\image_005.jpg'),
('Федотова',  'Ольга',  'Артёмовна',  '06.12.1999',  13, 'ж', 4.42, 'C:\Images\image_006.jpg'),
('Беляева',  'Алёна',  'Макаровна',  '07.08.2002',  13, 'ж', 4.23, 'C:\Images\image_007.jpg'),
('Зуева',  'Елизавета',  'Егоровна',  '28.05.2003',  13, 'ж', 3.78, 'C:\Images\image_008.jpg'),
('Тарасов',  'Никита',  'Артурович',  '15.07.2000',  13, 'м', 4.13, 'C:\Images\image_009.jpg'),
('Иванов',  'Тимур',  'Захарович',  '08.12.2000',  13, 'м', 4.65, 'C:\Images\image_010.jpg'),
('Кулешов',  'Илья',  'Даниилович',  '11.11.2003',  13, 'м', 4.14, 'C:\Images\image_011.jpg'),
('Игнатьев',  'Константин',  'Эрикович',  '06.10.2002',  13, 'м', 4.32, 'C:\Images\image_012.jpg'),
('Комаров',  'Мирон',  'Дмитриевич',  '08.07.2003',  13, 'м', 4.19, 'C:\Images\image_013.jpg'),
('Нефедов',  'Максим',  'Давидович',  '15.03.2002',  13, 'м', 4.90, 'C:\Images\image_014.jpg'),
('Некрасов',  'Дмитрий',  'Демидович',  '22.03.1999',  13, 'м', 4.64, 'C:\Images\image_015.jpg'),
('Пантелеева',  'Александра',  'Сергеевна',  '28.02.2002',  14, 'ж', 3.98, 'C:\Images\image_016.jpg'),
('Осипов',  'Артём',  'Никитич',  '21.04.2001',  14, 'м', 3.42, 'C:\Images\image_017.jpg'),
('Еремин',  'Павел',  'Кириллович',  '01.09.2003',  14, 'м', 3.64, 'C:\Images\image_018.jpg'),
('Ковалева',  'Елена',  'Артёмовна',  '19.03.2001',  14, 'ж', 4.37, 'C:\Images\image_019.jpg'),
('Терехов',  'Леонид',  'Богданович',  '13.09.2001',  14, 'м', 3.45, 'C:\Images\image_020.jpg'),
('Капустина',  'Виктория',  'Родионовна',  '21.09.2003',  14, 'ж', 3.75, 'C:\Images\image_021.jpg'),
('Максимова',  'Елена',  'Глебовна',  '22.05.2001',  14, 'ж', 4.39, 'C:\Images\image_022.jpg'),
('Фролова',  'Алиса',  'Давидовна',  '25.03.2000',  14, 'ж', 4.63, 'C:\Images\image_023.jpg'),
('Кузнецов',  'Егор',  'Константинович',  '11.03.2002',  14, 'м', 3.86, 'C:\Images\image_024.jpg'),
('Семин',  'Матвей',  'Алексеевич',  '19.12.1999',  14, 'м', 3.77, 'C:\Images\image_025.jpg'),
('Горбачева',  'Василиса',  'Андреевна',  '28.08.2001',  14, 'ж', 4.27, 'C:\Images\image_026.jpg'),
('Скворцова',  'Лилия',  'Антоновна',  '28.07.2000',  14, 'ж', 4.45, 'C:\Images\image_027.jpg'),
('Мартынов',  'Иван',  'Михайлович',  '30.03.2000',  14, 'м', 3.25, 'C:\Images\image_028.jpg'),
('Мальцева',  'Мария',  'Марковна',  '24.12.2002',  14, 'ж', 3.51, 'C:\Images\image_029.jpg'),
('Максимова',  'Диана',  'Михайловна',  '15.05.2000',  14, 'ж', 4.83, 'C:\Images\image_030.jpg'),
('Смирнова',  'Елизавета',  'Антоновна',  '18.12.2001',  14, 'ж', 3.45, 'C:\Images\image_031.jpg'),
('Сидоров',  'Михаил',  'Сергеевич',  '27.03.1999',  14, 'м', 4.01, 'C:\Images\image_032.jpg'),
('Нестерова',  'Ульяна',  'Александровна',  '15.07.1999',  14, 'ж', 4.55, 'C:\Images\image_033.jpg'),
('Иванов',  'Семён',  'Всеволодович',  '19.04.2002',  16, 'м', 4.29, 'C:\Images\image_034.jpg'),
('Голубев',  'Денис',  'Никитич',  '04.02.2000',  16, 'м', 4.10, 'C:\Images\image_035.jpg'),
('Савин',  'Денис',  'Игоревич',  '22.08.1999',  16, 'м', 3.16, 'C:\Images\image_036.jpg'),
('Андреева',  'Виктория',  'Владиславовна',  '12.11.2002',  16, 'ж', 4.47, 'C:\Images\image_037.jpg'),
('Попов',  'Денис',  'Семёнович',  '01.07.2002',  16, 'м', 3.04, 'C:\Images\image_038.jpg'),
('Ананьева',  'Лидия',  'Григорьевна',  '11.12.1999',  16, 'ж', 3.30, 'C:\Images\image_039.jpg'),
('Калашников',  'Николай',  'Глебович',  '06.12.2002',  16, 'м', 4.89, 'C:\Images\image_040.jpg'),
('Соколова',  'Арина',  'Антоновна',  '25.09.2001',  17, 'ж', 4.58, 'C:\Images\image_041.jpg'),
('Иванова',  'Таисия',  'Филипповна',  '28.11.2003',  17, 'ж', 3.95, 'C:\Images\image_042.jpg'),
('Лебедева',  'Вероника',  'Михайловна',  '11.04.2000',  17, 'ж', 4.41, 'C:\Images\image_043.jpg'),
('Гришина',  'Эмилия',  'Тимофеевна',  '01.07.2003',  17, 'ж', 4.16, 'C:\Images\image_044.jpg'),
('Морозова',  'Анна',  'Эмировна',  '30.10.2002',  17, 'ж', 3.86, 'C:\Images\image_045.jpg'),
('Волкова',  'Есения',  'Савельевна',  '11.01.2002',  18, 'ж', 3.50, 'C:\Images\image_046.jpg'),
('Алексеев',  'Кирилл',  'Ярославович',  '03.07.2001',  18, 'м', 4.18, 'C:\Images\image_047.jpg'),
('Горбунов',  'Данила',  'Даниилович',  '09.03.2001',  18, 'м', 5.00, 'C:\Images\image_048.jpg'),
('Шишкин',  'Александр',  'Михайлович',  '18.12.1999',  18, 'м', 3.23, 'C:\Images\image_049.jpg'),
('Тихонова',  'Мария',  'Глебовна',  '21.02.2000',  18, 'ж', 4.62, 'C:\Images\image_050.jpg'),
('Тарасов',  'Даниил',  'Даниилович',  '09.11.2002',  18, 'м', 3.01, 'C:\Images\image_051.jpg'),
('Воронцова',  'Эмма',  'Евгеньевна',  '15.12.1999',  18, 'ж', 3.68, 'C:\Images\image_052.jpg'),
('Литвинова',  'Мирослава',  'Романовна',  '10.07.2002',  18, 'ж', 3.73, 'C:\Images\image_053.jpg'),
('Смирнова',  'Серафима',  'Львовна',  '09.12.2003',  18, 'ж', 3.16, 'C:\Images\image_054.jpg'),
('Смирнова',  'Алиса',  'Фёдоровна',  '26.06.2001',  18, 'ж', 3.46, 'C:\Images\image_055.jpg'),
('Горячева',  'София',  'Артёмовна',  '04.11.2000',  18, 'ж', 3.93, 'C:\Images\image_056.jpg'),
('Андреева',  'Милана',  'Марковна',  '07.12.2000',  19, 'ж', 3.23, 'C:\Images\image_057.jpg'),
('Волкова',  'Ева',  'Андреевна',  '23.06.2003',  19, 'ж', 4.01, 'C:\Images\image_058.jpg'),
('Ильинская',  'Дарья',  'Максимовна',  '03.01.2001',  19, 'м', 4.69, 'C:\Images\image_059.jpg'),
('Захаров',  'Владимир',  'Константинович',  '12.05.1999',  19, 'м', 3.88, 'C:\Images\image_060.jpg'),
('Степанова',  'Юлия',  'Дмитриевна',  '05.09.2002',  19, 'ж', 4.18, 'C:\Images\image_061.jpg'),
('Максимов',  'Мирон',  'Михайлович',  '22.07.2002',  19, 'м', 4.68, 'C:\Images\image_062.jpg');


GO
