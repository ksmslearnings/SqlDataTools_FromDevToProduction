# SqlDataTools_FromDevToProduction
This Repository explains using SQL Server Data Tools  for Version Management and CICD (DevOps) Automation for SQL Server databases. 

****************************Details of the Projects and the Solution ******************************
- Details below are not in specific order but should provide you with all necessary information.

- This Solution explains using Sql Server Data Tools from within Visual Studio 2019 for SQL Databases Version Control and Deployment Automation.

- You should see 3 folders with first two contains sample SQL Databases named Product Database and Price Database.

- Both Databases define Synonyms to refer to each other's tables. Synonyms are added here to show how to handle them in SSDT since they cause some issues when they are defined in multiple SQL databses referring to each other. Although this is not a good design practice, this sample will explain how to handle the situation if situation arise.
*In Visual Studio, its not allowed to add recursive Project References. 

- Product Database refers to Price Database and contains all standard DB objects including a Synonym referring to Price Database table.

- Price Database does not refer to ProductDatabase since recursive references are not allowed in Visual Studio. It has all standard DB objects including a Synonym referring a table in Product Database as well. (Synonym doesnt throw any compile time error even without having Product Database Reference.) Synonym is using Project level SQL CMD variables defined under Project Settings.

- In Price Database, SSDT tools gives compile time errors if we try to use Synonym referring to Product Database table in any Stoed Procesures/Functions/Views etc. This is because SSDT has built in SQL Engine and it analyze entire database to check if its able to resolve all object references or not. In this case, its not able to resolve and find Synonym referring Product Database since there is no Product DB reference added to it.

- To Handle this Issue in Proce Database, all Database objects which were causing this issue are created as part of Post Deployment Script in Price Database. In our case for demonstration we just have one View.

- All scripts and files referred under Post Deployment Scripts must have Build Action as None. Otherwise SSDT will analyze those files and throw same build error.

- Very Important - All SQL Script files referred under Pre or Post Deployment Script files must have GO statements to run the SQL statements as Batch. If you get "Invalid Syntax ..." based Errors in these files, chances are that GO statements are missing. Please see usage of GO statements under Post Deployment Scripts in Product Database as reference.

- DACPAC file is generated after build of SQL DB projects and is available under bin/debug or bin/release depending on configuration in Visual Studio. To make life a bit easier, each project contains a folder named DACPAC_Output . This folder will get latest DACPAC file every time projects are build. Please check Post-build event in each project to have details of xcopy command used for this purpose.

- Solution File is present under third folder 'SQLServerDataTools'. You should be able to directly open the Solution and build it in VS 2019.

************Handling Deployment Automation using DACPAC Files*******************

- In any Production based Environment, there will be database changes including DDL and DML scripts that need to be pushed to higher environments.

- Releases are generally handled periodically like every sprint/month/quarter etc depending on Product Requirements.

- Also changes to the databases may need a specific run order for every script for successful deployment. To handle DB deployments, there can be many approaches and here I have explained one of them.

- You should see Release based Folders in both Product and Price Databases. This folders reflect monthly assumed releases.

- Current Release scripts will all go under CurrentRelease Folder. After Release is done , folder will be renamed like ReleaseXX-Month-Year to keep an audit and history.

- Each Release folder will have sql script files that need to be executed and another script file name as "OrderedSQLSteps.sql" that will consolidate and order all these files to run them in an Order.

- We can even Name Script Files with Order Number as Prefix if that makes life easy.

- Post Deploymetn Script will only refer to OrderedSQLSteps.sql. With this abstraction, we never need to modify PostDeployment Script file with every release.

*****************Using SQLPackage.exe for CICD Automation***********************************

- To know more about SQLPackage.exe , visit https://docs.microsoft.com/en-us/sql/tools/sqlpackage?view=sql-server-ver15.

- It is a utility available as part of SSDT tools and can be used for multiple automation tasks including 
>Extracting DACPAC from existing database

