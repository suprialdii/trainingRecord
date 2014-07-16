﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormEvaluasiSatu.aspx.cs" Inherits="BioPM.FormEvaluasiI" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (!IsPostBack)
        {
            //GetDataEvent();
            SetDataToForm();
        }
    }
    
    protected void SetDataToForm()
    {
        //object[] values = BioPM.ClassObjects.CompetencyCatalog.GetCompetencyById(BioPM.ClassEngines.CryptographFactory.Decrypt(Request.QueryString["key"], true));
        //txtEventName.Text = values[0].ToString();
        //txtEmployeeName.Text = values[1].ToString();
    }
    
    protected void InsertDataIntoDatabase()
    {
        //string RECID = (BioPM.ClassObjects.ComDevPlan.GetComDevPlanMaxID() + 1).ToString();
        //BioPM.ClassObjects.ComDevPlan.UpdateComDevPlan(RECID, Session["username"].ToString(), txtEventName.Text, txtMonth.Text, txtCost.Text, Session["username"].ToString());
        //BioPM.ClassObjects.ComDevPlan.InsertComDevPlanStatus(RECID, "Belum Disetujui", " ", Session["username"].ToString());
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        //InsertDataIntoDatabase();
        Response.Redirect("PageRequestTraining.aspx");
    }

    protected void btnAddComp_Click(object sender, EventArgs e)
    {
        InsertDataIntoDatabase();
        Response.Redirect("PageLabel.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
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

    <title>Evaluasi I</title>

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
                        Evaluasi I
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <form id="Form1" class="form-horizontal " runat="server" >
                            <table class="table table-striped table-hover table-bordered" id="survey" >
                                <thead>
                                    <tr>
                                    <th>No</th>
                                    <th>Pertanyaan</th>
                                    <th></th>
                                    <th>Alasan</th>
                                    </tr>                                    
                                </thead>
                                <tbody>
                                <tr>
                                    <td>1. </td>
                                    <td>Tujuan pelaksanaan pelatihan</td>
                                </tr>
                                <tr>
                                    <td>Tidak tercapai</td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="11" value="1" checked>
		                                        1
	                                        </label>
                                        </div>
                                    </td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="12" value="2" checked>
		                                        2
	                                        </label>
                                        </div>
                                    </td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="13" value="3" checked>
		                                        3
	                                        </label>
                                        </div>
                                    </td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="14" value="4" checked>
		                                        4
	                                        </label>
                                        </div>
                                    </td>
                                    <td>Tercapai</td>
                                </tr>
                                <tr>
                                    <td colspan="6">2. Tujuan anda mengikuti pelatihan ini</td>
                                </tr>
                                <tr>
                                    <td>Tidak tercapai</td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="Radio1" value="1" checked>
		                                        1
	                                        </label>
                                        </div>
                                    </td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="Radio2" value="2" checked>
		                                        2
	                                        </label>
                                        </div>
                                    </td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="Radio3" value="3" checked>
		                                        3
	                                        </label>
                                        </div>
                                    </td>
                                    <td><div class="radio">
	                                        <label>
		                                        <input type="radio" name="Soal1" id="Radio4" value="4" checked>
		                                        4
	                                        </label>
                                        </div>
                                    </td>
                                    <td>Tercapai</td>
                                </tr>
                                </tbody>
                             </table>
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
