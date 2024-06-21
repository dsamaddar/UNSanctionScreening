Imports System.Data.SqlClient
Imports System.Configuration

Partial Class frmScreeningLog
    Inherits System.Web.UI.Page

    Dim SanctionScreeningCtrl As New clsSanctionScreening()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Session("EmployeeID") = "" Then
                Response.Redirect("~\frmLogin.aspx")
            End If

            GetScreeningLogList("%", Session("EmployeeID"))
        End If
    End Sub

    Protected Sub GetScreeningLogList(ByVal CustomerID As String, ByVal EmployeeID As String)
        Try
            grdVerificationLog.DataSource = SanctionScreeningCtrl.fnGetUNScreeningLogList(CustomerID, EmployeeID)
            grdVerificationLog.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub OnPageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdVerificationLog.PageIndex = e.NewPageIndex
        GetScreeningLogList("%", Session("EmployeeID"))
    End Sub

End Class
