﻿
Partial Class frmDashboard
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("EmployeeID") = "" Then
            Response.Redirect("~\frmLogin.aspx")
        End If
    End Sub
End Class
