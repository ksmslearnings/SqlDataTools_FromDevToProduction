CREATE PROCEDURE [dbo].[TestProcedure]
	@param1 int = 0,
	@param2 int
AS
	SELECT          

                ProductDB_ProductListTbl.ProductId as ProductId, 
                ProductDB_ProductListTbl.ProductName as ProductName,
                p.Price
FROM             [$(PriceDatabase)].dbo.ProductPrice AS p INNER JOIN
                        Synonym_ProductDatabase_ProductListTable ProductDB_ProductListTbl 
                        ON p.ProductPriceId = ProductDB_ProductListTbl.ProductPriceId


RETURN 0
