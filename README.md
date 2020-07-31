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



