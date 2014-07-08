﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageSuggestTraining.aspx.cs" Inherits="BioPM.PageSuggestTraining" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
    }

    protected String GenerateRequestedPlan()
    {
        string htmlelement = "";

        foreach (object[] data in BioPM.ClassObjects.ComDevPlan.GetComdevPlanByStatus("Belum Disetujui") )
        {
            htmlelement += "<tr class=''><td>" + data[5].ToString() + "</td><td>" + data[1].ToString() + "</td><td><a class='edit' href='FormApproveRequest.aspx?key=" + data[0].ToString() + "'>Approve</a></td><td><a class='delete' href='#.aspx?key=" + data[0].ToString() + "&type=000'>Reject</a></td></tr>";
        }
        
        return htmlelement;
    }

    protected String GenerateApprovedPlan()
    {
        string htmlelement = "";

        foreach (object[] data in BioPM.ClassObjects.ComDevPlan.GetComdevPlanByStatus("Disetujui"))
        {
            htmlelement += "<tr class=''><td>" + data[5].ToString() + "</td><td>" + data[1].ToString() + "</td><td><a class='edit' href='#.aspx?key=" + data[0].ToString() + "'>Edit</a></td><td><a class='delete' href='#.aspx?key=" + data[0].ToString() + "&type=000'>Delete</a></td></tr>";
        }

        return htmlelement;
    }

    protected String GenerateRejectedPlan()
    {
        string htmlelement = "";

        foreach (object[] data in BioPM.ClassObjects.ComDevPlan.GetComdevPlanByStatus("Ditolak"))
        {
            htmlelement += "<tr class=''><td>" + data[5].ToString() + "</td><td>" + data[1].ToString() + "</td><td><a class='edit' href='#.aspx?key=" + data[0].ToString() + "'>Edit</a></td><td><a class='delete' href='#.aspx?key=" + data[0].ToString() + "&type=000'>Delete</a></td></tr>";
        }

        return htmlelement;
    }

    protected String GenerateSuggestedPlan()
    {
        string htmlelement = "";

        foreach (object[] data in BioPM.ClassObjects.ComDevPlan.GetComdevPlanByStatus("Diusulkan"))
        {
            htmlelement += "<tr class=''><td>" + data[5].ToString() + "</td><td>" + data[1].ToString() + "</td><td><a class='edit' href='FormUpdateSuggestTraining.aspx?key=" + data[0].ToString() + "'>Edit</a></td><td><a class='delete' href='PageInformation.aspx?key=" + data[0].ToString() + "&type=27'>Delete</a></td></tr>";
        }

        return htmlelement;
    }
   
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>Training Suggestion</title>

    <% Response.Write(BioPM.ClassScripts.StyleScripts.GetCoreStyle()); %>
<% Response.Write(BioPM.ClassScripts.StyleScripts.GetTableStyle()); %>
<% Response.Write(BioPM.ClassScripts.StyleScripts.GetCustomStyle()); %>
</head>

<body>

<section id="container" >
 
<!--header start--> 
 <%Response.Write( BioPM.ClassScripts.SideBarMenu.TopMenuElement(Session["name"].ToString())); %> 
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
                        Your Training Suggestion
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">

                        <div class="adv-table">
                            <div class="clearfix">
                                <div class="btn-group">
                                    <button id="Button1" onclick="document.location.href='FormSuggestTraining.aspx';" class="btn btn-primary"> Add New <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                                <div class="btn-group pull-right">
                                    <button class="btn btn-default dropdown-toggle" data-toggle="dropdown">Tools <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu pull-right">
                                        <li><a href="#">Print</a></li>
                                        <li><a href="#">Save as PDF</a></li>
                                        <li><a href="#">Export to Excel</a></li>
                                    </ul>
                                </div>
                            </div>
                            <table class="table table-striped table-hover table-bordered" id="Table1" >
                                <thead>
                                <tr>
                                    <th>Employee Name</th>
                                    <th>Suggested Competency Development Event</th>                                   
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% Response.Write(GenerateSuggestedPlan()); %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                </section>
            </div>
        </div>

        <!-- page end-->
        </section>
    </section>
    <!--main content end-->
<!--right sidebar start-->
    <%Response.Write( BioPM.ClassScripts.SideBarMenu.RightSidebarMenuElement() ); %> 
<!--right sidebar end-->
</section>

<!-- Placed js at the end of the document so the pages load faster -->
    <% Response.Write(BioPM.ClassScripts.JS.GetCoreScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetDynamicTableScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetInitialisationScript()); %>
</body>
</html>
