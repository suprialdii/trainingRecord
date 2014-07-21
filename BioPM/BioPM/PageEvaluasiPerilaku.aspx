﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageEvaluasiPerilaku.aspx.cs" Inherits="BioPM.PageEvaluasiTiga" %>

<!DOCTYPE html>
<script runat="server">
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
        txtSoal1.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "2");
        TextArea1.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "3");
        txtSoal2.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "4");
        TextArea2.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "5");
        txtSoal3.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "6");
        TextArea3.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "7");
        TextArea4.Text = data[1].ToString();
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
                                <asp:TextBox ID="txtTopik" runat="server" class="form-control m-bot15" placeholder="Topik"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tanggal </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtTanggal" runat="server" class="form-control m-bot15" placeholder="Tanggal pelaksanaan" ></asp:TextBox>
                            </div>
                        </div>
                             
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Pembicara </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtCpyName" runat="server" class="form-control m-bot15" placeholder="Nama Pembicara" ></asp:TextBox>
                            </div>
                        </div>

                        <hr />

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama Peserta </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtPeserta" runat="server" class="form-control m-bot15" placeholder="Nama Peserta" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Bagian </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtBagian" runat="server" class="form-control m-bot15" placeholder="Bagian" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Jabatan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtJabatan" runat="server" class="form-control m-bot15" placeholder="Jabatan" ></asp:TextBox>
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
                                <asp:TextBox ID="txtTglEval" runat="server" class="form-control m-bot15" placeholder="Tanggal evaluasi" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama Pengevaluasi </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtEvaluator" runat="server" class="form-control m-bot15" placeholder="Nama pengevaluasi" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Divisi/Bagian </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtDivisiEvl" runat="server" class="form-control m-bot15" placeholder="Divisi/bagian" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Jabatan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtJabatanEvl" runat="server" class="form-control m-bot15" placeholder="Jabatan" ></asp:TextBox>
                            </div>
                        </div>

                        <hr />

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Disetujui  oleh: </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtSetuju" runat="server" class="form-control m-bot15" placeholder="Quality Assurance" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tanggal </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtTglSetuju" runat="server" class="form-control m-bot15" placeholder="Tanggal disetujui" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtNamaSetuju" runat="server" class="form-control m-bot15" placeholder="Nama penyetuju" ></asp:TextBox>
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
