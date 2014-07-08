﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormUpdateRequestTraining.aspx.cs" Inherits="BioPM.FormUpdateRequestTraining" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (!IsPostBack)
        {
            SetDataToForm();
            GetDataEvent();
        }
    }  
   
    
    protected void SetDataToForm()
    {
        object[] values = BioPM.ClassObjects.ComDevPlan.GetComdevPlanById(Request.QueryString["key"].ToString());
        txtRecID.Text = values[0].ToString();
        ddlEventName.SelectedValue = values[1].ToString();
    }

    protected void GetDataEvent()
    {
        ddlEventName.Items.Clear();
        foreach (object[] data in BioPM.ClassObjects.ComDevEvent.GetAllComdevEvent())
        {
            ddlEventName.Items.Add(new ListItem(data[1].ToString(), data[0].ToString()));
        }
    }
    
    protected void UpdateRequestTrainingOnDatabase()
    {
        BioPM.ClassObjects.ComDevPlan.UpdateComDevPlan(txtRecID.Text, Session["username"].ToString(), ddlEventName.SelectedValue, "", "", Session["username"].ToString());
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (IsPostBack) UpdateRequestTrainingOnDatabase();
        Response.Redirect("PageRequestTraining.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
    }
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>COMPETENCY ENTRY</title>

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
                        REQUEST TRAINING UPDATE FORM
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <form id="Form1" class="form-horizontal " runat="server" >
                         
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> PLANNING ID </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtRecID" runat="server" class="form-control m-bot15" placeholder="PLANNING ID" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> EVENT NAME </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:DropDownList ID="ddlEventName" runat="server" class="form-control m-bot15">   
                                </asp:DropDownList> 
                            </div>
                        </div>

                       
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> </label>
                            <div class="col-lg-3 col-md-3">
                                <asp:Button class="btn btn-round btn-primary" ID="btnAdd" runat="server" Text="Update" OnClick="btnAdd_Click"/>
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
