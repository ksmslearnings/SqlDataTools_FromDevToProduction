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

:r .\DMLScripts\MasterDataScripts\ProductCategory.sql
            
:r .\DMLScripts\MasterDataScripts\ProductList.sql

Print 'Insert Master Data in Product Database - Completed'

Print '********************************************************************'
Print '********************************************************************'

Print 'Call Main SQL Script for Current Release - Started'

:r .\DMLScripts\ReleaseScripts\CurrentRelease\OrderedSQLSteps.sql

Print 'Call Main SQL Script for Current Release - Completed'


