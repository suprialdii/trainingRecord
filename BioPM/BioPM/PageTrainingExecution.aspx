﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageTrainingExecution.aspx.cs" Inherits="BioPM.PageTrainingExecution" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
    }

    protected void InsertReasonIntoDatabase()
    {
        BioPM.ClassObjects.Reason.InsertReason(txtReason.Text, "Delete Training", Session["username"].ToString());
    }

    protected String GenerateDataEksekusi()
    {
        string htmlelement = "";

        foreach (object[] data in BioPM.ClassObjects.ComDevExecution.GetAllComdevExecution())
        {
            htmlelement += "<tr class=''><td>" + data[11].ToString() + "</td><td>" + data[2].ToString() + "-" + data[3].ToString() + "</td><td>" + data[4].ToString() + "</td><td>" + data[10].ToString() + "</td><td><a class='edit' href='PageInstitutionDetail.aspx?key=" + data[0].ToString() + "'>" + data[5].ToString() + "</a></td><td>" + data[6].ToString() + "-" + data[7].ToString() + "</td><td>" + data[8].ToString() + "</td><td>" + data[9].ToString() + "</td><td><a class='edit' href='FormUpdateTrainingExecution.aspx?key=" + data[0].ToString() + "'>Edit</a></td><td><a data-toggle='modal' ID='btnAction' runat='server' Text='Delete' href='#myModal'>Delete</a></td></tr>";
        }
        
        return htmlelement;
    }

    protected void btnDel_Click(object sender, EventArgs e)
    {
        if (Session["password"].ToString() == BioPM.ClassEngines.CryptographFactory.Encrypt(txtConfirmation.Text, true))
        {
            InsertReasonIntoDatabase();
            Response.Redirect("PageInformation.aspx?type=26");
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

    <title>Comdev Event Execution</title>

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
                        Comdev Event Execution
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <div class="adv-table">
                            <div class="clearfix">
                                <div class="btn-group">
                                    <button id="editable-sample_new" onclick="document.location.href='FormInputTrainingExecution.aspx';" class="btn btn-primary"> Add New <i class="fa fa-plus"></i>
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
                            <table class="table table-striped table-hover table-bordered" id="dynamic-table" >
                                <thead>
                                <tr>
                                    <th>Employee Name</th>
                                    <th>Event Name</th>
                                    <th>Speaker</th> 
                                    <th>Cost</th>    
                                    <th>Institution</th>  
                                    <th>Date of Execution</th>  
                                    <th>Status</th>  
                                    <th>Score</th>                                       
                                    <th>Edit</th>
                                    <th>Delete</th>
                                </tr>
                                </thead>
                                <tbody>
                                <% Response.Write(GenerateDataEksekusi()); %>
                                </tbody>
                            </table>
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
