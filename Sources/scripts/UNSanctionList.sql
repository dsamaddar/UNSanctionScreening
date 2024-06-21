
CREATE FUNCTION strip_spaces(@str varchar(8000))
RETURNS varchar(8000) AS
BEGIN 
    WHILE CHARINDEX('  ', @str) > 0 
        SET @str = REPLACE(@str, '  ', ' ')

    RETURN @str
END

GO

create FUNCTION similar_text(@string1 NVARCHAR(100),@string2 NVARCHAR(100))  
RETURNS INT
AS  
BEGIN

	if len(@string1) = 0 or len(@string2) = 0
		return 0;
  
    DECLARE @levenShteinNumber INT  
  
    DECLARE @string1Length INT = LEN(@string1)  
    , @string2Length INT = LEN(@string2)  
    DECLARE @maxLengthNumber INT = CASE WHEN @string1Length > @string2Length THEN @string1Length ELSE @string2Length END  
  
    SELECT @levenShteinNumber = dbo.LEVENSHTEIN(@string1,@string2)  
  
    DECLARE @percentageOfBadCharacters INT = @levenShteinNumber * 100 / @maxLengthNumber  
  
    DECLARE @percentageOfGoodCharacters INT = 100 - @percentageOfBadCharacters  
  
    RETURN @percentageOfGoodCharacters  
  
END  

GO
  
CREATE FUNCTION [dbo].[LEVENSHTEIN](@left  VARCHAR(100),  
                                    @right VARCHAR(100))  
returns INT  
AS  
  BEGIN  
      DECLARE @difference    INT,  
              @lenRight      INT,  
              @lenLeft       INT,  
              @leftIndex     INT,  
              @rightIndex    INT,  
              @left_char     CHAR(1),  
              @right_char    CHAR(1),  
              @compareLength INT  
  
      SET @lenLeft = LEN(@left)  
      SET @lenRight = LEN(@right)  
      SET @difference = 0  
  
      IF @lenLeft = 0  
        BEGIN  
            SET @difference = @lenRight  
  
            GOTO done  
        END  
  
      IF @lenRight = 0  
        BEGIN  
            SET @difference = @lenLeft  
  
            GOTO done  
        END  
  
      GOTO comparison  
  
      COMPARISON:  
  
      IF ( @lenLeft >= @lenRight )  
        SET @compareLength = @lenLeft  
      ELSE  
        SET @compareLength = @lenRight  
  
      SET @rightIndex = 1  
      SET @leftIndex = 1  
  
      WHILE @leftIndex <= @compareLength  
        BEGIN  
            SET @left_char = substring(@left, @leftIndex, 1)  
            SET @right_char = substring(@right, @rightIndex, 1)  
  
            IF @left_char <> @right_char  
              BEGIN -- Would an insertion make them re-align?  
                  IF( @left_char = substring(@right, @rightIndex + 1, 1) )  
                    SET @rightIndex = @rightIndex + 1  
                  -- Would an deletion make them re-align?  
                  ELSE IF( substring(@left, @leftIndex + 1, 1) = @right_char )  
                    SET @leftIndex = @leftIndex + 1  
  
                  SET @difference = @difference + 1  
              END  
  
            SET @leftIndex = @leftIndex + 1  
            SET @rightIndex = @rightIndex + 1  
        END  
  
      GOTO done  
  
      DONE:  
  
      RETURN @difference  
  END   

GO

-- drop table tblUNSanctionList
create table tblUNSanctionList(
DATAID NVARCHAR(20) primary key,
DATATYPE NVARCHAR(20),
VERSIONNUM NVARCHAR(20),
FIRST_NAME NVARCHAR(500),
SECOND_NAME NVARCHAR(500),
THIRD_NAME NVARCHAR(500),
FOURTH_NAME NVARCHAR(500),
UN_LIST_TYPE NVARCHAR(20),
REFERENCE_NUMBER NVARCHAR(20),
LISTED_ON NVARCHAR(20),
NAME_ORIGINAL_SCRIPT NVARCHAR(500),
COMMENTS1 NVARCHAR(1000),
TITLE NVARCHAR(500),
DESIGNATION NVARCHAR(500),
NATIONALITY NVARCHAR(500),
LIST_TYPE NVARCHAR(500),
LAST_DAY_UPDATED NVARCHAR(500),
INDIVIDUAL_ALIAS_QUALITY NVARCHAR(500),
INDIVIDUAL_ALIAS_NAME NVARCHAR(500),
INDIVIDUAL_ADDRESS_COUNTRY NVARCHAR(500),
INDIVIDUAL_ADDRESS_NOTE NVARCHAR(500),
ENTITY_ALIAS_QUALITY NVARCHAR(500),
ENTITY_ALIAS_NAME NVARCHAR(500),
ENTITY_ADDRESS_STREET NVARCHAR(500),
ENTITY_ADDRESS_CITY NVARCHAR(500),
ENTITY_ADDRESS_COUNTRY NVARCHAR(500),
BIRTH_TYPE_OF_DATE NVARCHAR(500),
BIRTH_YEAR NVARCHAR(500),
BIRTH_CITY NVARCHAR(500),
BIRTH_STATE_PROVINCE NVARCHAR(500),
BIRTH_COUNTRY NVARCHAR(500),
TYPE_OF_DOCUMENT NVARCHAR(500),
TYPE_OF_DOCUMENT2 NVARCHAR(500),
TYPE_OF_DOCUMENT_NUMBER NVARCHAR(500),
DOCUMENT_ISSUING_COUNTRY NVARCHAR(500),
DOCUMENT_CITY_OF_ISSUE NVARCHAR(500),
DOCUMENT_COUNTRY_OF_ISSUE NVARCHAR(500),
DOCUMENT_NOTE NVARCHAR(500),
SORT_KEY NVARCHAR(100),
SORT_KEY_LAST_MOD NVARCHAR(100)
);

