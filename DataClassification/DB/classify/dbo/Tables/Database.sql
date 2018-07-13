CREATE TABLE [dbo].[Database] (
    [DatabaseID]   INT           IDENTITY (1, 1) NOT NULL,
    [DatabaseName] VARCHAR (255) NULL,
    [InstanceID]   INT           NULL,
    [Include]      INT           CONSTRAINT [DF_Database_Include] DEFAULT ((0)) NULL
);

