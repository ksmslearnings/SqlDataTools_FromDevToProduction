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