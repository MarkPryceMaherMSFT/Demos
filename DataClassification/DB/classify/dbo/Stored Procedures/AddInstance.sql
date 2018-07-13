-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddInstance]
	-- Add the parameters for the stored procedure here
	@InstanceName varchar(255),
	@Auth int,
	@Username varchar(50),
	@Password varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if exists(select * from [dbo].[Instance] where [InstanceName] = @InstanceName)
	begin
		raiserror (15600,-1,-1, 'Instance already exists'); 
	end
	else
	begin


	declare @authkey int

	INSERT INTO [dbo].[Authenication]
				([AuthenicationType]
				,[Username]
				,[Pwd_Encrypted])
     VALUES
           (@Auth
           ,NULL
		   ,NULL);

	set @authkey = @@IDENTITY


	INSERT INTO [dbo].[Instance]
			   ([InstanceName]
			   ,[AuthenicationID])
		 VALUES
			   (@InstanceName
			   ,@authkey );



	end

END
