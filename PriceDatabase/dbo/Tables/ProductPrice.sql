CREATE TABLE [dbo].[ProductPrice] (
    [ProductPriceId] BIGINT        IDENTITY (1, 1) NOT NULL,
    [ProductId]      BIGINT        NOT NULL,
    [Price]          DECIMAL (18)  NOT NULL,
    [CreatedDate]    DATETIME      NOT NULL,
    [CreatedBy]      NVARCHAR (50) NOT NULL,
    [ModifiedDate]   DATETIME      NULL,
    [ModifiedBy]     NVARCHAR (50) NULL,
    CONSTRAINT [PK_ProductPrice] PRIMARY KEY CLUSTERED ([ProductPriceId] ASC)
);

