﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageEvaluasiPerilaku.aspx.cs" Inherits="BioPM.PageEvaluasiTiga" %>

<!DOCTYPE html>
<script runat="server">
    string empId = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (!IsPostBack)
            SetDataToPage();
    }

    protected void InsertReasonIntoDatabase()
    {
        BioPM.ClassObjects.Reason.InsertReason(txtReason.Text, "Submit Evaluasi 3", Session["username"].ToString());
    }

    protected void SetDataToPage()
    {
        string excid = Request.QueryString["key"].ToString();
        object[] data = null;
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "1");
        string keterangan1 = null;
        if (data[1].ToString() == "4")
            keterangan1 = "Tercapai";
        else if (data[1].ToString() == "3")
            keterangan1 = "Cukup Tercapai";
        else if (data[1].ToString() == "2")
            keterangan1 = "Kurang Tercapai";
        else if (data[1].ToString() == "1")
            keterangan1 = "Tidak Tercapai";
        txtSoal1.Text = keterangan1;
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "2");
        TextArea1.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "3");
        string keterangan2 = null;
        if (data[1].ToString() == "4")
            keterangan2 = "Sudah diaplikasikan";
        else if (data[1].ToString() == "3")
            keterangan2 = "Cukup diaplikasikan";
        else if (data[1].ToString() == "2")
            keterangan2 = "Kurang diaplikasikan";
        else if (data[1].ToString() == "1")
            keterangan2 = "Belum diaplikasikan";
        txtSoal2.Text = keterangan2;
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "4");
        TextArea2.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "5");
        string keterangan3 = null;
        if (data[1].ToString() == "4")
            keterangan3 = "Sangat Baik";
        else if (data[1].ToString() == "3")
            keterangan3 = "Baik";
        else if (data[1].ToString() == "2")
            keterangan3 = "Buruk";
        else if (data[1].ToString() == "1")
            keterangan3 = "Sangat Buruk";
        txtSoal3.Text = keterangan3;
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "6");
        TextArea3.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "7");
        TextArea4.Text = data[1].ToString();
        object[] dataEksekusi = BioPM.ClassObjects.ComDevExecution.GetComdevExecutionById(Request.QueryString["key"].ToString());
        lblTopik.Text = dataEksekusi[2].ToString();
        lblTanggal.Text = dataEksekusi[7].ToString() + "-" + dataEksekusi[8].ToString();
        lblSpeaker.Text = dataEksekusi[5].ToString();
        empId = dataEksekusi[15].ToString();
        object[] dataApprover = BioPM.ClassObjects.EmployeeCatalog.GetEmployeeByID(Session["username"].ToString());
        lblCname.Text = dataApprover[1].ToString();
        lblEJabatan.Text = dataApprover[2].ToString();
        lblPrOrg.Text = dataApprover[3].ToString();
        object[] dataEmployee = BioPM.ClassObjects.EmployeeCatalog.GetEmployeeByID(empId);
        lblName.Text = dataEmployee[1].ToString();
        lblDivisi.Text = dataEmployee[3].ToString();
        lblJabatan.Text = dataEmployee[2].ToString();
        lblDate.Text = DateTime.Now.ToString();
        object[] dataApproval = BioPM.ClassObjects.Survey.GetApprovalInfo(Request.QueryString["key"].ToString());
        lblNamaSetuju.Text = dataApproval[1].ToString();
        lblTglSetuju.Text = dataApproval[2].ToString();
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Session["password"].ToString() == BioPM.ClassEngines.CryptographFactory.Encrypt(txtConfirmation.Text, true))
        {
            InsertReasonIntoDatabase();
            Response.Redirect("PageCompetencyParameter.aspx");
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

    <title>Evaluasi III (Perubahan Perilaku)</title>

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
                        Evaluasi III (EVALUASI ATAS PERILAKU PESERTA SETELAH PELATIHAN)
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    
                    <div class="panel-body">
                        <form id="Form1" class="form-horizontal " runat="server" >
                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Topik </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblTopik" runat="server"></asp:Label>
                            </div>
                            
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tanggal </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblTanggal" runat="server"></asp:Label>
                            </div>                            
                        </div>
                             
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Pembicara </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblSpeaker" runat="server"></asp:Label>
                            </div>                            
                        </div>

                        <hr />

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama Peserta </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblCname" runat="server"></asp:Label>
                            </div>                            
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Bagian </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblPrOrg" runat="server"></asp:Label>
                            </div>                            
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Jabatan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblEJabatan" runat="server"></asp:Label>
                            </div>                            
                        </div>

                        <hr />

                        <!-- Nomor 1 -->
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                            (1) <br />
                            Apakah objektif / tujuan pelatihan ini sudah tercapai oleh peserta tersebut?
                            </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="txtSoal1" runat="server" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Alasan: </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea1" TextMode="multiline" Columns="60" Rows="3" runat="server" />
                                </div>
                        </div>
                        
                        <!-- Nomor 2 -->
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                            (2) <br />
                            Apakah peserta pelatihan ini sudah mengaplikasikan pengetahuan yang didapat pada pekerjaannya?
                            </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="txtSoal2" runat="server" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Alasan: </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea2" TextMode="multiline" Columns="60" Rows="3" runat="server" />
                                </div>
                        </div>

                        <!-- Nomor 3 -->
                        <div class="form-group">
                            <label class="col-sm-3 control-label">
                            (3) <br />
                            Bagaimana penilaian anda atas hasil yang telah dicapai oleh karyawan tersebut?
                            </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="txtSoal3" runat="server" ReadOnly="true" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Alasan: </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea3" TextMode="multiline" Columns="60" Rows="3" runat="server" />
                                </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Komentar: </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea4" TextMode="multiline" Columns="60" Rows="3" runat="server" />
                                </div>
                        </div>
                         
                        <hr />

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tanggal Pembuatan Evaluasi </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblDate" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama Pengevaluasi </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblName" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Divisi/Bagian </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblDivisi" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Jabatan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblJabatan" runat="server"></asp:Label>
                            </div>
                        </div>

                        <hr />

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Disetujui  oleh: </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblQA" runat="server" Text="Quality Assurance"></asp:Label>                                
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tanggal </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblTglSetuju" runat="server"></asp:Label>                                
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="lblNamaSetuju" runat="server"></asp:Label>                                
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
                                        <asp:TextBox ID="txtReason" TextMode="multiline" Columns="30" Rows="3" runat="server" placeholder="Reason" class="form-control placeholder-no-fix"></asp:TextBox>
                                    </div>
                                    <div class="modal-footer">
                                        <asp:Button ID="btnClose" runat="server" data-dismiss="modal" class="btn btn-default" Text="Cancel"></asp:Button>
                                        <asp:Button ID="btnSubmit" runat="server" class="btn btn-success" Text="Confirm" OnClick="btnSave_Click"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- modal -->

                        
                            
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