GO

insert into tblUNSanctionList(DATAID,DATATYPE,VERSIONNUM,FIRST_NAME,SECOND_NAME,THIRD_NAME,FOURTH_NAME,UN_LIST_TYPE,
REFERENCE_NUMBER,LISTED_ON,NAME_ORIGINAL_SCRIPT,COMMENTS1,TITLE,DESIGNATION,NATIONALITY,LIST_TYPE,LAST_DAY_UPDATED,
INDIVIDUAL_ALIAS_QUALITY,INDIVIDUAL_ALIAS_NAME,INDIVIDUAL_ADDRESS_COUNTRY,INDIVIDUAL_ADDRESS_NOTE,BIRTH_TYPE_OF_DATE,
BIRTH_YEAR,BIRTH_CITY,BIRTH_STATE_PROVINCE,BIRTH_COUNTRY,TYPE_OF_DOCUMENT,TYPE_OF_DOCUMENT2,TYPE_OF_DOCUMENT_NUMBER,
DOCUMENT_ISSUING_COUNTRY,DOCUMENT_CITY_OF_ISSUE,	DOCUMENT_COUNTRY_OF_ISSUE,DOCUMENT_NOTE,SORT_KEY,SORT_KEY_LAST_MOD
)
SELECT
	MY_XML.individual.query('DATAID').value('.', 'NVARCHAR(20)') DATAID,'INDIVIDUAL',
	MY_XML.individual.query('VERSIONNUM').value('.', 'NVARCHAR(20)') VERSIONNUM,
	MY_XML.individual.query('FIRST_NAME').value('.', 'NVARCHAR(500)') FIRST_NAME,
	MY_XML.individual.query('SECOND_NAME').value('.', 'NVARCHAR(500)') SECOND_NAME,
	MY_XML.individual.query('THIRD_NAME').value('.', 'NVARCHAR(500)') THIRD_NAME,
	MY_XML.individual.query('FOURTH_NAME').value('.', 'NVARCHAR(500)') FOURTH_NAME,
	MY_XML.individual.query('UN_LIST_TYPE').value('.', 'NVARCHAR(20)') UN_LIST_TYPE,
	MY_XML.individual.query('REFERENCE_NUMBER').value('.', 'NVARCHAR(20)') REFERENCE_NUMBER,
	MY_XML.individual.query('LISTED_ON').value('.', 'NVARCHAR(20)') LISTED_ON,
	MY_XML.individual.query('NAME_ORIGINAL_SCRIPT').value('.', 'NVARCHAR(500)') NAME_ORIGINAL_SCRIPT,
	MY_XML.individual.query('COMMENTS1').value('.', 'NVARCHAR(1000)') COMMENTS1,
	REPLACE(MY_XML.individual.query('data(TITLE/VALUE/text())').value('text()[1]', 'NVARCHAR(500)'), SPACE(1), '; ') TITLE,
	MY_XML.individual.query('data(DESIGNATION/VALUE/text())').value('text()[1]', 'NVARCHAR(500)') DESIGNATION,
	MY_XML.individual.query('data(NATIONALITY/VALUE/text())').value('text()[1]', 'NVARCHAR(500)') NATIONALITY,
	MY_XML.individual.query('LIST_TYPE').value('.', 'NVARCHAR(500)') LIST_TYPE,
	REPLACE(MY_XML.individual.query('data(LAST_DAY_UPDATED/VALUE/text())').value('text()[1]', 'NVARCHAR(500)'), SPACE(1), '; ') LAST_DAY_UPDATED,
	MY_XML.individual.query('data(INDIVIDUAL_ALIAS/QUALITY/text())').value('text()[1]', 'NVARCHAR(500)') INDIVIDUAL_ALIAS_QUALITY,
	MY_XML.individual.query('data(INDIVIDUAL_ALIAS/ALIAS_NAME/text())').value('text()[1]', 'NVARCHAR(500)') INDIVIDUAL_ALIAS_NAME,
	MY_XML.individual.query('INDIVIDUAL_ADDRESS/COUNTRY').value('.', 'NVARCHAR(500)') INDIVIDUAL_ADDRESS_COUNTRY,
	MY_XML.individual.query('INDIVIDUAL_ADDRESS/NOTE').value('.', 'NVARCHAR(500)') INDIVIDUAL_ADDRESS_NOTE,
	MY_XML.individual.query('data(INDIVIDUAL_DATE_OF_BIRTH/TYPE_OF_DATE/text())').value('text()[1]', 'NVARCHAR(500)') BIRTH_TYPE_OF_DATE,
	MY_XML.individual.query('data(INDIVIDUAL_DATE_OF_BIRTH/YEAR/text())').value('text()[1]', 'NVARCHAR(500)') BIRTH_YEAR,
	MY_XML.individual.query('INDIVIDUAL_PLACE_OF_BIRTH/CITY').value('.', 'NVARCHAR(500)') BIRTH_CITY,
	MY_XML.individual.query('INDIVIDUAL_PLACE_OF_BIRTH/STATE_PROVINCE').value('.', 'NVARCHAR(500)') BIRTH_STATE_PROVINCE,
	MY_XML.individual.query('INDIVIDUAL_PLACE_OF_BIRTH/COUNTRY').value('.', 'NVARCHAR(500)') BIRTH_COUNTRY,
	MY_XML.individual.query('data(INDIVIDUAL_DOCUMENT/TYPE_OF_DOCUMENT/text())').value('text()[1]', 'NVARCHAR(500)') TYPE_OF_DOCUMENT,
	MY_XML.individual.query('data(INDIVIDUAL_DOCUMENT/TYPE_OF_DOCUMENT2/text())').value('text()[1]', 'NVARCHAR(500)') TYPE_OF_DOCUMENT2,
	MY_XML.individual.query('data(INDIVIDUAL_DOCUMENT/NUMBER/text())').value('text()[1]', 'NVARCHAR(500)') TYPE_OF_DOCUMENT_NUMBER,
	MY_XML.individual.query('data(INDIVIDUAL_DOCUMENT/ISSUING_COUNTRY/text())').value('text()[1]', 'NVARCHAR(500)') DOCUMENT_ISSUING_COUNTRY,
	MY_XML.individual.query('data(INDIVIDUAL_DOCUMENT/CITY_OF_ISSUE/text())').value('text()[1]', 'NVARCHAR(500)') DOCUMENT_CITY_OF_ISSUE,
	MY_XML.individual.query('data(INDIVIDUAL_DOCUMENT/COUNTRY_OF_ISSUE/text())').value('text()[1]', 'NVARCHAR(500)') DOCUMENT_COUNTRY_OF_ISSUE,
	MY_XML.individual.query('data(INDIVIDUAL_DOCUMENT/NOTE/text())').value('text()[1]', 'NVARCHAR(500)') DOCUMENT_NOTE,
	MY_XML.individual.query('SORT_KEY').value('.', 'NVARCHAR(100)') SORT_KEY,
	MY_XML.individual.query('SORT_KEY_LAST_MOD').value('.', 'NVARCHAR(100)') SORT_KEY_LAST_MOD
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'D:\UNSanctionList\consolidated.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('CONSOLIDATED_LIST/INDIVIDUALS/INDIVIDUAL') AS MY_XML (individual);

