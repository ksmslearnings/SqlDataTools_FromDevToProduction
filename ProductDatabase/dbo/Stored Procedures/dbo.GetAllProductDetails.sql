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
