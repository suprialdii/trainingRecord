﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageSurvey.aspx.cs" Inherits="BioPM.PageSurvey" %>

<!DOCTYPE html>

<script runat="server">
    object[] prmid = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (!IsPostBack)
        {
           
        }
    }

    protected String GenerateSurvey()
    {
        string htmlelement = "";
        int i = 1;
        foreach (object[] data in BioPM.ClassObjects.Survey.GetQuestions(Request.QueryString["type"].ToString()))
        {
            prmid[i] = data[0].ToString();                      
            if (data[2].ToString() == "R")
            {
                htmlelement += "<tr class=''><td rowspan='3'><label>" + i + "</label></td>";  
                htmlelement += "<td colspan='4'><label>" + data[1].ToString() + "</label></td></tr>";  
                htmlelement += "<tr class=''>";
                foreach (object[] values in BioPM.ClassObjects.Survey.GetOptionAnswers(data[0].ToString()))
                {
                    int j = 1;
                    htmlelement += "<td colspan='2'><input type='radio' ID=radio" +i+ " value=" + values[0].ToString() + ">" + values[0].ToString() + "</td>";
                    j++;
                }
                htmlelement += "</tr>";
                htmlelement += "<tr class=''><td colspan='4'><label>Alasan</label><br><input type='text' ID='txtAnswer" +i+ "'></td></tr>";
            }

            else if (data[2].ToString() == "T")
            {
                htmlelement += "<tr class=''><td rowspan='2'><label>" + i + "</label></td>";
                htmlelement += "<td colspan='4'><label>" + data[1].ToString() + "</label><br><input type='text' ID='txtAnswer"+i+"'></td></tr>";
            }
            i++;                     
        }

        return htmlelement;
    }

    protected void InsertDataIntoDatabase()
    {
        int numOfQuestion = BioPM.ClassObjects.Survey.GetNumOfQuestion(Request.QueryString["type"].ToString());
        for(int i=1; i<=numOfQuestion; i++)
        {
            int ANSID = BioPM.ClassObjects.Survey.GetAnswersMaxID() + 1;
            BioPM.ClassObjects.Survey.SubmitAnswers(ANSID, Request.QueryString["key"].ToString(), prmid[i].ToString(), txt, Session["username"].ToString());
        }        
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //InsertDataIntoDatabase();
        Response.Redirect("PageTrainingSurvey.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
    }
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>Event Method</title>

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
                        Survey 1
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">

                        <div class="adv-table">
                            <table class="table table-striped table-hover table-bordered" id="dynamic-table" >
                                <tbody>
                                    <% Response.Write(GenerateSurvey()); %>
                                </tbody>
                            </table>
                        </div>
                        <form id="Form1" class="form-horizontal " runat="server" >                                             

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> </label>
                            <div class="col-lg-3 col-md-3">
                                <asp:Button class="btn btn-round btn-primary" ID="btnAdd" runat="server" Text="Submit" OnClick="btnAdd_Click"/>
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
    <%Response.Write( BioPM.ClassScripts.SideBarMenu.RightSidebarMenuElement() ); %> 
<!--right sidebar end-->
</section>

<!-- Placed js at the end of the document so the pages load faster -->
    <% Response.Write(BioPM.ClassScripts.JS.GetCoreScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetDynamicTableScript()); %>
<% Response.Write(BioPM.ClassScripts.JS.GetInitialisationScript()); %>
</body>
</html>