GO

insert into tblUNSanctionList(DATAID,DATATYPE,VERSIONNUM,FIRST_NAME,UN_LIST_TYPE,REFERENCE_NUMBER,LISTED_ON,
NAME_ORIGINAL_SCRIPT,COMMENTS1,LIST_TYPE,LAST_DAY_UPDATED,ENTITY_ALIAS_QUALITY,ENTITY_ALIAS_NAME,
ENTITY_ADDRESS_STREET,ENTITY_ADDRESS_CITY,ENTITY_ADDRESS_COUNTRY,SORT_KEY,SORT_KEY_LAST_MOD
)
Select
	MY_XML.entity.query('DATAID').value('.', 'NVARCHAR(20)') DATAID,'ENTITY',
	MY_XML.entity.query('VERSIONNUM').value('.', 'NVARCHAR(20)') VERSIONNUM,
	MY_XML.entity.query('FIRST_NAME').value('.', 'NVARCHAR(500)') FIRST_NAME,
	MY_XML.entity.query('UN_LIST_TYPE').value('.', 'NVARCHAR(20)') UN_LIST_TYPE,
	MY_XML.entity.query('REFERENCE_NUMBER').value('.', 'NVARCHAR(20)') REFERENCE_NUMBER,
	MY_XML.entity.query('LISTED_ON').value('.', 'NVARCHAR(20)') LISTED_ON,
	MY_XML.entity.query('NAME_ORIGINAL_SCRIPT').value('.', 'NVARCHAR(500)') NAME_ORIGINAL_SCRIPT,
	MY_XML.entity.query('COMMENTS1').value('.', 'NVARCHAR(1000)') COMMENTS1,
	MY_XML.entity.query('LIST_TYPE').value('.', 'NVARCHAR(500)') LIST_TYPE,
	REPLACE(MY_XML.entity.query('data(LAST_DAY_UPDATED/VALUE/text())').value('text()[1]', 'NVARCHAR(500)'), SPACE(1), '; ') LAST_DAY_UPDATED,
	MY_XML.entity.query('data(ENTITY_ALIAS/QUALITY/text())').value('text()[1]', 'NVARCHAR(500)') ENTITY_ALIAS_QUALITY,
	MY_XML.entity.query('data(ENTITY_ALIAS/ALIAS_NAME/text())').value('text()[1]', 'NVARCHAR(500)') ENTITY_ALIAS_NAME,
	MY_XML.entity.query('data(ENTITY_ADDRESS/STREET/text())').value('text()[1]', 'NVARCHAR(500)') ENTITY_ADDRESS_STREET,
	MY_XML.entity.query('data(ENTITY_ADDRESS/CITY/text())').value('text()[1]', 'NVARCHAR(500)') ENTITY_ADDRESS_CITY,
	MY_XML.entity.query('data(ENTITY_ADDRESS/COUNTRY/text())').value('text()[1]', 'NVARCHAR(500)') ENTITY_ADDRESS_COUNTRY,
	MY_XML.entity.query('SORT_KEY').value('.', 'NVARCHAR(100)') SORT_KEY,
	MY_XML.entity.query('SORT_KEY_LAST_MOD').value('.', 'NVARCHAR(100)') SORT_KEY_LAST_MOD
