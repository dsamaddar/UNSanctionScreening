Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public Class clsSanctionScreening

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("cnStringMain").ConnectionString)

    Dim _LogID, _CustomerID, _DATAID, _CustomerName, _Title, _DOB, _PlaceOfBirth, _Designation, _Nationality, _CustAddress, _Comments, _DocumentInfo, _processed_by As String

    Public Property LogID() As String
        Get
            Return _LogID
        End Get
        Set(ByVal value As String)
            _LogID = value
        End Set
    End Property

    Public Property CustomerID() As String
        Get
            Return _CustomerID
        End Get
        Set(ByVal value As String)
            _CustomerID = value
        End Set
    End Property

    Public Property DATAID() As String
        Get
            Return _DATAID
        End Get
        Set(ByVal value As String)
            _DATAID = value
        End Set
    End Property

    Public Property CustomerName() As String
        Get
            Return _CustomerName
        End Get
        Set(ByVal value As String)
            _CustomerName = value
        End Set
    End Property

    Public Property Title() As String
        Get
            Return _Title
        End Get
        Set(ByVal value As String)
            _Title = value
        End Set
    End Property

    Public Property DOB() As String
        Get
            Return _DOB
        End Get
        Set(ByVal value As String)
            _DOB = value
        End Set
    End Property

    Public Property PlaceOfBirth() As String
        Get
            Return _PlaceOfBirth
        End Get
        Set(ByVal value As String)
            _PlaceOfBirth = value
        End Set
    End Property

    Public Property Designation() As String
        Get
            Return _Designation
        End Get
        Set(ByVal value As String)
            _Designation = value
        End Set
    End Property

    Public Property Nationality() As String
        Get
            Return _Nationality
        End Get
        Set(ByVal value As String)
            _Nationality = value
        End Set
    End Property

    Public Property CustAddress() As String
        Get
            Return _CustAddress
        End Get
        Set(ByVal value As String)
            _CustAddress = value
        End Set
    End Property

    Public Property Comments() As String
        Get
            Return _Comments
        End Get
        Set(ByVal value As String)
            _Comments = value
        End Set
    End Property

    Public Property DocumentInfo() As String
        Get
            Return _DocumentInfo
        End Get
        Set(ByVal value As String)
            _DocumentInfo = value
        End Set
    End Property

    Public Property processed_by() As String
        Get
            Return _processed_by
        End Get
        Set(ByVal value As String)
            _processed_by = value
        End Set
    End Property

    Dim _DFULL_NAME, _DTITLE, _DDESIGNATION, _DNATIONALITY, _DADDRESS, _DCOMMENTS1, _DDOCUMENT_INFO As String

    Public Property DFULL_NAME() As String
        Get
            Return _DFULL_NAME
        End Get
        Set(ByVal value As String)
            _DFULL_NAME = value
        End Set
    End Property

    Public Property DTITLE() As String
        Get
            Return _DTITLE
        End Get
        Set(ByVal value As String)
            _DTITLE = value
        End Set
    End Property

    Public Property DDESIGNATION() As String
        Get
            Return _DDESIGNATION
        End Get
        Set(ByVal value As String)
            _DDESIGNATION = value
        End Set
    End Property

    Public Property DNATIONALITY() As String
        Get
            Return _DNATIONALITY
        End Get
        Set(ByVal value As String)
            _DNATIONALITY = value
        End Set
    End Property

    Public Property DADDRESS() As String
        Get
            Return _DADDRESS
        End Get
        Set(ByVal value As String)
            _DADDRESS = value
        End Set
    End Property

    Public Property DCOMMENTS1() As String
        Get
            Return _DCOMMENTS1
        End Get
        Set(ByVal value As String)
            _DCOMMENTS1 = value
        End Set
    End Property

    Public Property DDOCUMENT_INFO() As String
        Get
            Return _DDOCUMENT_INFO
        End Get
        Set(ByVal value As String)
            _DDOCUMENT_INFO = value
        End Set
    End Property

    Dim _name_score, _title_score, _designation_score, _nationality_score, _address_score, _birth_year_score, _birth_place_score, _
    _comments_score, _document_info_score, _average_score As Double

    Public Property name_score() As Double
        Get
            Return _name_score
        End Get
        Set(ByVal value As Double)
            _name_score = value
        End Set
    End Property

    Public Property title_score() As Double
        Get
            Return _title_score
        End Get
        Set(ByVal value As Double)
            _title_score = value
        End Set
    End Property

    Public Property designation_score() As Double
        Get
            Return _designation_score
        End Get
        Set(ByVal value As Double)
            _designation_score = value
        End Set
    End Property

    Public Property nationality_score() As Double
        Get
            Return _nationality_score
        End Get
        Set(ByVal value As Double)
            _nationality_score = value
        End Set
    End Property

    Public Property address_score() As Double
        Get
            Return _address_score
        End Get
        Set(ByVal value As Double)
            _address_score = value
        End Set
    End Property

    Public Property birth_year_score() As Double
        Get
            Return _birth_year_score
        End Get
        Set(ByVal value As Double)
            _birth_year_score = value
        End Set
    End Property

    Public Property birth_place_score() As Double
        Get
            Return _birth_place_score
        End Get
        Set(ByVal value As Double)
            _birth_place_score = value
        End Set
    End Property

    Public Property comments_score() As Double
        Get
            Return _comments_score
        End Get
        Set(ByVal value As Double)
            _comments_score = value
        End Set
    End Property

    Public Property document_info_score() As Double
        Get
            Return _document_info_score
        End Get
        Set(ByVal value As Double)
            _document_info_score = value
        End Set
    End Property

    Public Property average_score() As Double
        Get
            Return _average_score
        End Get
        Set(ByVal value As Double)
            _average_score = value
        End Set
    End Property

    Dim _processed_on As Date

    Public Property processed_on() As Date
        Get
            Return _processed_on
        End Get
        Set(ByVal value As Date)
            _processed_on = value
        End Set
    End Property

