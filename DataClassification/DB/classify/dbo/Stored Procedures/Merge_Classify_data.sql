-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Merge_Classify_data]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [dbo].[classify_data]
   ( 
     [schema_name]
    ,[table_name]
    ,[column_name]
    ,[information_type_name]
    ,[sensitivity_label_name]
	,[database_id]
	,[database_name]
	,[server_name]
	,systemdate
    ,LastUpdated
    ,IsRowCurrent
    ,ValidFrom
    ,ValidTo
   )
SELECT
     [schema_name]
    ,[table_name]
    ,[column_name]
    ,[information_type_name]
    ,[sensitivity_label_name]
	,[database_id]
	,[database_name]
	,[server_name]
	,systemdate
    ,GETDATE()    --LastUpdated
    ,1            --IsRowCurrent
    ,GETDATE()    --ValidFrom
    ,'9999-12-31' --ValidTo
FROM (
  MERGE [classify_data]        AS [Target]
  USING Staging_classify_data AS [Source]
     ON Target.schema_name        = Source.schema_name
	 AND Target.[table_name]        = Source.[table_name]
	 AND Target.[column_name]        = Source.[column_name]
	  AND Target.[database_name]      = Source.[database_name]
	 AND Target.[server_name]     = Source.[server_name]
    AND Target.IsRowCurrent = 1
  WHEN MATCHED AND
      (
           Target.[information_type_name] <> Source.[information_type_name]
        OR Target.[sensitivity_label_name]  <> Source.[sensitivity_label_name]
      )
      THEN UPDATE SET
         IsRowCurrent     = 0
        ,LastUpdated      = GETDATE()
        ,ValidTo          = GETDATE()
  WHEN NOT MATCHED BY TARGET
      THEN INSERT (
		 [schema_name]
		,[table_name]
		,[column_name]
		,[information_type_name]
		,[sensitivity_label_name]
		,[database_id]
		,[database_name]
		,[server_name]
		,systemdate
         ,LastUpdated
         ,IsRowCurrent
         ,ValidFrom
         ,ValidTo
        ) VALUES (
          Source.[schema_name]
         ,Source.[table_name]
         ,Source.[column_name]
         ,Source.[information_type_name]
         ,Source.[sensitivity_label_name]
		 ,Source.[database_id]
		,Source.[database_name]
		,Source.[server_name]
		,source.systemdate
         ,GETDATE()      --LastUpdated
         ,1              --IsRowCurrent
         ,GETDATE()      --ValidFrom
         ,'9999-12-31'   --ValidTo
        )
  WHEN NOT MATCHED BY SOURCE AND Target.IsRowCurrent = 1
      THEN UPDATE SET
          IsRowCurrent = 0
         ,LastUpdated  = GETDATE()
         ,ValidTo      = GETDATE()
  OUTPUT $action AS Action
        ,[Source].*
) AS MergeOutput
WHERE MergeOutput.Action = 'UPDATE'
 

;

END
