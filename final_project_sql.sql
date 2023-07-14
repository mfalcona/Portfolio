/****** Object:  Database ist722_caharper_oa2_dw    Script Date: 12/14/20 1:49:08 PM ******/
/*
Kimball Group, The Microsoft Data Warehouse Toolkit
Generate a database from the datamodel worksheet, version: 4

You can use this Excel workbook as a data modeling tool during the logical design phase of your project.
As discussed in the book, it is in some ways preferable to a real data modeling tool during the inital design.
We expect you to move away from this spreadsheet and into a real modeling tool during the physical design phase.
The authors provide this macro so that the spreadsheet isn't a dead-end. You can 'import' into your
data modeling tool by generating a database using this script, then reverse-engineering that database into
your tool.

Uncomment the next lines if you want to drop and create the database
*/
/*
DROP DATABASE ist722_caharper_oa2_dw
GO
CREATE DATABASE ist722_caharper_oa2_dw
GO
ALTER DATABASE ist722_caharper_oa2_dw
SET RECOVERY SIMPLE
GO
*/
USE ist722_caharper_oa2_dw
;
IF EXISTS (SELECT Name from sys.extended_properties where Name = 'Description')
    EXEC sys.sp_dropextendedproperty @name = 'Description'
EXEC sys.sp_addextendedproperty @name = 'Description', @value = 'Default description - you should change this.'
;





-- Create a schema to hold user views (set schema name on home page of workbook).
-- It would be good to do this only if the schema doesn't exist already.
GO
CREATE SCHEMA fudgeinc
GO






/* Drop table fudgeinc.DimAccounts */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeinc.DimAccounts') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeinc.DimAccounts
;

