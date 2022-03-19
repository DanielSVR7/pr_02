use master;
GO
    /*** Создание базы данных ***/
if DB_ID('College') is NOT NULL
	drop database College;		
GO
create database College;			
GO

use College;

	/*** Создание таблицы Specialties ***/
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = 'Specialties')
	DROP TABLE Specialties;						
GO
CREATE TABLE Specialties
(	SpecialtyID       NVARCHAR(3)       NOT NULL,			
    SpecialtyName     NVARCHAR(150)     NOT NULL,     
    SpecialtyCode     NVARCHAR(8)       NOT NULL,
	CONSTRAINT PK_Specialties
		PRIMARY KEY (SpecialtyID)
);
GO

	/*** Создание таблицы Groups ***/
IF EXISTS (SELECT * FROM sys.tables WHERE NAME = 'Groups')
	DROP TABLE Groups;						
GO
CREATE TABLE Groups
(   GroupID         INT             NOT NULL IDENTITY,
	SpecialtyID     NVARCHAR(3)     NOT NULL,	     
	GroupNumber     NVARCHAR(3)     NOT NULL,	
	CONSTRAINT PK_Groups
		PRIMARY KEY (GroupID),
    CONSTRAINT FK_Groups_Specialties
        FOREIGN KEY (SpecialtyID)
            REFERENCES Specialties (SpecialtyID)
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