<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    MaintainScrollPositionOnPostback="true" CodeFile="frmScreeningLog.aspx.vb" Inherits="frmScreeningLog"
    Title=".:UN Sanction Screening: Log:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-header">
                        Screening Log <a href="frmDashboard.aspx"><i class="fa-solid fa-house-user fa-2x"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div style="width: 100%; overflow: auto">
                                    <asp:GridView ID="grdVerificationLog" CssClass="table" runat="server" AutoGenerateColumns="False"
                                        AllowPaging="True" AllowSorting="True" PageSize="4" OnPageIndexChanging="OnPageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="View">
                                                <ItemTemplate>
                                                    <a href='<%# Eval("LogID","frmScreeningReport.aspx?LogID={0}") %>' target="_blank"><i
                                                        class="fa-solid fa-eye"></i></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" />
                                            <asp:BoundField DataField="p_name" HeaderText="Name" />
                                            <asp:BoundField DataField="DATAID" HeaderText="Match ID" />
                                            <asp:BoundField DataField="average_score" HeaderText="Score" />
                                            <asp:BoundField DataField="processed_by" HeaderText="Processed By" />
                                            <asp:BoundField DataField="processed_on" HeaderText="Processed On" />
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