FROM (SELECT CAST(MY_XML AS xml)
      FROM OPENROWSET(BULK 'D:\UNSanctionList\consolidated.xml', SINGLE_BLOB) AS T(MY_XML)) AS T(MY_XML)
      CROSS APPLY MY_XML.nodes('CONSOLIDATED_LIST/ENTITIES/ENTITY') AS MY_XML(entity);

GO

Update tblUNSanctionList set DATAID=ISNULL(DATAID,''),VERSIONNUM = ISNULL(VERSIONNUM,''),
FIRST_NAME = ISNULL(FIRST_NAME,''),SECOND_NAME = ISNULL(SECOND_NAME,''),THIRD_NAME = ISNULL(THIRD_NAME,''),
FOURTH_NAME = ISNULL(FOURTH_NAME,''),UN_LIST_TYPE = ISNULL(UN_LIST_TYPE,''),REFERENCE_NUMBER = ISNULL(REFERENCE_NUMBER,''),
LISTED_ON = ISNULL(LISTED_ON,''),NAME_ORIGINAL_SCRIPT = ISNULL(NAME_ORIGINAL_SCRIPT,''),COMMENTS1 = ISNULL(COMMENTS1,''),
TITLE = ISNULL(TITLE,''),DESIGNATION = ISNULL(DESIGNATION,''),NATIONALITY = ISNULL(NATIONALITY,''),LIST_TYPE = ISNULL(LIST_TYPE,''),
LAST_DAY_UPDATED = ISNULL(LAST_DAY_UPDATED,''),INDIVIDUAL_ALIAS_QUALITY = ISNULL(INDIVIDUAL_ALIAS_QUALITY,''),INDIVIDUAL_ALIAS_NAME = ISNULL(INDIVIDUAL_ALIAS_NAME,''),
INDIVIDUAL_ADDRESS_COUNTRY = ISNULL(INDIVIDUAL_ADDRESS_COUNTRY,''),
ENTITY_ALIAS_QUALITY = ISNULL(ENTITY_ALIAS_QUALITY,''),ENTITY_ALIAS_NAME=ISNULL(ENTITY_ALIAS_NAME,''),
ENTITY_ADDRESS_STREET = ISNULL(ENTITY_ADDRESS_STREET,''),ENTITY_ADDRESS_CITY=ISNULL(ENTITY_ADDRESS_CITY,''),
ENTITY_ADDRESS_COUNTRY=ISNULL(ENTITY_ADDRESS_COUNTRY,''),BIRTH_TYPE_OF_DATE = ISNULL(BIRTH_TYPE_OF_DATE,''),
BIRTH_YEAR = ISNULL(BIRTH_YEAR,''),BIRTH_CITY = ISNULL(BIRTH_CITY,''),BIRTH_STATE_PROVINCE = ISNULL(BIRTH_STATE_PROVINCE,''),
BIRTH_COUNTRY = ISNULL(BIRTH_COUNTRY,''),TYPE_OF_DOCUMENT = ISNULL(TYPE_OF_DOCUMENT,''),TYPE_OF_DOCUMENT2 = ISNULL(TYPE_OF_DOCUMENT2,''),
TYPE_OF_DOCUMENT_NUMBER = ISNULL(TYPE_OF_DOCUMENT_NUMBER,''),DOCUMENT_ISSUING_COUNTRY = ISNULL(DOCUMENT_ISSUING_COUNTRY,''),
DOCUMENT_CITY_OF_ISSUE = ISNULL(DOCUMENT_CITY_OF_ISSUE,''),DOCUMENT_COUNTRY_OF_ISSUE = ISNULL(DOCUMENT_COUNTRY_OF_ISSUE,''),
DOCUMENT_NOTE = ISNULL(DOCUMENT_NOTE,''),SORT_KEY = ISNULL(SORT_KEY,''),SORT_KEY_LAST_MOD = ISNULL(SORT_KEY_LAST_MOD,'');

