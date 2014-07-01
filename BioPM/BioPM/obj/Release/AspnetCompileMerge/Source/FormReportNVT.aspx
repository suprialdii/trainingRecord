﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormReportNVT.aspx.cs" Inherits="BioPM.FormReportNVT" %>

<!DOCTYPE html>
<script runat="server">
    Random rand = new Random();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (Session["coctr"].ToString() != "52500" && Session["coctr"].ToString() != "64100") Response.Redirect("PageUserPanel.aspx");
        if (!IsPostBack)
        {
            GetRandomAnimalDate();
            SetAnimalRandomValueToForm();
        }
    }
    protected void sessionCreator()
    {
        Session["username"] = "K495";
        Session["name"] = "ALLAN PRAKOSA";
        Session["password"] = "admin1234";
        Session["role"] = "111111";
    }

    protected void GetRandomAnimalDate()
    {
        ddlRandomDate.Items.Clear();
        foreach (object[] data in BioPM.ClassObjects.NvtCatalog.GetNvtRandom())
        {
            ddlRandomDate.Items.Add(new ListItem(BioPM.ClassEngines.DateFormatFactory.GetDateFormat(data[1].ToString()) + " - " + data[3].ToString() + " with " + data[4].ToString() + " Animals " + "(ID" + data[0].ToString() + ")", data[0].ToString()));
        }
    }

    protected void SetAnimalRandomValueToForm()
    {
        if (ddlRandomDate.SelectedValue != "")
        {
            object[] values = BioPM.ClassObjects.NvtCatalog.GetDetailNVTRandombyRNDID(ddlRandomDate.SelectedValue);
            txtAnimalNumber.Text = values[1].ToString();
            txtSampleNumber.Text = values[0].ToString();
        }
    }

    protected void ddlRandomDate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            SetAnimalRandomValueToForm();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (!BioPM.ClassEngines.ValidationFactory.ValidateNullInput(ddlRandomDate.Text))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + BioPM.ClassEngines.ValidationFactory.GetErrorMessage(1, "QC RANDOM DATE", "") + "');", true);
        }
        else
        {
            Session["id"] = ddlRandomDate.SelectedValue;
            Response.Redirect("PageReportNVT.aspx");
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
    }
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>QC TEST REPORT</title>

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
                        QC TEST REPORT ENTRY FORM
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <form class="form-horizontal " runat="server" >

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> RANDOM DATE </label>
                            <div class="col-lg-3 col-md-4">
                            <asp:DropDownList ID="ddlRandomDate" AutoPostBack="true" OnSelectedIndexChanged="ddlRandomDate_SelectedIndexChanged" runat="server" class="form-control m-bot15"> 
                                </asp:DropDownList> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> NUMBER OF ANIMAL </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtAnimalNumber" runat="server" class="form-control m-bot15" ></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> NUMBER OF SAMPLE </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtSampleNumber" runat="server" class="form-control m-bot15" ></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> </label>
                            <div class="col-lg-3 col-md-3">
                                <asp:Button class="btn btn-round btn-primary" ID="btnAdd" runat="server" Text="View" OnClick="btnAdd_Click"/>
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
