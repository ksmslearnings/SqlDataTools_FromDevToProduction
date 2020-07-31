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


