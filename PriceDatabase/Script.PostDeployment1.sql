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

Print ' Insert Master Data in Price Database'
:r .\DMLScripts\MasterDataScripts\ProductPrices.sql


Print 'Creating Objects that were referring a synonym recursively from another DB Project & Visual Studio SSDT tools are not allowing recursive Project Reference'
:r .\SpecialDDL_For_PostDeploymentScripts\CreateView_With_SynonymReference.sql