GO

update tblUNSanctionList set FIRST_NAME = TRIM(dbo.strip_spaces(FIRST_NAME)),
							 SECOND_NAME = TRIM(dbo.strip_spaces(SECOND_NAME)),
							 THIRD_NAME = TRIM(dbo.strip_spaces(THIRD_NAME)),
							 FOURTH_NAME = TRIM(dbo.strip_spaces(FOURTH_NAME)),
							 NAME_ORIGINAL_SCRIPT = TRIM(dbo.strip_spaces(NAME_ORIGINAL_SCRIPT)),
							 INDIVIDUAL_ALIAS_NAME = TRIM(dbo.strip_spaces(INDIVIDUAL_ALIAS_NAME)),
							 ENTITY_ALIAS_NAME = TRIM(dbo.strip_spaces(ENTITY_ALIAS_NAME)),
							 TITLE = TRIM(dbo.strip_spaces(TITLE)),
							 DESIGNATION = TRIM(dbo.strip_spaces(DESIGNATION)),
							 NATIONALITY = TRIM(dbo.strip_spaces(NATIONALITY));

GO

create view vwUNSanctionList
as
select DATAID,DATATYPE,VERSIONNUM,
ISNULL(FIRST_NAME,'')+ ' '+ ISNULL(SECOND_NAME,'') + ' ' + ISNULL(THIRD_NAME,'') + ' ' + ISNULL(FOURTH_NAME,'') AS FULL_NAME,
UN_LIST_TYPE,REFERENCE_NUMBER,LISTED_ON,NAME_ORIGINAL_SCRIPT,COMMENTS1,TITLE,DESIGNATION,NATIONALITY,LIST_TYPE,
LAST_DAY_UPDATED,INDIVIDUAL_ALIAS_QUALITY,INDIVIDUAL_ALIAS_NAME,
INDIVIDUAL_ADDRESS_COUNTRY,INDIVIDUAL_ADDRESS_NOTE,
ENTITY_ALIAS_QUALITY,ENTITY_ALIAS_NAME,
ISNULL(ENTITY_ALIAS_NAME,'') + ' ' + ISNULL(ENTITY_ADDRESS_CITY,'') + ' ' + ISNULL(ENTITY_ADDRESS_COUNTRY,'') AS ENTITY_ADDRESS,
BIRTH_TYPE_OF_DATE,BIRTH_YEAR,
ISNULL(BIRTH_CITY,'') + ' ' + ISNULL(BIRTH_STATE_PROVINCE,'') + ' ' + ISNULL(BIRTH_COUNTRY,'') AS BIRTH_PLACE,
ISNULL(TYPE_OF_DOCUMENT,'')+ ' ' + ISNULL(TYPE_OF_DOCUMENT2,'')+ ' ' + ISNULL(TYPE_OF_DOCUMENT_NUMBER,'') + ' ' + ISNULL(DOCUMENT_ISSUING_COUNTRY,'') + ' ' + ISNULL(DOCUMENT_CITY_OF_ISSUE,'') + ' ' + ISNULL(DOCUMENT_COUNTRY_OF_ISSUE,'') + ' ' + ISNULL(DOCUMENT_NOTE,'') AS DOCUMENT_INFO,
SORT_KEY,SORT_KEY_LAST_MOD
from tblUNSanctionList;

