﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormUpdatePositionRequirements.aspx.cs" Inherits="BioPM.FormUpdatePositionRequirements" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (!IsPostBack)
        {
            SetPositionAndCompetencyList();
            SetDataToForm();
        }
    }

    protected void InsertReasonIntoDatabase()
    {
        BioPM.ClassObjects.Reason.InsertReason(txtReason.Text, "Update Position Requirement", Session["username"].ToString());
    }

    protected void SetDataToForm()
    {
        object[] values = BioPM.ClassObjects.Jabatan.GetKualifikasiJabatanById(Request.QueryString["key"].ToString());
        txtPrqID.Text = values[0].ToString();
        txtLevel.Text = values[3].ToString();
        ddlJabatan.SelectedValue = values[1].ToString();
        ddlCompetency.SelectedValue = values[2].ToString();
    }

    protected void SetPositionAndCompetencyList()
    {
        ddlJabatan.Items.Clear();
        foreach (object[] data in BioPM.ClassObjects.Jabatan.GetAllJabatan())
        {
            ddlJabatan.Items.Add(new ListItem(data[1].ToString(), data[0].ToString()));
        }

        ddlCompetency.Items.Clear();
        foreach (object[] data in BioPM.ClassObjects.CompetencyCatalog.GetAllCompetency())
        {
            ddlCompetency.Items.Add(new ListItem(data[2].ToString(), data[0].ToString()));
        }
    }

    protected void UpdatePositionReqIntoDatabase()
    {
        BioPM.ClassObjects.Jabatan.UpdateJabatan(txtPrqID.Text, ddlJabatan.SelectedValue, ddlCompetency.SelectedValue, txtLevel.Text, Session["username"].ToString());
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (IsPostBack) UpdatePositionReqIntoDatabase();
        Response.Redirect("PagePositionRequirements.aspx?key=" + ddlJabatan.SelectedValue + "");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Session["password"].ToString() == BioPM.ClassEngines.CryptographFactory.Encrypt(txtConfirmation.Text, true))
        {
            UpdatePositionReqIntoDatabase();
            InsertReasonIntoDatabase();
            Response.Redirect("PagePositionRequirements.aspx?key=" + ddlJabatan.SelectedValue + "");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOUR PASSWORD IS INCORRECT" + "');", true);
        }
    }

</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>POSITION REQUIREMENTS UPDATE FORM</title>

    <% Response.Write(BioPM.ClassScripts.StyleScripts.GetCoreStyle()); %>
    <% Response.Write(BioPM.ClassScripts.StyleScripts.GetFormStyle()); %>
    <% Response.Write(BioPM.ClassScripts.StyleScripts.GetCustomStyle()); %>
</head>

<body>

<section id="container" >
 
<!--header start--> 
 <%Response.Write( BioPM.ClassScripts.SideBarMenu.TopMenuElement(Session["name"].ToString()) ); %> 
<!--header end-->
   
<!--left side bar start-->
 <%Response.Write(BioPM.ClassScripts.SideBarMenu.LeftSidebarMenuElementAutoGenerated(Session["username"].ToString())); %> 
<!--left side bar end-->

    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
        <!-- page start-->

        <div class="row">
            <div class="col-sm-12">
                <section class="panel">
                    <header class="panel-heading">
                        POSITION REQUIREMENTS UPDATE FORM
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <form id="Form2" class="form-horizontal " runat="server" >

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> POSITION REQUIREMENT ID </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtPrqID" runat="server" class="form-control m-bot15" placeholder="POSITION REQUIREMENT ID" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> POSITION NAME </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:DropDownList ID="ddlJabatan" runat="server" class="form-control m-bot15">   
                                </asp:DropDownList> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> COMPETENCY NAME </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:DropDownList ID="ddlCompetency" runat="server" class="form-control m-bot15">   
                                </asp:DropDownList> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> REQUIRED LEVEL </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtLevel" runat="server" class="form-control m-bot15" placeholder="PROFICIENCY LEVEL TARGET" ></asp:TextBox>
                            </div>
                        </div>

                        <!-- Modal -->
                        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title">Approver Confirmation</h4>
                                    </div>
                                    <div class="modal-body">
                                        <p>You Are Logged In As <% Response.Write(Session["name"].ToString()); %></p><br />
                                        <p>Are you sure to insert into database?</p>
                                        <asp:TextBox ID="txtConfirmation" runat="server" TextMode="Password" placeholder="Confirmation Password" class="form-control placeholder-no-fix"></asp:TextBox>
                                        <asp:TextBox ID="txtReason" TextMode="multiline" Columns="30" Rows="3" runat="server" placeholder="Reason" class="form-control placeholder-no-fix"></asp:TextBox>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button ID="btnClose" runat="server" data-dismiss="modal" class="btn btn-default" Text="Cancel"></asp:Button>
                                        <asp:Button ID="btnSubmit" runat="server" class="btn btn-success" Text="Confirm" OnClick="btnSave_Click"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- modal -->  

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> </label>
                            <div class="col-lg-3 col-md-3">
                                <asp:LinkButton data-toggle="modal" class="btn btn-round btn-primary" ID="btnAction" runat="server" Text="Update" href="#myModal"/>
                                <asp:Button class="btn btn-round btn-primary" ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
                            </div>
                        </div>
                            
                        </form>
                    </div>
                    
                </section>
            </div>
        </div>
        <!-- page end-->
        </section>
    </section>
    <!--main content end-->
<!--right sidebar start-->
    <%Response.Write(BioPM.ClassScripts.SideBarMenu.RightSidebarMenuElement()); %> 
<!--right sidebar end-->
</section>

<!-- Placed js at the end of the document so the pages load faster -->
   
<% Response.Write(BioPM.ClassScripts.JS.GetCoreScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetCustomFormScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetInitialisationScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetPieChartScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetSparklineChartScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetFlotChartScript()); %>
</body>
</html>
