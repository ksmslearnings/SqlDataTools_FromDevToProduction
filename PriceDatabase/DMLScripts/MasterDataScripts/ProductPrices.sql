GO

declare @rowcount int = (select count(1) from [dbo].[ProductPrice])
if @rowcount <> 9
begin

Truncate table [dbo].[ProductPrice]

INSERT INTO [dbo].[ProductPrice]
           ([ProductId]
           ,[Price]
           ,[CreatedDate]
           ,[CreatedBy]
           ,[ModifiedDate]
           ,[ModifiedBy])
     VALUES
           (1,230,getdate(),'Kunal Sehgal',null,null),
		   (2,100,getdate(),'Kunal Sehgal',null,null),
		   (3,990,getdate(),'Kunal Sehgal',null,null),
		   (4,1390,getdate(),'Kunal Sehgal',null,null),
		   (5,2990,getdate(),'Kunal Sehgal',null,null),
		   (6,4500,getdate(),'Kunal Sehgal',null,null),
		   (7,25,getdate(),'Kunal Sehgal',null,null),
		   (8,35,getdate(),'Kunal Sehgal',null,null),
		   (9,45,getdate(),'Kunal Sehgal',null,null)
end