GO

create proc spGenScantionLogID
as
begin
	SELECT FORMAT (getdate(), 'yyyyMMddhhmmss') as LogID
end

GO

-- drop table tblUNScreeningLog
create table tblUNScreeningLog(
LogID nvarchar(50) primary key,
CustomerID nvarchar(50),
p_name nvarchar(100),
p_title nvarchar(50),
p_designation nvarchar(100),
p_nationality nvarchar(50),
p_address nvarchar(200),
p_birth_year nvarchar(50),
p_birth_place nvarchar(50),
p_comments nvarchar(200),
p_document_info nvarchar(200),
DATAID nvarchar(50),
name_score numeric(5,2),
title_score numeric(5,2),
designation_score numeric(5,2),
nationality_score numeric(5,2),
address_score numeric(5,2),
birth_year_score numeric(5,2),
birth_place_score numeric(5,2),
comments_score numeric(5,2),
document_info_score numeric(5,2),
average_score numeric(5,2),
processed_by nvarchar(50),
processed_on datetime default getdate()
);

GO

create proc spGetUNScreeningLogList
@CustomerID nvarchar(50),
@EmployeeID nvarchar(50)
as
begin
	select LogID,CustomerID,p_name,DATAID,average_score,u.EmployeeName as processed_by,processed_on 
	from tblUNScreeningLog l inner join tblVisitUsers u on l.processed_by = u.EmployeeID
	where CustomerID like '%'+@CustomerID+'%' and processed_by like '%' + @EmployeeID + '%'
	order by processed_on desc
end

-- exec spGetUNScreeningLogList 'P202213260','EMP-00000001'

GO

-- exec spGetUNCustomerDetails 'P202213712'
create proc spGetUNCustomerDetails
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

