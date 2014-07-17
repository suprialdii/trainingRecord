﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormDataEvaluasi.aspx.cs" Inherits="BioPM.FormDataEvaluasi" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
    }

    protected void InsertAnswersIntoDatabase()
    {
        int ANSID;
        ANSID = BioPM.ClassObjects.Survey.GetAnswersMaxID() + 1;
        BioPM.ClassObjects.Survey.SubmitAnswers(ANSID.ToString(), Request.QueryString["key"].ToString(), "50", TextArea4.Text, Session["username"].ToString());
        ANSID = BioPM.ClassObjects.Survey.GetAnswersMaxID() + 1;
        BioPM.ClassObjects.Survey.SubmitAnswers(ANSID.ToString(), Request.QueryString["key"].ToString(), "51", TextArea1.Text, Session["username"].ToString());
        ANSID = BioPM.ClassObjects.Survey.GetAnswersMaxID() + 1;
        BioPM.ClassObjects.Survey.SubmitAnswers(ANSID.ToString(), Request.QueryString["key"].ToString(), "52", TextArea2.Text, Session["username"].ToString());
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (IsPostBack) InsertAnswersIntoDatabase();
        Response.Redirect("PageTrainingSurvey.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (Session["password"].ToString() == BioPM.ClassEngines.CryptographFactory.Encrypt(txtConfirmation.Text, true))
        //{
        //    InsertCompetencyIntoDatabase();
        //    Response.Redirect("PageCompetencyParameter.aspx");
        //}
        //else
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOUR PASSWORD IS INCORRECT" + "');", true);
        //}
    }
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>Formulir Data - Lembar Evaluasi Pelatihan</title>

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
                        Lembar Evaluasi Pelatihan
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    
                    <div class="panel-body">
                        <form id="Form1" class="form-horizontal " runat="server" >
                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtNama" runat="server" class="form-control m-bot15" placeholder="Nama"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Bentuk Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtBentukPelatihan" runat="server" class="form-control m-bot15" placeholder="Bentuk Pelatihan" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Pelatih </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtPelatih" runat="server" class="form-control m-bot15" placeholder="Pelatih" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Bagian </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtBagian" runat="server" class="form-control m-bot15" placeholder="Bagian" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tanggal Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtTanggal" runat="server" class="form-control m-bot15" placeholder="Tanggal Pelatihan" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Asal Unit Kerja </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtAsal" runat="server" class="form-control m-bot15" placeholder="Asal Unit Kerja" ></asp:TextBox>
                            </div>
                        </div>

                        <hr />

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Apakah judul/topik pelatihan? </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea4" TextMode="multiline" Columns="60" Rows="3" runat="server" />
                                </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Jelaskan secara singkat isi/materi pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea1" TextMode="multiline" Columns="60" Rows="10" runat="server" />
                                </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Penilaian pelatih/kepala bagian </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea2" TextMode="multiline" Columns="60" Rows="3" runat="server" />
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
                                <asp:LinkButton data-toggle="modal" class="btn btn-round btn-primary" ID="btnAction" runat="server" Text="Add" href="#myModal"/>
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