/* Create table fudgeinc.DimAccounts */
CREATE TABLE fudgeinc.DimAccounts (
   [account_key]  int IDENTITY  NOT NULL
,  [account_id]  int   NOT NULL
,  [account_firstname]  varchar(50)   NOT NULL
,  [account_lastname]  varchar(50)   NOT NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudgeinc.DimAccounts] PRIMARY KEY CLUSTERED
( [account_key] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimAccounts
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimAccounts', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimAccounts
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimAccounts
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Accounts dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimAccounts
;

SET IDENTITY_INSERT fudgeinc.DimAccounts ON
;
INSERT INTO fudgeinc.DimAccounts (account_key, account_id, account_firstname, account_lastname, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'None', 'None', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudgeinc.DimAccounts OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeinc].[DimAccounts]'))
DROP VIEW [fudgeinc].[DimAccounts]
GO
CREATE VIEW [fudgeinc].[DimAccounts] AS
SELECT [account_key] AS [account_key]
, [account_id] AS [account_id]
, [account_firstname] AS [account_firstname]
, [account_lastname] AS [account_lastname]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM fudgeinc.DimAccounts
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'account_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'account_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'account_firstname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'account_lastname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Account holders first name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The Account holders last name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Misty', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Meadows', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/11', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_accounts', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_accounts', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_accounts', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_firstname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_lastname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_id';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_firstname';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimAccounts', @level2type=N'COLUMN', @level2name=N'account_lastname';
;





/* Drop table fudgeinc.DimTitles */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeinc.DimTitles') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeinc.DimTitles
;

/* Create table fudgeinc.DimTitles */
CREATE TABLE fudgeinc.DimTitles (
   [title_key]  int IDENTITY  NOT NULL
,  [title_id]  varchar(20)   NOT NULL
,  [title_name]  varchar(200)   NOT NULL
,  [title_avg_rating]  decimal(3,2)   NOT NULL
,  [title_runtime]  int   NOT NULL
,  [title_release_year]  int   NOT NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudgeinc.DimTitles] PRIMARY KEY CLUSTERED
( [title_key] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitles
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimTitles', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitles
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitles
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Titles dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitles
;

SET IDENTITY_INSERT fudgeinc.DimTitles ON
;
INSERT INTO fudgeinc.DimTitles (title_key, title_id, title_name, title_avg_rating, title_runtime, title_release_year, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'Unk', 'None', 0, 0, -1, 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudgeinc.DimTitles OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeinc].[DimTitles]'))
DROP VIEW [fudgeinc].[DimTitles]
GO
CREATE VIEW [fudgeinc].[DimTitles] AS
SELECT [title_key] AS [title_key]
, [title_id] AS [title_id]
, [title_name] AS [title_name]
, [title_avg_rating] AS [title_avg_rating]
, [title_runtime] AS [title_runtime]
, [title_release_year] AS [title_release_year]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM fudgeinc.DimTitles
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'title_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'title_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'title_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'title_avg_rating', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'title_runtime', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'title_release_year', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Name of the movie title', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'The average rating the movie''s been rated by customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'total runtime of the movie in seconds', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'release year of the title', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'13kag', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Meet Joe Black', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'3.6', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'10860', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'2000', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/11', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_titles', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_avg_rating', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_runtime', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_release_year', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_id';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_name';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'decimal', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_avg_rating';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_runtime';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitles', @level2type=N'COLUMN', @level2name=N'title_release_year';
;





/* Drop table fudgeinc.DimGenres */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeinc.DimGenres') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeinc.DimGenres
;

/* Create table fudgeinc.DimGenres */
CREATE TABLE fudgeinc.DimGenres (
   [genre_key]  int IDENTITY  NOT NULL
,  [genre_name]  varchar(200)   NOT NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudgeinc.DimGenres] PRIMARY KEY CLUSTERED
( [genre_key] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimGenres
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimGenres', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimGenres
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimGenres
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Genres dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimGenres
;

SET IDENTITY_INSERT fudgeinc.DimGenres ON
;
INSERT INTO fudgeinc.DimGenres (genre_key, genre_name, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'Unk', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudgeinc.DimGenres OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeinc].[DimGenres]'))
DROP VIEW [fudgeinc].[DimGenres]
GO
CREATE VIEW [fudgeinc].[DimGenres] AS
SELECT [genre_key] AS [genre_key]
, [genre_name] AS [genre_name]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM fudgeinc.DimGenres
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'genre_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'genre_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'name of genre of film', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20th Century Period Pieces', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/11', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_key';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_genres', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'genre_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimGenres', @level2type=N'COLUMN', @level2name=N'genre_name';
;





/* Drop table fudgeinc.DimTitleGenre */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeinc.DimTitleGenre') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeinc.DimTitleGenre
;

/* Create table fudgeinc.DimTitleGenre */
CREATE TABLE fudgeinc.DimTitleGenre (
   [tg_key]  int IDENTITY  NOT NULL
,  [genre_name]  varchar(200)   NOT NULL
,  [tg_genre_id]  varchar(20)   NOT NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudgeinc.DimTitleGenre] PRIMARY KEY CLUSTERED
( [tg_key] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitleGenre
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimTitleGenre', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitleGenre
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitleGenre
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'title genre dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimTitleGenre
;

SET IDENTITY_INSERT fudgeinc.DimTitleGenre ON
;
INSERT INTO fudgeinc.DimTitleGenre (tg_key, genre_name, tg_genre_id, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, 'Unk', 'Unk', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudgeinc.DimTitleGenre OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeinc].[DimTitleGenre]'))
DROP VIEW [fudgeinc].[DimTitleGenre]
GO
CREATE VIEW [fudgeinc].[DimTitleGenre] AS
SELECT [tg_key] AS [tg_key]
, [genre_name] AS [genre_name]
, [tg_genre_id] AS [tg_genre_id]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM fudgeinc.DimTitleGenre
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'tg_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'genre_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'tg_genre_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'name of genre of film', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'title ID matchup', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20th Century Period Pieces', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'12kZA', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/11', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_key';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_title_genres', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_title_genres', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'tg_genre_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'tg_title_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimTitleGenre', @level2type=N'COLUMN', @level2name=N'tg_genre_id';
;





/* Drop table fudgeinc.DimCustomers */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeinc.DimCustomers') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeinc.DimCustomers
;

/* Create table fudgeinc.DimCustomers */
CREATE TABLE fudgeinc.DimCustomers (
   [customer_key]  int IDENTITY  NOT NULL
,  [customer_id]  int   NOT NULL
,  [customer_firstname]  varchar(50)   NOT NULL
,  [customer_lastname]  varchar(50)   NOT NULL
,  [customer_state]  char(2)   NOT NULL
,  [RowIsCurrent]  bit   DEFAULT 1 NOT NULL
,  [RowStartDate]  datetime  DEFAULT '12/31/1899' NOT NULL
,  [RowEndDate]  datetime  DEFAULT '12/31/9999' NOT NULL
,  [RowChangeReason]  nvarchar(200)   NULL
, CONSTRAINT [PK_fudgeinc.DimCustomers] PRIMARY KEY CLUSTERED
( [customer_key] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'DimCustomers', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimCustomers
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'Customer dimension', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=DimCustomers
;

SET IDENTITY_INSERT fudgeinc.DimCustomers ON
;
INSERT INTO fudgeinc.DimCustomers (customer_key, customer_id, customer_firstname, customer_lastname, customer_state, RowIsCurrent, RowStartDate, RowEndDate, RowChangeReason)
VALUES (-1, -1, 'Unk', 'Unk', 'Unk', 1, '12/31/1899', '12/31/9999', 'N/A')
;
SET IDENTITY_INSERT fudgeinc.DimCustomers OFF
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeinc].[DimCustomers]'))
DROP VIEW [fudgeinc].[DimCustomers]
GO
CREATE VIEW [fudgeinc].[DimCustomers] AS
SELECT [customer_key] AS [customer_key]
, [customer_id] AS [customer_id]
, [customer_firstname] AS [customer_firstname]
, [customer_lastname] AS [customer_lastname]
, [customer_state] AS [customer_state]
, [RowIsCurrent] AS [Row Is Current]
, [RowStartDate] AS [Row Start Date]
, [RowEndDate] AS [Row End Date]
, [RowChangeReason] AS [Row Change Reason]
FROM fudgeinc.DimCustomers
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_firstname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_lastname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_state', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Is Current', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Start Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row End Date', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'Row Change Reason', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Surrogate primary key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Business key from source system (aka natural key)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'first name of customer', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'last name of customer', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'customer state', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Is this the current row for this member (Y/N)?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become valid for this member?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'When did this row become invalid? (12/31/9999 if current row)', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Why did the row change last?', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3…', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Lisa', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Karforless', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'OH', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'TRUE, FALSE', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/24/11', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1/14/1998, 12/31/9999', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'SCD  Type', @value=N'n/a', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'Exclude from cube', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Standard SCD-2', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowIsCurrent';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowStartDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowEndDate';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'Derived', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'RowChangeReason';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_id', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_firstname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_lastname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_state', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_id';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'char', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'DimCustomers', @level2type=N'COLUMN', @level2name=N'customer_state';
;





/* Drop table fudgeinc.FactCustomerProfile */
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'fudgeinc.FactCustomerProfile') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE fudgeinc.FactCustomerProfile
;

/* Create table fudgeinc.FactCustomerProfile */
CREATE TABLE fudgeinc.FactCustomerProfile (
   [product_key]  int   NOT NULL
,  [account_key]  int   NOT NULL
,  [title_key]  int   NOT NULL
,  [customer_key]  int   NOT NULL
,  [customer_firstname]  varchar(50)   NOT NULL
,  [customer_lastname]  varchar(50)   NOT NULL
,  [customer_state]  char(2)   NOT NULL
,  [genre_name]  varchar(200)   NOT NULL
, CONSTRAINT [PK_fudgeinc.FactCustomerProfile] PRIMARY KEY NONCLUSTERED
( [product_key], [account_key], [title_key], [customer_key] )
) ON [PRIMARY]
;

--Table extended properties...
exec sys.sp_addextendedproperty @name=N'Table Type', @value=N'Fact', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=FactCustomerProfile
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'FactCustomerProfile', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=FactCustomerProfile
exec sys.sp_addextendedproperty @name=N'Database Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=FactCustomerProfile
exec sys.sp_addextendedproperty @name=N'Table Description', @value=N'customer profile fact', @level0type=N'SCHEMA', @level0name=fudgeinc, @level1type=N'TABLE', @level1name=FactCustomerProfile
;

-- User-oriented view definition
GO
IF EXISTS (select * from sys.views where object_id=OBJECT_ID(N'[fudgeinc].[FactCustomerProfile]'))
DROP VIEW [fudgeinc].[FactCustomerProfile]
GO
CREATE VIEW [fudgeinc].[FactCustomerProfile] AS
SELECT [product_key] AS [product_key]
, [account_key] AS [account_key]
, [title_key] AS [title_key]
, [customer_key] AS [customer_key]
, [customer_firstname] AS [customer_firstname]
, [customer_lastname] AS [customer_lastname]
, [customer_state] AS [customer_state]
, [genre_name] AS [genre_name]
FROM fudgeinc.FactCustomerProfile
GO

--Column extended properties
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'product_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'account_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'title_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_firstname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_lastname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'customer_state', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Display Name', @value=N'genre_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimFmProducts', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimAccounts', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimTitle', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'Key to DimCustomer', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'first name of customer', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'last name of customer', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'customer state', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Description', @value=N'name of genre of film', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2, 3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'1, 2 ,3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Lisa', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'Karforless', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'OH', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Example Values', @value=N'20th Century Period Pieces', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Display Folder', @value=N'key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'ETL Rules', @value=N'Surrogate key peipeline lookup for dimension key lookup using business key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'DW', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgemart_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source System', @value=N'fudgeflix_v3', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'fudgeinc', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source Schema', @value=N'dbo', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimProducts', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimAccounts', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimTitles', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'DimCustomers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'fm_customers', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source Table', @value=N'ff_genres', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'product_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'account_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'title_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_key', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_firstname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_lastname', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'customer_state', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source Field Name', @value=N'genre_name', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'product_key';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'account_key';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'title_key';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'int', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_key';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_firstname';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_lastname';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'char', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'customer_state';
exec sys.sp_addextendedproperty @name=N'Source Datatype', @value=N'varchar', @level0type=N'SCHEMA', @level0name=N'fudgeinc', @level1type=N'TABLE', @level1name=N'FactCustomerProfile', @level2type=N'COLUMN', @level2name=N'genre_name';
;
ALTER TABLE fudgeinc.FactCustomerProfile ADD CONSTRAINT
   FK_fudgeinc_FactCustomerProfile_product_key FOREIGN KEY
   (
   product_key
   ) REFERENCES DimProducts
   ( product_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE fudgeinc.FactCustomerProfile ADD CONSTRAINT
   FK_fudgeinc_FactCustomerProfile_account_key FOREIGN KEY
   (
   account_key
   ) REFERENCES DimAccounts
   ( account_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE fudgeinc.FactCustomerProfile ADD CONSTRAINT
   FK_fudgeinc_FactCustomerProfile_title_key FOREIGN KEY
   (
   title_key
   ) REFERENCES DimTitles
   ( title_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;

ALTER TABLE fudgeinc.FactCustomerProfile ADD CONSTRAINT
   FK_fudgeinc_FactCustomerProfile_customer_key FOREIGN KEY
   (
   customer_key
   ) REFERENCES DimCustomers
   ( customer_key )
     ON UPDATE  NO ACTION
     ON DELETE  NO ACTION
;
