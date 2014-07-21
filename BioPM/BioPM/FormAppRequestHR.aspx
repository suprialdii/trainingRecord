﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormAppRequestHR.aspx.cs" Inherits="BioPM.FormAppRequestHR" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
    }

    protected String GenerateRequestedPlan()
    {
        string htmlelement = "";
        object[] values = null;
        foreach (object[] data in BioPM.ClassObjects.ComDevPlan.GetComdevPlanByStatus("Confirmed") )
        {
            values = BioPM.ClassObjects.EmployeeCatalog.GetEmployeeByID(data[8].ToString());
            htmlelement += "<tr class=''><td>" + data[7].ToString() + "</td><td>" + data[5].ToString() + "</td><td>" + data[1].ToString() + "</td><td>" + data[3].ToString() + "</td><td>" + values[1].ToString() + "</td><td>" + values[2].ToString() + "</td><td><a class='edit' href='FormApprove.aspx?key=" + data[0].ToString() + "'>Approve</a></td><td><a class='edit' href='PageInformation.aspx?key=" + data[0].ToString() + "&type=000'>Reject</a></td></tr>";
        }
        
        return htmlelement;
    }
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>Approve Request From Employee</title>

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
                        Approve Request From Employee
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">

                        <div class="adv-table">
                            <div class="clearfix">
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
                         </div>
                        
                        New Request
                        <div class="adv-table">
                            <div class="clearfix">
                            <table class="table table-striped table-hover table-bordered" id="dynamic-table" >
                                <thead>
                                <tr>
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Competency Development Event</th>
                                    <th>Event Cost</th>
                                    <th>Position</th>
                                    <th>Unit</th>                                     
                                    <th>Approve</th>
                                    <th>Reject</th>                                    
                                </tr>
                                </thead>
                                <tbody>
                                <% Response.Write(GenerateRequestedPlan()); %>
                                </tbody>
                            </table>
                            </div>
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
