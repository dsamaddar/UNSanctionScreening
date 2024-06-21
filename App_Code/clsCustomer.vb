Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.IO

Public Class clsCustomer

    Dim conMain As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("cnStringMain").ConnectionString)

    Dim _CustomerID, _CustomerName, _Title, _DOB, _PlaceOfBirth, _Designation, _Nationality, _CustAddress As String

    Public Property CustomerID() As String
        Get
            Return _CustomerID
        End Get
        Set(ByVal value As String)
            _CustomerID = value
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


#Region " Get UN Customer Details "

    Public Function fnGetReportDetails(ByVal CustomerID As String, ByVal ConStr As String) As clsCustomer
        Dim cnStr As String = ConfigurationManager.ConnectionStrings(ConStr).ConnectionString
        Dim con As New SqlConnection(cnStr)
        Dim sp As String = "spGetUNCustomerDetails"
        Dim dr As SqlDataReader
        Dim Customer As New clsCustomer()
        Try
            con.Open()

            Using cmd = New SqlCommand(sp, con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@CustomerID", CustomerID)
                dr = cmd.ExecuteReader()
                While dr.Read()
                    Customer.CustomerName = dr.Item("CustomerName")
                    Customer.Title = dr.Item("Title")
                    Customer.DOB = dr.Item("DOB")
                    Customer.PlaceOfBirth = dr.Item("PlaceOfBirth")
                    Customer.Designation = dr.Item("Designation")
                    Customer.Nationality = dr.Item("Nationality")
                    Customer.CustAddress = dr.Item("CustAddress")
                End While
                con.Close()

                Return Customer
            End Using
        Catch ex As Exception
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            Return Nothing
        End Try
    End Function

#End Region

End Class
