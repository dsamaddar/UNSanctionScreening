
-- drop function strip_spaces
CREATE FUNCTION strip_spaces(@str varchar(8000))
RETURNS varchar(8000) AS
BEGIN 
    WHILE CHARINDEX('  ', @str) > 0 
        SET @str = REPLACE(@str, '  ', ' ')

    RETURN @str
END

GO

-- drop proc spGetUNCustomerDetails
alter proc spGetUNCustomerDetails
@CustomerID nvarchar(50)
as
begin
	select CustomerName,ISNULL(Title,'') Title,ISNULL(ISNULL(YEAR(DOB),YEAR(IncorporationDate)),'') DOB,
	ISNULL(PlaceOfBirth,'') PlaceOfBirth,'' AS Designation,ISNULL(Nationality,'Bangladeshi') Nationality,
	TRIM(REPLACE(dbo.strip_spaces(
	TRIM(dbo.fnGetCustomerAddressByType(CustomerID,'Business Address')) + ' ' + 
	TRIM(dbo.fnGetCustomerAddressByType(CustomerID,'Commercial Office')) + ' ' + 
	TRIM(dbo.fnGetCustomerAddressByType(CustomerID,'Factory Address')) + ' ' + 
	TRIM(dbo.fnGetCustomerAddressByType(CustomerID,'Mailing Address')) + ' ' + 
	TRIM(dbo.fnGetCustomerAddressByType(CustomerID,'Present Address')) + ' ' + 
	TRIM(dbo.fnGetCustomerAddressByType(CustomerID,'Permanent Address')) + ' ' + 
	TRIM(dbo.fnGetCustomerAddressByType(CustomerID,'Office Address'))
	),'N\A','')) AS CustAddress
	from CustomerGeneral where CustomerID = @CustomerID;
end

-- exec spGetUNCustomerDetails 'P202010633'

GO

-- drop function fnGetCustomerAddressByType
create function fnGetCustomerAddressByType(@CustomerID nvarchar(50),@AddressType nvarchar(50))
returns nvarchar(500)
begin
	Declare @CustAddress as nvarchar(500) set @CustAddress = 'N\A';
	select @CustAddress = ISNULL(Address,'') + ', '+ isnull(District,'') + '-' + isnull(PostalCode,'') + ', ' + isnull(Country,'')
	from CustomerAddress where CustomerID = @CustomerID and AddressType = @AddressType;

	return ISNULL(@CustAddress,'N\A');
end