>Export entire DB into BACPAC file.

>Publish DACPAC to create a new DB or make changes to existing SQL Databases. In this project , you should see Logs generated for both of these operations.

>Generate a sql script with all the changes that will be made to target based on comparision with source Database or DACPAC file. This is very handy and generally used technique for DBAs to have detailed view of changes that will be made in Production. Due to permission issues, it may not be possible to directly deploy DACPAC to PROD and this approach can be used in that case.

- Under ProductDatabase , you should see two folders with name DACPACDeployment_OnlyChangeScripts and DACPACDeployment_ReCreatedEntireDatabase. These folders contain detailed log files and the script files generated by this utility before deployment to the target environment. This is very useful to have a detailed audit of changes made.
First folder contains logs and script for only the Changes made to an existing database and second folder is logs and script to recreate entirely new database.

- SQLPackage.exe is generally available under folder structure as C:\Program Files (x86)\Microsoft SQL Server\140\DAC\bin.

- Command used to run DACPAC are as below and same are also made available under the folders mentioned above.

--Command to Deploy Entire Database , Create Diagnostic Logs and Script which will ran during Deployment.
--Profile used here is to recreate entire database.
sqlpackage.exe /Action:Publish /Diagnostics:True /DiagnosticsFile:"E:\Blogging\Projects\DACPACDiagnostics.txt" /DeployScriptPath:"E:\Blogging\Projects\DACPACDeployScriptFile.sql" /Profile:"E:\Blogging\Projects\SQLServerDataTools\SqlDataTools_FromDevToProduction\ProductDatabase\ProductDatabase.publish.xml" /SourceFile:"E:\Blogging\Projects\SQLServerDataTools\SqlDataTools_FromDevToProduction\ProductDatabase\DACPAC_Output\ProductDatabase.dacpac" /TargetConnectionString:"Data Source=LAPTOP-SO8773KH;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False"

--Command to Deploy Only Changes Made In Existing Database , Create Diagnostic Logs and Script which will ran during Deployment.
--Profile used here to deploy only the changes in database. No Change in Command but Profile file has been changed for this purpose.
sqlpackage.exe /Action:Publish /Diagnostics:True /DiagnosticsFile:"E:\Blogging\Projects\DACPACDiagnostics.txt" /DeployScriptPath:"E:\Blogging\Projects\DACPACDeployScriptFile.sql" /Profile:"E:\Blogging\Projects\SQLServerDataTools\SqlDataTools_FromDevToProduction\ProductDatabase\ProductDatabase.publish.xml" /SourceFile:"E:\Blogging\Projects\SQLServerDataTools\SqlDataTools_FromDevToProduction\ProductDatabase\DACPAC_Output\ProductDatabase.dacpac" /TargetConnectionString:"Data Source=LAPTOP-SO8773KH;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False"


******************How to use this utility as part of CICD pipeline******************
- There can be many ways to do this. One of the possible approach is detailed below.

- With whatever CICD tooling being used like Azure DevOps or Octopus etc - Build Agent must have SQLPackage.exe installed first. This comes part of standard SQL Server Deployement. If SQL Server is installed in build agent , this should be already available. If not , it can be separately installed as well by looking into Microsoft downlaods.

- Database Projects should be part of Version Control System , just like any other source code.

- Option 1 - As part of release pipelines, CICD tooling can call SQLPackage.exe and pass it all necessary details including DACFile path, Destination SQL Server Details using connection string, Details of Log files to create logs and scripts as mentioned in above Command sample etc.

-Option 2 - If DACPAC is not allowed in Production or in any higher environment, then this EXE can be used to generate Change SQL Script file by comparing the DACPAC with actual SQL Server DB from UAT or Pre-Prod environments (based on access and permissions). Script file can be checked in as part of Source Code and then can be picked by SQlPackage.exe to execute in higher environment as part of CICD pipeline.

- This is not demonstrated as part of this Project but I hope approach explained above is clear and can be manipulated according to individual needs.

