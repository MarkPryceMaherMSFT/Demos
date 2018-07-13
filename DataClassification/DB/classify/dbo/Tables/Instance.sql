CREATE TABLE [dbo].[Instance] (
    [InstanceID]      INT           IDENTITY (1, 1) NOT NULL,
    [InstanceName]    VARCHAR (255) NOT NULL,
    [AuthenicationID] INT           NOT NULL,
    [ServerId]        INT           NOT NULL,
    CONSTRAINT [PK_Instance] PRIMARY KEY CLUSTERED ([InstanceID] ASC)
);

