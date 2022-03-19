use master;
GO

    /*** Создание базы данных ***/
if DB_ID('Сollege') is NOT NULL
	drop database College;		
GO
create database College;			
GO

use College;

	/*** Создание таблицы Specialties ***/
IF EXISTS (SELECT * FROM College.Tables WHERE NAME = 'Specialties')
	DROP TABLE Specialties;						
GO
CREATE TABLE Specialties
(	SpecialtyID 	    VARCHAR(8)	   	NOT NULL,	       
	SpecialtyName       NVARCHAR(150)   NOT NULL,			
    SpecialtyReduction  NVARCHAR(3)     NOT NULL,       
	CONSTRAINT PK_Specialties
		PRIMARY KEY (SpecialtyCode)
);
GO

	/*** Создание таблицы Groups ***/
IF EXISTS (SELECT * FROM College.Tables WHERE NAME = 'Groups')
	DROP TABLE Groups;						
GO
CREATE TABLE Groups
(	GroupSpecialtyID    VARCHAR(8)	   	NOT NULL,	     
	GroupCode           NVARCHAR(150)   NOT NULL,	
	CONSTRAINT PK_Groups
		PRIMARY KEY (SpecialtyCode)
);
GO