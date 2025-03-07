﻿Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.IO

Public Class clsCommon

    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("cnStringMain").ConnectionString)

    Public Shared Sub ExportToExel(ByVal grdvw As GridView, ByVal rptname As String)

        Dim attachment As String = "attachment; filename=" & rptname & ".xls"
        HttpContext.Current.Response.ClearContent()
        HttpContext.Current.Response.AddHeader("content-disposition", attachment)
        HttpContext.Current.Response.ContentType = "application/ms-excel"
        Dim sw As New StringWriter()
        Dim htw As New HtmlTextWriter(sw)

        grdvw.AllowSorting = False
        grdvw.AllowPaging = False
        grdvw.AutoGenerateSelectButton = False
        grdvw.AutoGenerateEditButton = False
        grdvw.AutoGenerateDeleteButton = False
        grdvw.DataBind()

        ' Create a form to contain the grid
        Dim frm As New HtmlForm()
        grdvw.Parent.Controls.Add(frm)
        frm.Attributes("runat") = "server"
        frm.Controls.Add(grdvw)

        frm.RenderControl(htw)
        'grdvw.RenderControl(htw)
        HttpContext.Current.Response.Write(sw.ToString())
        HttpContext.Current.Response.[End]()

    End Sub
End Class