#Region " Gen Scantion Log ID "

    Public Function fnGenScantionLogID() As String
        Dim sp As String = "spGenScantionLogID"
        Dim dr As SqlDataReader
        Dim LogID As String = ""
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                dr = cmd.ExecuteReader()
                While dr.Read()
                    LogID = dr.Item("LogID")
                End While
                con.Close()

                Return LogID
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return ""
        End Try
    End Function

#End Region

#Region " Get UN Screening Log List "

    Public Function fnGetUNScreeningLogList(ByVal CustomerID As String, ByVal EmployeeID As String) As DataSet

        Dim sp As String = "spGetUNScreeningLogList"
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Dim ds As DataSet = New DataSet()
        Try
            con.Open()
            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CustomerID", CustomerID)
                cmd.Parameters.AddWithValue("@EmployeeID", EmployeeID)
                da.SelectCommand = cmd
                da.Fill(ds)
                con.Close()
                Return ds
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Process UN Screening "

    Public Function fnProcessUNScreening(ByVal screening As clsSanctionScreening) As clsResult
        Dim result As New clsResult()
        Try
            Dim cmd As SqlCommand = New SqlCommand("spProcessUNScreening", con)
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@LogID", screening.LogID)
            cmd.Parameters.AddWithValue("@CustomerID", screening.CustomerID)
            cmd.Parameters.AddWithValue("@p_name", screening.CustomerName)
            cmd.Parameters.AddWithValue("@p_title", screening.Title)
            cmd.Parameters.AddWithValue("@p_designation", screening.Designation)
            cmd.Parameters.AddWithValue("@p_nationality", screening.Nationality)
            cmd.Parameters.AddWithValue("@p_address", screening.CustAddress)
            cmd.Parameters.AddWithValue("@p_birth_year", screening.DOB)
            cmd.Parameters.AddWithValue("@p_birth_place", screening.PlaceOfBirth)
            cmd.Parameters.AddWithValue("@p_comments", screening.Comments)
            cmd.Parameters.AddWithValue("@p_document_info", screening.DocumentInfo)
            cmd.Parameters.AddWithValue("@p_processed_by", screening.processed_by)
            cmd.ExecuteNonQuery()
            con.Close()
            result.Success = True
            result.Message = "UN Sanctoin Screening Processed"
            Return result
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            result.Success = False
            result.Message = ex.Message
            Return result
        End Try
    End Function

