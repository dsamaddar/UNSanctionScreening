<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    MaintainScrollPositionOnPostback="true" CodeFile="frmVerifySanctionList.aspx.vb"
    Inherits="frmVerifySanctionList" Title=".:UN Sanction Screening: Verification:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">

    <script type="text/javascript">
    var ProductModule = "";

    function OpenURL(URL) {
        URL1 = URL.substr(0, URL.indexOf("?"));

        var myForm = document.createElement("form");
        myForm.method = "post";
        myForm.action = URL1//"CommonAuditTrail.aspx";
        myForm.target = "_self";

        if (URL.indexOf("?") > -1) {
            var ParamFullString = URL.substr(URL.indexOf("?") + 1);
            var ParamArray = ParamFullString.split("&");
            for (var iParam = 0; iParam < ParamArray.length; iParam++) {
                var info = ParamArray[iParam].split("=");
                var myInput = document.createElement("input");
                myInput.setAttribute("type", "hidden");
                myInput.setAttribute("name", info[0]);
                myInput.setAttribute("value", info[1]);
                myForm.appendChild(myInput);
            }
            document.body.appendChild(myForm);
            myForm.submit();
        }
        //window.open(URL1);
    }
    
        function PlaceAgreementID() {
           document.getElementById('body_txtAgreementNo').value = document.getElementById("txtReturn").value;
           document.getElementById("btn_open_agr").disabled = true;
        }
    

    function OnFailed(error, userContext) {
        alert("Failed:" + error);
    }
    function CustomerPopup() {
        window.open("CustomerPopup.aspx", "mywindow", "menubar=0,resizable=1,scrollbars=1,width=1000,height=400");
    }
    
    function GetCustomerCategory() {
        var ddlID = '#<%= drpCustomerCategory.ClientID %>';
        var selectedText = $(ddlID + " option:selected").text();
        return selectedText;
    }
    
    function GetConStr() {
        var ddlID = '#<%= drpConStr.ClientID %>';
        var selectedText = $(ddlID + " option:selected").text();
        return selectedText;
    }

    function OpenCustomer() {
 
        var CustomerCategory = GetCustomerCategory();
        //alert(CustomerCategory);
        
        if (CustomerCategory == "Personal")
            Popup("select CustomerID,Title,CustomerName,FathersName,MothersName from vwCustomerPopupPersonal", "1", "<%=txtCustomerID.ClientID %>", "valueload", "server", "CustomerName");
        else if (CustomerCategory == "Individual Concern")
            Popup("select CustomerID,TradeName,OwnersTitle,OwnerName,OwnerFatherName,OwnerMotherName from vwCustomerPopupIndividualConcern", "1", "<%=txtCustomerID.ClientID %>", "valueload", "server", "TradeName");
        else
            Popup("select CustomerID,TradeName,LegalForm,Address from vwCustomerPopupCompany", "1", "<%=txtCustomerID.ClientID %>", "valueload", "server", "TradeName");
        
    }
    
        function Popup(Query, SelColumn, Placement, ColType, FilterType, SortCol) {
            var exp = new RegExp("~~C~~","g");
            Query = Query.replace(exp, "'");           
            var ConStr = GetConStr();
            //alert(ConStr);
            
            if (FilterType=="client")
                window.open("Popup.aspx?Query=" + Query + "&SelColumn=" + SelColumn + "&Placement=" + Placement + "&ColType=" + ColType + "&ConStr=" + ConStr, "mywindow", "menubar=0,resizable=1,scrollbars=1,width=1000,height=400");
            else
                window.open("PopupServer.aspx?Query=" + Query + "&SelColumn=" + SelColumn + "&Placement=" + Placement + "&ColType=" + ColType + "&SortCol=" + SortCol + "&ConStr=" + ConStr, "mywindow", "menubar=0,resizable=1,scrollbars=1,width=1000,height=400");
                
        }    
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="container text-left">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <h6 class="card-header">
                        UN Sanction Screening [
                        <asp:Label ID="lblLogID" runat="server" Text="" ForeColor="#003399"></asp:Label>
                        ] <a href="frmDashboard.aspx"><i class="fa-solid fa-house-user fa-2x"></i></a>
                    </h6>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                <label for="body_txtCustomerID" class="form-label">
                                    Module</label>
                            </div>
                            <div class="col-md-3">
                                <asp:DropDownList ID="drpConStr" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Conventional">Conventional</asp:ListItem>
                                    <asp:ListItem Value="Islamic">Islamic</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3">
                                <label for="body_txtCustomerID" class="form-label">
                                    Customer Category</label>
                            </div>
                            <div class="col-md-3">
                                <asp:DropDownList ID="drpCustomerCategory" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Personal">Personal</asp:ListItem>
                                    <asp:ListItem Value="Individual Concern">Individual Concern</asp:ListItem>
                                    <asp:ListItem Value="Company">Company</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                            <div class="col-md-3">
                                <label for="body_txtCustomerID" class="form-label">
                                    Customer ID</label>
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtCustomerID" class="form-control" CssClass="form-control" type="text"
                                    runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-3">
                                <input id="btn_open_customer" type='button' value='....' onclick='OpenCustomer();' />
                                <input type="text" id="txtReturn" style="display: none;" onchange="PlaceAgreementID();" />
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="btnFetchInfo" class="btn btn-secondary btn-block" runat="server"
                                    Text="Fetch" />
                            </div>
                            <div>
                                <br />
                            </div>
                            <div class="col-md-12">
                                <asp:Label ID="lblErrorMessage" class="bg-danger btn-block" runat="server" Text=""></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="col-md-12">
                <div class="card">
                    <h6 class="card-header">
                        Available Information on CBS
                    </h6>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-2">
                                <label for="txtCustomerName" class="form-label">
                                    Client Name</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtCustomerName" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtTitle" class="form-label">
                                    Title</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtDesignation" class="form-label">
                                    Designation</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtDesignation" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtNationality" class="form-label">
                                    Nationality</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtNationality" CssClass="form-control" Text="Bangladeshi" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtBirthYear" class="form-label">
                                    Birty Year</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtBirthYear" CssClass="form-control" Text="" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtBirthPlace" class="form-label">
                                    Birth Place</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtBirthPlace" CssClass="form-control" Text="" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtAddress" class="form-label">
                                    Address</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtComments" class="form-label">
                                    Comments</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtComments" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <label for="txtDocumentInfo" class="form-label">
                                    Document Information</label>
                            </div>
                            <div class="col-md-4">
                                <asp:TextBox ID="txtDocumentInfo" CssClass="form-control" runat="server" TextMode="MultiLine"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <asp:Button ID="btnProcessVerification" class="btn btn-success btn-block" runat="server"
                                    Text="Start Verification Process" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="col-md-12">
                <div class="card">
                    <h6 class="card-header">
                        Existing Verification
                    </h6>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div style="width: 100%; overflow: auto">
                                    <asp:GridView ID="grdVerificationLog" CssClass="table" runat="server" AutoGenerateColumns="False"
                                        AllowPaging="True" AllowSorting="True" PageSize="2" OnPageIndexChanging="OnPageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="View">
                                                <ItemTemplate>
                                                    <a href='<%# Eval("LogID","frmScreeningReport.aspx?LogID={0}") %>' target="_blank"><i
                                                        class="fa-solid fa-eye"></i></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="CustomerID">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CustomerID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("p_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Match ID">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("DATAID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Score">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("average_score") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Processed By">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("processed_by") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Processed On">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("processed_on") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
