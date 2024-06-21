Imports System.Net.Mail

Partial Class frmVerifySanctionList
    Inherits System.Web.UI.Page

    Dim CustomerCtrl As New clsCustomer()
    Dim SanctionScreeningCtrl As New clsSanctionScreening()

    Protected Sub btnFetchInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFetchInfo.Click
        Try
            Dim Customer As clsCustomer = CustomerCtrl.fnGetReportDetails(txtCustomerID.Text, drpConStr.SelectedValue)

            txtCustomerName.Text = Customer.CustomerName
            txtTitle.Text = Customer.Title
            txtDesignation.Text = Customer.Designation
            txtNationality.Text = Customer.Nationality
            txtBirthYear.Text = Customer.DOB
            txtBirthPlace.Text = Customer.PlaceOfBirth
            txtAddress.Text = Customer.CustAddress
            txtComments.Text = ""
            txtDocumentInfo.Text = ""

            GetScreeningLogList(txtCustomerID.Text, "%")
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetScreeningLogList(ByVal CustomerID As String, ByVal EmployeeID As String)
        Try
            grdVerificationLog.DataSource = SanctionScreeningCtrl.fnGetUNScreeningLogList(CustomerID, EmployeeID)
            grdVerificationLog.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnProcessVerification_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessVerification.Click
        Try
            Dim sanction As New clsSanctionScreening()
            Dim screening_score As Double = 0
            Dim MailProp As New clsMailProperty()

            sanction.LogID = lblLogID.Text
            sanction.CustomerID = txtCustomerID.Text
            sanction.CustomerName = txtCustomerName.Text
            sanction.Title = txtTitle.Text
            sanction.Designation = txtDesignation.Text
            sanction.Nationality = txtNationality.Text
            sanction.CustAddress = txtAddress.Text
            sanction.DOB = txtBirthYear.Text
            sanction.PlaceOfBirth = txtBirthPlace.Text
            sanction.Comments = txtComments.Text
            sanction.DocumentInfo = txtDocumentInfo.Text
            sanction.processed_by = Session("EmployeeID")

            Dim result = SanctionScreeningCtrl.fnProcessUNScreening(sanction)

            If result.Success = True Then
                screening_score = SanctionScreeningCtrl.fnGetScreeningScore(sanction.LogID)

                If screening_score >= 50 Then
                    'Send Notification
                    MailProp = SanctionScreeningCtrl.fnGetScreeningMailInfo(sanction.LogID)
                    SendMail(MailProp)
                End If
                lblLogID.Text = SanctionScreeningCtrl.fnGenScantionLogID()
                GetScreeningLogList(txtCustomerID.Text, Session("EmployeeID"))
            End If

            If result.Success = False Then
                lblErrorMessage.Text = result.Message
            End If
            MessageBox(result.Message)

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Session("EmployeeID") = "" Then
                Response.Redirect("~\frmLogin.aspx")
            End If
            lblLogID.Text = SanctionScreeningCtrl.fnGenScantionLogID()

        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub OnPageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdVerificationLog.PageIndex = e.NewPageIndex
        GetScreeningLogList(txtCustomerID.Text, Session("EmployeeID"))
    End Sub

    Protected Sub SendMail(ByVal MailProp As clsMailProperty)
        Dim mail As New Net.Mail.MailMessage()
        Dim TestArray() As String

        Try
            mail.From = New MailAddress(MailProp.MailFrom)

            TestArray = Split(MailProp.MailTo, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.To.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.CC.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailBCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.Bcc.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            mail.Subject = MailProp.MailSubject
            mail.Body = MailProp.MailBody
            mail.IsBodyHtml = True
            mail.Priority = MailPriority.Normal
            Dim smtp As New SmtpClient("192.168.1.15", 25)
            smtp.Send(mail)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
