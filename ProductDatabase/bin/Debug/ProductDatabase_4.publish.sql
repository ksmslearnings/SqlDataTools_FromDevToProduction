﻿/*
Deployment script for ProductDatabase

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar PriceDatabase "PriceDatabase"
:setvar ServerName "LAPTOP-SO8773KH"
:setvar ProductDBName "ProductDatabase"
:setvar DatabaseName "ProductDatabase"
:setvar DefaultFilePrefix "ProductDatabase"
:setvar DefaultDataPath "D:\SQLServer2017DeveloperEdition\MSSQL14.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "D:\SQLServer2017DeveloperEdition\MSSQL14.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Dropping [dbo].[Synonym_PriceDatabase_PriceTable]...';


GO
DROP SYNONYM [dbo].[Synonym_PriceDatabase_PriceTable];


GO
PRINT N'Creating [dbo].[Synonym_PriceDatabase_PriceTable]...';


GO
CREATE SYNONYM [dbo].[Synonym_PriceDatabase_PriceTable] FOR [$(ServerName)].[$(PriceDatabase)].[dbo].[ProductPrice];


GO
PRINT N'Creating [dbo].[GetAllProductDetails]...';


GO
-- =============================================
-- Author:		Kunal Sehgal - Sample for SSDT tools
-- Create date: 28 July 2020<Create Date,,>
-- Description:	Get All products aong with their prices information
-- =============================================
CREATE PROCEDURE GetAllProductDetails
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select 
	p.ProductId,
	p.ProductName,
	PriceTableSynonym.Price,
	p.ProductCategoryId,
	pc.ProductCategoryName,
	p.CreatedDate,
	p.CreatedBy,
	p.ProductPriceId	
	from ProductList p 
	inner join ProductCategory pc
		on p.ProductCategoryId = pc.ProductCategoryId
	inner join Synonym_PriceDatabase_PriceTable PriceTableSynonym
		on p.ProductPriceId = PriceTableSynonym.ProductPriceId

END
GO
PRINT N'Creating [dbo].[GetAllProductsByCategory]...';


GO
-- =============================================
-- Author:		Kunal Sehgal - Sample for SSDT tools
-- Create date: 28 July 2020<Create Date,,>
-- Description:	Get All products aong with their prices information
-- =============================================
CREATE PROCEDURE GetAllProductsByCategory(@categoryId bigint)
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select 
	p.ProductId,
	p.ProductName,
	PriceTableSynonym.Price,
	p.ProductCategoryId,
	pc.ProductCategoryName,
	p.CreatedDate,
	p.CreatedBy,
	p.ProductPriceId	
	from ProductList p 
	inner join ProductCategory pc
		on p.ProductCategoryId = pc.ProductCategoryId
	inner join Synonym_PriceDatabase_PriceTable PriceTableSynonym
		on p.ProductPriceId = PriceTableSynonym.ProductPriceId
	
	where p.ProductCategoryId=@categoryId

END
GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

Print 'Insert Master Data in Product Database - Started'

declare @rowcount int = (select count(1) from [dbo].[ProductCategory])
if @rowcount <> 3
begin

Truncate table [dbo].[ProductCategory]

INSERT INTO [dbo].[ProductCategory]
           ([ProductCategoryName]
           ,[CreatedDate]
           ,[CreatedBy]
           ,[ModifiedDate]
           ,[ModifiedBy])
     VALUES        
		   ('Phone',getdate(),'Kunal Sehgal',null,null),
		   ('TV',getdate(),'Kunal Sehgal',null,null),
		   ('Sports',getdate(),'Kunal Sehgal',null,null)
end



            
select @rowcount = count(1) from [dbo].[ProductCategory]
if @rowcount <> 9
begin

truncate table [dbo].[ProductList]

INSERT INTO [dbo].[ProductList]
           ([ProductPriceId]
           ,[ProductName]
           ,[ProductCategoryId]
           ,[CreatedDate]
           ,[CreatedBy]
           ,[ModifiedDate]
           ,[ModifiedBy])
     VALUES
           (1,'SamsonMobile X10',1,getdate(),'Kunal Sehgal',null,null),
		   (2,'NokEAA N98',1,getdate(),'Kunal Sehgal',null,null),
		   (3,'SieErricson M10',1,getdate(),'Kunal Sehgal',null,null),

		   (4,'SOMAS LED TV',2,getdate(),'Kunal Sehgal',null,null),
		   (5,'NIKOS LCD HD',2,getdate(),'Kunal Sehgal',null,null),
		   (6,'Westwild LED XL',2,getdate(),'Kunal Sehgal',null,null),

		   (7,'HandBall',3,getdate(),'Kunal Sehgal',null,null),
		   (8,'Jumping Jack Trainer',3,getdate(),'Kunal Sehgal',null,null),
		   (9,'Wrist Strengthner',3,getdate(),'Kunal Sehgal',null,null)


end
GO

Print 'Insert Master Data in Product Database - Completed'

Print '********************************************************************'
Print '********************************************************************'

Print 'Call Main SQL Script for Current Release - Started'

--STEP 1
--To be Run in August 2020 Release Only
-- This is for Current Release for demonstration
INSERT INTO [dbo].[ProductCategory]
           ([ProductCategoryName]
           ,[CreatedDate]
           ,[CreatedBy]
           ,[ModifiedDate]
           ,[ModifiedBy])
     VALUES        
		   ('Natural Products',getdate(),'Kunal Sehgal',null,null)

GO

--STEP 2
-- Dummy Script for Demonstration which can be handling any DMLs required in Release.
select top 1 * from ProductCategory
GO



Print 'Call Main SQL Script for Current Release - Completed'


GO

GO
PRINT N'Update complete.';


GO
