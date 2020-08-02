CREATE VIEW [dbo].[TestView]
	AS 
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
