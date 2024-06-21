<%@ Page Language="VB" AutoEventWireup="false" CodeFile="frmScreeningReport.aspx.vb"
    Inherits="frmView" Title="UN Sanction Screening: Report" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Screening Report</title>
    <!-- Scripts -->

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>

    <!-- Fonts -->
    <link rel="dns-prefetch" href="//fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Nunito" rel="stylesheet">
    <!-- Styles -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <style>
        @media print
        {
            body
            {
                -webkit-print-color-adjust: exact;
                margin: none;
                transform: scale(.95);
            }
            page
            {
                size: portrait;
                margin: 10mm 10mm 20mm 10mm;
                mso-header-margin: 20mm;
                mso-footer-margin: 20mm;
                mso-paper-source: 0;
            }
            table
            {
                page-break-inside: avoid;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="container container-sm container-md container-lg text-left">
        <div class="row">
            <div class="col-md-12">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 30%">
                            <h4>
                                UN Sanction Screening Report
                            </h4>
                        </td>
                        <td style="width: 5%">
                            <%--<img src="Sources/images/un_logo.png" height="70px" />--%>
                        </td>
                        <td align="right" style="width: 65%">
                            <img src="Sources/images/meridian_logo.png" height="60px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%--<asp:Label ID="lblFinalScore" runat="server" Text="" ForeColor="#009900"></asp:Label>--%>
                        </td>
                        <td align="right">
                        </td>
                        <td align="right" colspan="3">
                            <h6>
                                Screening Date :
                                <asp:Label ID="lblScreeningDate" runat="server" Text=""></asp:Label>
                            </h6>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <h6 class="card-header bg-primary text-white">
                                Screening Parameters</h6>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Customer ID
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblCustomerID" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Customer Name
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblCustomerName" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Title
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Designation
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblDesignation" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Nationality
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblNationality" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblCustAddress" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            DOB
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblDOB" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Birty Place
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblBirthPlace" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Comments
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblComments" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Document Information
                        </td>
                        <td>
                            :
                        </td>
                        <td>
                            <asp:Label ID="lblDocumentInfo" runat="server" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-12">
                <br />
            </div>
            <div class="col-md-12">
                <div class="card">
                    <h6 class="card-header bg-primary text-white">
                        Maximum Match Found In Profile [ UN Sanction ID:
                        <asp:Label ID="lblDATAID" runat="server" Text=""></asp:Label>
                        ]
                    </h6>
                    <div class="card-body">
                        <h6 class="card-title">
                        </h6>
                        <div class="row border">
                            <table class="table table-bordered" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th scope="col" style="width: 20%">
                                            Criterion
                                        </th>
                                        <th scope="col" style="width: 50%">
                                            Value
                                        </th>
                                        <th scope="col" style="width: 30%">
                                            Score
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            Full Name
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDFULL_NAME" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="nameProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lblnameProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            Title
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblDTITLE" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="titleProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lbltitleProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            Designation
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblDDESIGNATION" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="designationProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lbldesignationProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            Nationality
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblDNATIONALITY" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="nationalityProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lblnationalityProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            Address
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblDADDRESS" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="addressProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lbladdressProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            Comments
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblDCOMMENTS1" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="commentsProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lblcommentsProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%">
                                            Document Information
                                        </td>
                                        <td style="width: 30%">
                                            <asp:Label ID="lblDDOCUMENT_INFO" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="docinfoProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lbldocinfoProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td style="width: 30%">
                                        </td>
                                        <td style="width: 30%">
                                            Overall Score
                                        </td>
                                        <td>
                                            <div class="progress" style="height: 30px;">
                                                <div runat="server" id="averageProgressBar" class="progress-bar" role="progressbar"
                                                    aria-valuemin="0" aria-valuemax="100">
                                                    <asp:Label ID="lblaverageProgressPct" class="text-dark font-weight-bold text-start"
                                                        runat="server"></asp:Label>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