#End Region

#Region " Get Screening Score "

    Public Function fnGetScreeningScore(ByVal LogID As String) As Double
        Dim sp As String = "spGetScreeningScore"
        Dim dr As SqlDataReader
        Dim sanction As New clsSanctionScreening()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LogID", LogID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    sanction.average_score = dr.Item("average_score")
                End While
                con.Close()

                Return sanction.average_score
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

#Region " Get Screening Report "

    Public Function fnGetScreeningReport(ByVal LogID As String) As clsSanctionScreening
        Dim sp As String = "spGetScreeningReport"
        Dim dr As SqlDataReader
        Dim sanction As New clsSanctionScreening()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LogID", LogID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    sanction.CustomerID = dr.Item("CustomerID")
                    sanction.DATAID = dr.Item("DATAID")
                    sanction.CustomerName = dr.Item("CustomerName")
                    sanction.Title = dr.Item("Title")
                    sanction.DOB = dr.Item("DOB")
                    sanction.PlaceOfBirth = dr.Item("PlaceOfBirth")
                    sanction.Designation = dr.Item("Designation")
                    sanction.Nationality = dr.Item("Nationality")
                    sanction.CustAddress = dr.Item("CustAddress")
                    sanction.Comments = dr.Item("Comments")
                    sanction.DocumentInfo = dr.Item("DocumentInfo")

                    sanction.DFULL_NAME = dr.Item("DFULL_NAME")
                    sanction.DTITLE = dr.Item("DTITLE")
                    sanction.DDESIGNATION = dr.Item("DDESIGNATION")
                    sanction.DNATIONALITY = dr.Item("DNATIONALITY")
                    sanction.DADDRESS = dr.Item("DADDRESS")
                    sanction.DCOMMENTS1 = dr.Item("DCOMMENTS1")
                    sanction.DDOCUMENT_INFO = dr.Item("DDOCUMENT_INFO")

                    sanction.name_score = dr.Item("name_score")
                    sanction.title_score = dr.Item("title_score")
                    sanction.designation_score = dr.Item("designation_score")
                    sanction.nationality_score = dr.Item("nationality_score")
                    sanction.address_score = dr.Item("address_score")
                    sanction.birth_year_score = dr.Item("birth_year_score")
                    sanction.birth_place_score = dr.Item("birth_place_score")
                    sanction.comments_score = dr.Item("comments_score")
                    sanction.document_info_score = dr.Item("document_info_score")
                    sanction.average_score = dr.Item("average_score")

                    sanction.processed_by = dr.Item("processed_by")
                    sanction.processed_on = dr.Item("processed_on")

                End While
                con.Close()

                Return sanction
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region


    Public Function fnGetScreeningMailInfo(ByVal LogID As String) As clsMailProperty
        Dim sp As String = "spGetScreeningMailInfo"
        Dim dr As SqlDataReader
        Dim MailProp As New clsMailProperty()
        Try
            con.Open()
            Using cmd As SqlCommand = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@LogID", LogID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    MailProp.MailSubject = dr.Item("MailSubject")
                    MailProp.MailBody = dr.Item("MailBody")
                    MailProp.MailFrom = dr.Item("MailFrom")
                    MailProp.MailTo = dr.Item("MailTo")
                    MailProp.MailCC = dr.Item("MailCC")
                    MailProp.MailBCC = dr.Item("MailBCC")
                End While
                con.Close()
                Return MailProp
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

End Class
