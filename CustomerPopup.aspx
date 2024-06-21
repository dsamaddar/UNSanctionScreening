<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CustomerPopup.aspx.vb" Inherits="CustomerPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Selection</title>
</head>
<body onload="CustomerType();">
    <form id="form1" runat="server">
    <script type="text/javascript">
        function CustomerType() {
            if (document.getElementById("rdInd").checked == true) {
                document.getElementById("Individual").style.display = "block";
                document.getElementById("Corporate").style.display = "none";
            }
            else if (document.getElementById("rdCorp").checked == true) {
                document.getElementById("Individual").style.display = "none";
                document.getElementById("Corporate").style.display = "block";
            }
                
        }
    </script>
    <input id="rdInd" type="radio" name="CustType" value="Individual" onclick="CustomerType();" checked="checked" />Individual&nbsp;<input id="rdCorp" type="radio" name="CustType" value="Corporate" onclick="CustomerType();" />Corporate
    
    <div id="Individual">
    <iframe src="PopupServer.aspx?Query=select+*+from+vwIndividualCustomer&SortCol=CustomerID&placement=0txtCustomerID&selColumn=1&ColType=valueload" marginwidth=0 marginheight=0 frameborder=0 style="height: 200px; width:400px; background-color:#EFF9FE; margin-bottom:6px" name="design-news"></iframe>
    </div>
    <div id="Corporate">
    <iframe src="PopupServer.aspx?Query=select+*+from+vwCorporateCustomer&SortCol=CustomerID&placement=0txtCustomerID&selColumn=1&ColType=valueload" marginwidth=0 marginheight=0 frameborder=0 style="height: 200px; width:400px; background-color:#EFF9FE; margin-bottom:6px" name="design-news"></iframe>
    </div>
    </form>
</body>
</html>
