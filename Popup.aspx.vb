Imports System.Data
Imports System.Data.SqlClient

Partial Class Popup
    Inherits System.Web.UI.Page
    Public ColumnNo As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim DynamicTable As String
        DynamicTable = GetDynamicTable()
        If (DynamicTable <> "NOVALUE") Then
            tDiv.InnerHtml = DynamicTable
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), Guid.NewGuid().ToString(), "CreateTable(" & ColumnNo & ");", True)
        Else
            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('No Record Exist');", True)
        End If
    End Sub

    Public Function GetDynamicTable() As String
        Dim Query As String
        If Not Request.Params("Query") Is Nothing Then
            Query = Request.Params("Query")
        Else
            Query = "select dbo.getBankulatorDate() Date"
        End If
        Query = Query.Replace(".Plus.", "+")
        Query = Query.Replace("~~Eq~~", "=")
        Dim tmpdatevalue As DateTime
        Dim cnStr As String = ConfigurationManager.ConnectionStrings("cnStringMain").ConnectionString
        Dim con As New SqlConnection(cnStr)
        Dim cmd As New SqlCommand(Query, con)
        Dim str As String, StrVal As String
        Dim Type, Val As String
        Dim i, r As Integer
        con.Open()
        cmd.ExecuteNonQuery()

        str = "<table id=""ReportTable"" class=""yui"" >Click Row to select<thead> "

        Dim rd As SqlDataReader
        rd = cmd.ExecuteReader()

        ColumnNo = rd.FieldCount

        If rd.HasRows Then
            r = 0
            Do While (rd.Read())
                If (r = 0) Then
                    str += "<tr id=""HeaderRow"">"
                    For i = 0 To rd.FieldCount - 1
                        str += "<th><a href='#' title=""Click Header to Sort"">"
                        str += rd.GetName(i).ToString()
                        str += "</a></th>"
                    Next i
                    str += "</tr>"
                    str += "<tr>"

                    For i = 0 To rd.FieldCount - 1
                        str += "<th><input id=""filterBox" & i & """ value="""" maxlength=""30"" size=""20"" type=""text"" /><img id=""filterClear" & i & """ src=""_assets/img/cross.png"" title=""Click to clear filter."" alt=""Clear Filter Image"" /></th>"
                    Next i
                    str += "</tr>"
                    str += "</thead><tbody>"
                End If
                r = r + 1
                str += "<tr id=""row" & r & """ onmouseover=""this.style.cursor='hand'"" onclick=""RowSelected(" & r & ");"">"

                For i = 0 To rd.FieldCount - 1
                    Type = rd.Item(i).GetType().ToString()
                    str += "<td>"
                    If Type = "System.Decimal" Then
                        Val = rd.GetDecimal(i)
                        StrVal = String.Format("{0:#,##0.00}", Val)
                    ElseIf Type = "System.DateTime" Then
                        tmpdatevalue = rd.GetDateTime(i).ToString()
                        StrVal = Format(tmpdatevalue, "dd-MMM-yyyy")
                    Else
                        StrVal = rd.GetValue(i).ToString()
                    End If
                    str += StrVal
                    str += "</td>"
                Next i

                str += "</tr>"

            Loop

            str += "</tbody>"

        Else
            con.Close()
            Return "NOVALUE"
        End If
        con.Close()
        str += "<tfoot><tr id=""pagerOne""><td colspan=""7""><img src=""_assets/img/first.png"" class=""first""/><img src=""_assets/img/prev.png"" class=""prev""/><input type=""text"" class=""pagedisplay""/><img src=""_assets/img/next.png"" class=""next""/><img src=""_assets/img/last.png"" class=""last""/><select class=""pagesize""><option value=""10"">10</option><option value=""20"">20</option><option value=""30"">30</option></select></td></tr></tfoot></table>"

        Return str
    End Function
End Class
