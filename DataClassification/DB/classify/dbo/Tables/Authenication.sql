CREATE TABLE [dbo].[Authenication] (
    [AuthenicationType] INT             NULL,
    [AuthenicationID]   INT             IDENTITY (1, 1) NOT NULL,
    [Username]          VARBINARY (128) NULL,
    [Pwd_Encrypted]     VARBINARY (128) NULL,
    CONSTRAINT [PK_Authenication] PRIMARY KEY CLUSTERED ([AuthenicationID] ASC)
);

