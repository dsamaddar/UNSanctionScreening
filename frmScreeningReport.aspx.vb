Imports System.Data

Partial Class frmView
    Inherits System.Web.UI.Page

    Dim SanctionScreeningCtrl As New clsSanctionScreening()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim LogID As String = Request.QueryString("LogID")
            GetScreeningReportDetails(LogID)
        End If
    End Sub

    Protected Sub GetScreeningReportDetails(ByVal LogID As String)
        Try
            Dim sanction As clsSanctionScreening = SanctionScreeningCtrl.fnGetScreeningReport(LogID)
            lblDATAID.Text = sanction.DATAID & " Match Score: " & sanction.average_score.ToString() & "%"
            lblCustomerID.Text = sanction.CustomerID
            lblCustomerName.Text = sanction.CustomerName
            lblTitle.Text = sanction.Title
            lblDesignation.Text = sanction.Designation
            lblNationality.Text = sanction.Nationality
            lblCustAddress.Text = sanction.CustAddress
            lblDOB.Text = sanction.DOB
            lblBirthPlace.Text = sanction.PlaceOfBirth
            lblScreeningDate.Text = sanction.processed_on
            lblComments.Text = sanction.Comments
            lblDocumentInfo.Text = sanction.DocumentInfo

            lblDFULL_NAME.Text = sanction.DFULL_NAME
            lblDTITLE.Text = sanction.DTITLE
            lblDDESIGNATION.Text = sanction.DDESIGNATION
            lblDNATIONALITY.Text = sanction.DNATIONALITY
            lblDADDRESS.Text = sanction.DADDRESS
            lblDCOMMENTS1.Text = sanction.DCOMMENTS1
            lblDDOCUMENT_INFO.Text = sanction.DDOCUMENT_INFO

            'progress bar
            nameProgressBar.Attributes.Add("style", "width:" & sanction.name_score.ToString() & "%")
            nameProgressBar.Attributes.Add("aria-valuenow", sanction.name_score)
            lblnameProgressPct.Text = Format(sanction.name_score, "Standard") & "%"

            titleProgressBar.Attributes.Add("style", "width:" & sanction.title_score.ToString() & "%")
            titleProgressBar.Attributes.Add("aria-valuenow", sanction.title_score)
            lbltitleProgressPct.Text = Format(sanction.title_score, "Standard") & "%"

            designationProgressBar.Attributes.Add("style", "width:" & sanction.designation_score.ToString() & "%")
            designationProgressBar.Attributes.Add("aria-valuenow", sanction.designation_score)
            lbldesignationProgressPct.Text = Format(sanction.designation_score, "Standard") & "%"

            nationalityProgressBar.Attributes.Add("style", "width:" & sanction.nationality_score.ToString() & "%")
            nationalityProgressBar.Attributes.Add("aria-valuenow", sanction.nationality_score)
            lblnationalityProgressPct.Text = Format(sanction.nationality_score, "Standard") & "%"

            addressProgressBar.Attributes.Add("style", "width:" & sanction.address_score.ToString() & "%")
            addressProgressBar.Attributes.Add("aria-valuenow", sanction.address_score)
            lbladdressProgressPct.Text = Format(sanction.address_score, "Standard") & "%"

            commentsProgressBar.Attributes.Add("style", "width:" & sanction.comments_score.ToString() & "%")
            commentsProgressBar.Attributes.Add("aria-valuenow", sanction.comments_score)
            lblcommentsProgressPct.Text = Format(sanction.comments_score, "Standard") & "%"

            docinfoProgressBar.Attributes.Add("style", "width:" & sanction.document_info_score.ToString() & "%")
            docinfoProgressBar.Attributes.Add("aria-valuenow", sanction.document_info_score)
            lbldocinfoProgressPct.Text = Format(sanction.document_info_score, "Standard") & "%"

            averageProgressBar.Attributes.Add("style", "width:" & sanction.average_score.ToString() & "%")
            averageProgressBar.Attributes.Add("aria-valuenow", sanction.average_score)
            lblaverageProgressPct.Text = Format(sanction.average_score, "Standard") & "%"

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
End Class
