CREATE TABLE [dbo].[ProductList] (
    [ProductId]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [ProductPriceId]    BIGINT         NOT NULL,
    [ProductName]       NVARCHAR (100) NOT NULL,
    [ProductCategoryId] BIGINT         NOT NULL,
    [CreatedDate]       DATETIME       NOT NULL,
    [CreatedBy]         NVARCHAR (100)  NOT NULL,
    [ModifiedDate]      DATETIME       NULL,
    [ModifiedBy]        NVARCHAR (50)  NULL,
    CONSTRAINT [PK_ProductList] PRIMARY KEY CLUSTERED ([ProductId] ASC)
);

