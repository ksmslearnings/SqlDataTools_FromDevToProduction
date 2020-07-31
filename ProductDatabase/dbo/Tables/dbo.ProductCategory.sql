CREATE TABLE [dbo].[ProductCategory] (
    [ProductCategoryId]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [ProductCategoryName] NVARCHAR (50) NOT NULL,
    [CreatedDate]         DATETIME      NOT NULL,
    [CreatedBy]           NVARCHAR (50) NOT NULL,
    [ModifiedDate]        DATETIME      NULL,
    [ModifiedBy]          BIGINT        NULL,
    CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED ([ProductCategoryId] ASC)
);

