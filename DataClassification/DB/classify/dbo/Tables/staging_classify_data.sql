CREATE TABLE [dbo].[staging_classify_data] (
    [schema_name]            NVARCHAR (128) NULL,
    [table_name]             NVARCHAR (128) NULL,
    [column_name]            NVARCHAR (128) NULL,
    [information_type_name]  NVARCHAR (128) NULL,
    [sensitivity_label_name] NVARCHAR (128) NULL,
    [database_id]            INT            NULL,
    [database_name]          NVARCHAR (128) NULL,
    [server_name]            NVARCHAR (128) NULL,
    [systemdate]             DATETIME       NOT NULL
);