-- exec spProcessUNScreening '','','TAHER','m','d','trkiye','german','2','','','','dsamaddar'
create proc spProcessUNScreening
@LogID nvarchar(50),
@CustomerID nvarchar(50),
@p_name nvarchar(100),
@p_title nvarchar(50),
@p_designation nvarchar(100),
@p_nationality nvarchar(50),
@p_address nvarchar(200),
@p_birth_year nvarchar(50),
@p_birth_place nvarchar(50),
@p_comments nvarchar(200),
@p_document_info nvarchar(200),
@p_processed_by nvarchar(50)
as
begin
SET NOCOUNT ON
	declare @tbl_sanction as table(
	DATAID nvarchar(50),
	name_score numeric(5,2),
	title_score numeric(5,2),
	designation_score numeric(5,2),
	nationality_score numeric(5,2),
	address_score numeric(5,2),
	birth_year_score numeric(5,2),
	birth_place_score numeric(5,2),
	comments_score numeric(5,2),
	document_info_score numeric(5,2),
	average_score AS (name_score+title_score+designation_score+nationality_score+address_score+birth_year_score+birth_place_score+comments_score+document_info_score)/9.0
	);

	DECLARE @DATAID nvarchar(50) set @DATAID = '';
	DECLARE @FULL_NAME nvarchar(200) set @FULL_NAME = '';
	DECLARE @NAME_ORIGINAL_SCRIPT nvarchar(200) set @NAME_ORIGINAL_SCRIPT = '';
	DECLARE @INDIVIDUAL_ALIAS_NAME nvarchar(200) set @INDIVIDUAL_ALIAS_NAME = '';
	DECLARE @ENTITY_ALIAS_NAME nvarchar(200) set @ENTITY_ALIAS_NAME = '';
	DECLARE @UN_LIST_TYPE nvarchar(100) set @UN_LIST_TYPE = '';
	DECLARE @TITLE as nvarchar(100) set @TITLE = '';
	DECLARE @DESIGNATION as nvarchar(100) set @DESIGNATION = '';
	DECLARE @NATIONALITY as nvarchar(100) set @NATIONALITY = '';
	DECLARE @INDIVIDUAL_ADDRESS_COUNTRY as nvarchar(100) set @INDIVIDUAL_ADDRESS_COUNTRY = '';
	DECLARE @ENTITY_ADDRESS as nvarchar(100) set @ENTITY_ADDRESS = '';
	DECLARE @COMMENTS1 as nvarchar(100) set @COMMENTS1 = '';
	DECLARE @BIRTH_YEAR as nvarchar(100) set @BIRTH_YEAR = '';
	DECLARE @BIRTH_PLACE as nvarchar(100) set @BIRTH_PLACE = '';
	DECLARE @DOCUMENT_INFO as nvarchar(100) set @DOCUMENT_INFO = '';

	
	Declare @name_score as numeric(5,2) set @name_score = 0.0;
	Declare @title_score as numeric(5,2) set @title_score = 0.0;
	Declare @designation_score as numeric(5,2) set @designation_score = 0.0;
	Declare @nationality_score as numeric(5,2) set @nationality_score = 0.0;
	Declare @address_score as numeric(5,2) set @address_score = 0.0;
	Declare @comments_score as numeric(5,2) set @comments_score = 0.0;
	Declare @birth_year_score as numeric(5,2) set @birth_year_score = 0.0;
	Declare @birth_place_score as numeric(5,2) set @birth_place_score = 0.0;
	Declare @document_info_score as numeric(5,2) set @document_info_score = 0.0;

	DECLARE list_cursor CURSOR FOR 
	SELECT DATAID,FULL_NAME,NAME_ORIGINAL_SCRIPT,INDIVIDUAL_ALIAS_NAME,ENTITY_ALIAS_NAME,
	TITLE,DESIGNATION,NATIONALITY,INDIVIDUAL_ADDRESS_COUNTRY,ENTITY_ADDRESS,COMMENTS1,BIRTH_YEAR,BIRTH_PLACE,DOCUMENT_INFO
	FROM vwUNSanctionList;

	OPEN list_cursor

	FETCH NEXT FROM list_cursor INTO @DATAID,@FULL_NAME,@NAME_ORIGINAL_SCRIPT,@INDIVIDUAL_ALIAS_NAME,@ENTITY_ALIAS_NAME,
	@TITLE,@DESIGNATION,@NATIONALITY,@INDIVIDUAL_ADDRESS_COUNTRY,@ENTITY_ADDRESS,@COMMENTS1,@BIRTH_YEAR,@BIRTH_PLACE,@DOCUMENT_INFO

	-- Set the status for the cursor
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		
		set @name_score = (dbo.similar_text(@p_name,@FULL_NAME) + dbo.similar_text(@p_name,@NAME_ORIGINAL_SCRIPT) +dbo.similar_text(@p_name,@INDIVIDUAL_ALIAS_NAME) + dbo.similar_text(@p_name,@ENTITY_ALIAS_NAME))/4.0;
		set @title_score = dbo.similar_text(@p_title,@TITLE);
		set @designation_score = dbo.similar_text(@p_designation,@DESIGNATION);
		set @nationality_score = dbo.similar_text(@p_nationality,@NATIONALITY);
		set @address_score = (dbo.similar_text(@p_address,@INDIVIDUAL_ADDRESS_COUNTRY) + dbo.similar_text(@p_address,@ENTITY_ADDRESS) )/2.0
		set @comments_score = dbo.similar_text(@p_comments,@COMMENTS1);
		set @birth_year_score = dbo.similar_text(@p_birth_year,@BIRTH_YEAR);
		set @birth_place_score = dbo.similar_text(@p_birth_place,@BIRTH_PLACE);
		set @document_info_score = dbo.similar_text(@p_document_info,@DOCUMENT_INFO);

		insert into @tbl_sanction(DATAID,name_score,title_score,designation_score,nationality_score,
		address_score,comments_score,birth_year_score,birth_place_score,document_info_score)
		values(@DATAID,@name_score,@title_score,@designation_score,@nationality_score,
		@address_score,@comments_score,@birth_year_score,@birth_place_score,@document_info_score);

		set @name_score = 0;
 		FETCH NEXT FROM list_cursor INTO @DATAID,@FULL_NAME,@NAME_ORIGINAL_SCRIPT,@INDIVIDUAL_ALIAS_NAME,@ENTITY_ALIAS_NAME,
		@TITLE,@DESIGNATION,@NATIONALITY,@INDIVIDUAL_ADDRESS_COUNTRY,@ENTITY_ADDRESS,@COMMENTS1,@BIRTH_YEAR,@BIRTH_PLACE,@DOCUMENT_INFO
	END 

	CLOSE list_cursor
	DEALLOCATE list_cursor

	insert into tblUNScreeningLog(LogID,CustomerID,p_name,p_title,p_designation,p_nationality,p_address,
	p_birth_year,p_birth_place,p_comments,p_document_info,DATAID,name_score,title_score,designation_score,
	nationality_score,address_score,birth_year_score,birth_place_score,comments_score,document_info_score,
	average_score,processed_by)
	select top 1 @LogID,@CustomerID,@p_name,@p_title,@p_designation,@p_nationality,@p_address,@p_birth_year,@p_birth_place,
	@p_comments,@p_document_info,s.DATAID,s.name_score,s.title_score,s.designation_score,
	s.nationality_score,s.address_score,s.birth_year_score,s.birth_place_score,s.comments_score,s.document_info_score,
	s.average_score,@p_processed_by
	from @tbl_sanction s order by s.average_score desc;
