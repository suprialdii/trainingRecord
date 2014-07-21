﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageCompetencyDevelopmentEvent.aspx.cs" Inherits="BioPM.PageCompetencyDevelopmentEvent" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
    }

    protected String GenerateDataEvent()
    {
        string htmlelement = "";

        foreach (object[] data in BioPM.ClassObjects.ComDevEvent.GetAllComdevEvent())
        {
<<<<<<< HEAD
            htmlelement += "<tr class=''><td>" + data[1].ToString() + "</td><td>" + data[2].ToString() + "</td>><td>" + data[3].ToString() + "</td><td><a class='edit' href='FormInputTargetTraining.aspx?key=" + data[0].ToString() + "'>View</a></td><td><a class='edit' href='FormUpdateEvent.aspx?key=" + data[0].ToString() + "'>Edit</a></td><td><a data-toggle='modal' ID='btnAction' runat='server' Text='Delete' href='#myModal'>Delete</a></td></tr>";
=======
            htmlelement += "<tr class=''><td>" + data[1].ToString() + "</td><td>" + data[2].ToString() + "</td><td>" + data[3].ToString() + "</td><td><a class='edit' href='PageTargetTraining.aspx?key=" + data[0].ToString() + "'>View</a></td><td><a class='edit' href='FormUpdateEvent.aspx?key=" + data[0].ToString() + "'>Edit</a></td><td><a data-toggle='modal' ID='btnAction' runat='server' Text='Delete' href='#myModal'>Delete</a></td></tr>";
>>>>>>> origin/master
        }
        
        return htmlelement;
    }

    protected void InsertReasonIntoDatabase()
    {
        BioPM.ClassObjects.Reason.InsertReason(txtReason.Text, "Delete Event", Session["username"].ToString());
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {
        if (Session["password"].ToString() == BioPM.ClassEngines.CryptographFactory.Encrypt(txtConfirmation.Text, true))
        {
            InsertReasonIntoDatabase();
            Response.Redirect("PageInformation.aspx?key=24");
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

    <title>Competency Development Event</title>

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
                        Competency Development Event
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">

                        <div class="adv-table">
                            <div class="clearfix">
                                <div class="btn-group">
                                    <button id="editable-sample_new" onclick="document.location.href='FormInputEvent.aspx';" class="btn btn-primary"> Add New <i class="fa fa-plus"></i>
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
                            <table class="table table-striped table-hover table-bordered" id="dynamic-table">
                                <thead>
                                <tr>
                                    <th>Event Name</th>                                   
                                    <th>Event Method</th>
                                    <th>Event Group</th>
                                    <th>Target Detail</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% Response.Write(GenerateDataEvent()); %>
                                </tbody>
                            </table>
                        </div>
                        <!-- Modal -->
                        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
                          <form id="form1" runat="server">
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
                                        <asp:Button ID="btnSubmit" runat="server" class="btn btn-success" Text="Confirm" OnClick="btnDel_Click"></asp:Button>
                                    </div>
                                </div>
                            </div>
                          </form>
                        </div>
                        <!-- modal -->  
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
