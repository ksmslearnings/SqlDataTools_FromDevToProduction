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