end

GO

create proc spGetScreeningReport
@LogID nvarchar(50)
as
begin
	select l.LogID AS LogID,l.CustomerID AS CustomerID,l.p_name as CustomerName,l.p_title as Title,l.p_designation as Designation,
	l.p_nationality as Nationality,	l.p_address as CustAddress, l.p_birth_year as DOB, l.p_birth_place as PlaceOfBirth, 
	l.p_comments as Comments,l.p_document_info as DocumentInfo,l.DATAID as DATAID,
	u.FULL_NAME + ' ' + u.INDIVIDUAL_ALIAS_NAME AS DFULL_NAME,u.COMMENTS1 AS DCOMMENTS1,u.DOCUMENT_INFO AS DDOCUMENT_INFO,
	u.TITLE DTITLE,u.DESIGNATION AS DDESIGNATION,u.NATIONALITY DNATIONALITY,
	u.INDIVIDUAL_ADDRESS_COUNTRY + ' ' + u.ENTITY_ADDRESS AS DADDRESS,
	l.name_score,l.title_score,l.designation_score,l.nationality_score,l.address_score,l.birth_year_score,l.birth_place_score,
	l.comments_score,l.document_info_score,l.average_score,v.EmployeeName as processed_by,l.processed_on
	from tblUNScreeningLog l inner join vwUNSanctionList u on l.DATAID = u.DATAID
	inner join tblVisitUsers v on l.processed_by = v.EmployeeID
	where LogID = @LogID;
end

exec spGetScreeningReport '20240320030921'

GO

-- exec spGetScreeningScore '20240328115942'
create proc spGetScreeningScore
@LogID nvarchar(50)
as
begin
	select average_score from tblUNScreeningLog where LogID = @LogID;
end

GO

create proc spGetScreeningMailInfo
@LogID nvarchar(50)
as
begin

	Declare @CustomerID as nvarchar(50) Set @CustomerID = '';
	Declare @CustomerName as nvarchar(200) Set @CustomerName = '';
	Declare @Title as nvarchar(200) Set @Title = '';
	Declare @Nationality as nvarchar(200) Set @Nationality = '';
	Declare @DATAID as nvarchar(200) Set @DATAID = '';
	Declare @average_score as numeric(5,2) set @average_score = 0;
	Declare @processed_by as nvarchar(50) set @processed_by = '';

	Declare @SubmissionDate as datetime;
	Declare @UserEmail as nvarchar(50) set @UserEmail = '';
	Declare @ApproverEmail as nvarchar(50) set @ApproverEmail = '';
	
	Declare @MailBody as nvarchar(4000) Set @MailBody = '';
	Declare @MailSubject as nvarchar(200) Set @MailSubject = 'UN Sanction Screening';
	Declare @MailTo as nvarchar(50) Set @MailTo = 'divopt@meridianfinancebd.com';
	Declare @MailFrom as nvarchar(50) Set @MailFrom ='';
	Declare @MailCC as nvarchar(50) Set @MailCC = '';
	Declare @MailBCC as nvarchar(50) Set @MailBCC = 'dsamaddar@meridianfinancebd.com';
	Declare @SoftwareLink  as nvarchar(500) Set @SoftwareLink = 'http://web.meridianfinancebd.com:4411/UNSanctionScreening/frmLogin.aspx'

	select @CustomerID = CustomerID,@CustomerName = p_name,@Title = p_title,
	@Nationality = p_nationality, @DATAID = DATAID,@average_score = average_score,@processed_by = u.EmployeeName,
	@MailFrom = dbo.fnGetVisitUserEmailByID(l.processed_by)
	from tblUNScreeningLog l inner join tblVisitUsers u on l.processed_by = u.EmployeeID
	where LogID = @LogID;

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>LogID</th>
		<th>CustomerID</th>
		<th>Customer Name</th>
		<th>Title</th>
		<th>Nationality</th>
		<th>UN MATCH ID</th>
		<th>Match Score</th>
		<th>Processed By</th>
	</tr>
	<tr>
		<td>' + @LogID + '</td>
		<td>' + @CustomerID + '</td>
		<td>' + @CustomerName + '</td>
		<td>' + @Title + '</td>
		<td>' + @Nationality + '</td>
		<td>' + @DATAID + '</td>
		<td>' + convert(nvarchar, @average_score) + '</td>
		<td>' + @processed_by + '</td>
	</tr>
	<tr>
		<td colspan=''2''>Software Link</td>
		<td colspan=''6''><a href='+@SoftwareLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>';

	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'divit@meridianfinancebd.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'divit@meridianfinancebd.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'divit@meridianfinancebd.com' else @MailCC end as 'MailCC',
	@MailBCC as 'MailBCC'
end

GO

