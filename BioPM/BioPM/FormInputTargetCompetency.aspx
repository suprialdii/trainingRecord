﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormInputTargetCompetency.aspx.cs" Inherits="BioPM.FormInputTargetCompetency" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (!IsPostBack) SetCompetencyList();
    }
    //protected void sessionCreator()
    //{
    //    Session["username"] = "K495";
    //    Session["name"] = "ALLAN PRAKOSA";
    //    Session["password"] = "admin1234";
    //    Session["role"] = "111111";
    //}

    protected void SetCompetencyList()
    {
        ddlCompetency.Items.Clear();
        foreach (object[] data in BioPM.ClassObjects.CompetencyCatalog.GetAllCompetency())
        {
            ddlCompetency.Items.Add(new ListItem(data[1].ToString(), data[0].ToString()));
        }
    }

    protected void InsertOrganizationIntoDatabase()
    {
        //string ORGID = (BioPM.ClassObjects.OrganizationCatalog.GetOrganizationMaxID() + 1).ToString();
        //BioPM.ClassObjects.OrganizationCatalog.InsertOrganization(ORGID, txtOrgID.Text, ddlOrgType.SelectedValue, txtOrgName.Text, Session["username"].ToString());
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //if (IsPostBack) InsertOrganizationIntoDatabase();
        Response.Redirect("PageSuggestTraining.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("FormSuggestTraining.aspx");
    }

    protected String GenerateDataKompetensi()
    {
        string htmlelement = " ";

        return htmlelement;
    }
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>Event Target Entry Form</title>

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
                        Event Target Entry Form
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <form id="Form1" class="form-horizontal " runat="server" >

                        COMPETENCY TO DEVELOP

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> COMPETENCY NAME </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:DropDownList ID="ddlCompetency" runat="server" class="form-control m-bot15">   
                                </asp:DropDownList> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> PROFICIENCY LEVEL TARGET </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtLevelTarget" runat="server" class="form-control m-bot15" placeholder="PROFICIENCY LEVEL TARGET" ></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtLevelTarget" runat="server" ErrorMessage="This field is required." ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>

                        <table class="table table-striped table-hover table-bordered" id="dynamic-table" >
                                <thead>
                                <tr>
                                    <th>Competency Name</th>
                                    <th>Proficiency Level Target</th>
                                    <th>Delete</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% Response.Write(GenerateDataKompetensi()); %>
                                </tbody>
                        </table>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> </label>
                            <div class="col-lg-3 col-md-3">
                                <asp:Button class="btn btn-round btn-primary" ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"/>
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
