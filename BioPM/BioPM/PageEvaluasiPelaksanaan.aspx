﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageEvaluasiPelaksanaan.aspx.cs" Inherits="BioPM.PageEvaluasiPelaksanaan" %>

<!DOCTYPE html>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (!IsPostBack)
            SetDataToPage();
    }

    protected void SetDataToPage()
    {
        string excid = Request.QueryString["key"].ToString();
        object[] data = null;
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "13");
        txt11.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "14");
        txt12.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "15");
        txt13.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "16");
        txt14.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "17");
        txt21.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "18");
        txt22.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "19");
        txt23.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "20");
        txt24.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "21");
        txt25.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "22");
        txt31.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "23");
        txt32.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "24");
        txt41.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "25");
        txt42.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "26");
        txt43.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "27");
        txt51.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "28");
        txt52.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "29");
        TextArea1.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "30");
        TextArea2.Text = data[1].ToString();
        data = BioPM.ClassObjects.Survey.GetAnswerById(excid, "31");
        TextArea3.Text = data[1].ToString();
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>Evaluasi Pelaksanaan Pelatihan</title>

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
                        Evaluasi Pelaksanaan Pelatihan
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    
                    <div class="panel-body">
                        <form id="Form1" class="form-horizontal " runat="server" >
                        
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Topik Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtTopik" runat="server" class="form-control m-bot15" placeholder="Topik Pelatihan"></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Nama Peserta Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtNama" runat="server" class="form-control m-bot15" placeholder="Nama Peserta Pelatihan" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Jabatan Peserta Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtJabatan" runat="server" class="form-control m-bot15" placeholder="Jabatan Peserta Pelatihan" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tanggal Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtTanggal" runat="server" class="form-control m-bot15" placeholder="Tanggal Pelatihan" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Tempat Pelaksanaan Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtTempat" runat="server" class="form-control m-bot15" placeholder="Tempat Pelaksanaan Pelatihan " ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Materi Pelatihan </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextBox1" TextMode="multiline" Columns="60" Rows="5" runat="server" placeholder="Pisahkan dengan tanda koma (,)" />
                            </div>
                        </div>

                        <hr />

                        <label>SKALA NILAI</label>
                        <table class="table table-striped table-hover table-bordered" id="Table1" >
                            <tr>
                                <th>1</th>
                                <th>2</th>
                                <th>3</th>
                                <th>4</th>
                                <th>5</th>
                            </tr>
                            <tr>
                                <td>Tidak puas</td>
                                <td>Kurang puas</td>
                                <td>Cukup puas</td>
                                <td>Puas</td>
                                <td>Sangat puas</td>
                            </tr>
                        </table>

                        <table class="table table-striped table-hover table-bordered" id="Table2" >
                            <tr>
                                <td>
                                    <h3>I. Tanggapan atas materi pelatihan</h3>

                                    <!-- Nomor 1.1 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (1) <br />
                                        Kejelasan bahasa materi pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt11" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 1.2 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (2) <br />
                                        Sistematika penulisan materi</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt12" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 1.3 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (3) <br />
                                        Kemudahan dalam memahami materi pelatihan secara keseluruhan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt13" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 1.4 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (4) <br />
                                        Kualitas materi pelatihan & kedalaman materi pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt14" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <h3>II. Tanggapan atas instruktur</h3>
                                    <!-- Nomor 2.1 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (1) <br />
                                        Pengetahuan teoritis atas materi pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt21" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 2.2 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (2) <br />
                                        Pengalaman yang mendukung atas materi pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt22" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 2.3 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (3) <br />
                                        Kemampuan menguasai audiens (peserta pelatihan)</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt23" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 2.4 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (4) <br />
                                        Kemampuan menjawab pertanyaan dari peserta pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt24" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 2.5 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (5) <br />
                                        Cara penyampaian materi pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt25" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h3>III. Tanggapan atas fasilitas pelatihan</h3>

                                    <!-- Nomor 3.1 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (1) <br />
                                        Tempat/lokasi pelatihan/makanan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt31" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 3.2 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (2) <br />
                                        Media pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt32" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                </td>
                                <td>
                                    <h3>IV. Waktu pelaksanaan pelatihan</h3>
                                    <!-- Nomor 4.1 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (1) <br />
                                        Tanggal/hari pelaksanaan pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt41" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 4.2 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (2) <br />
                                        Total waktu pelaksanaan pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt42" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 4.3 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (3) <br />
                                        Pengalokasian waktu/susunan acara pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt43" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <h3>V. Tanggapan atas program pelatihan</h3>
                                    <!-- Nomor 4.1 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (1) <br />
                                        Kesesuaian isi program terhadap sasaran pelatihan</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt51" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>

                                    <!-- Nomor 4.2 -->
                                    <div class="form-group">
                                        <h4><label class="col-sm-3 control-label">
                                        (2) <br />
                                        Apakah program pelatihan ini memenuhi harapan?</label></h4>
                                        <div class="col-lg-3 col-md-4">
                                            <asp:TextBox id="txt52" runat="server" ReadOnly="true" />
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <h3>VI. Rencana aplikasi hasil pelatihan dalam peningkatan/perbaikan
                                        kualitas pekerjaan saat ini.
                                    </h3>
                                    <div class="col-lg-3 col-md-4">
                                        <asp:TextBox id="TextArea1" TextMode="multiline" Columns="100" Rows="5" runat="server" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <h3>VII. Syarat-syarat/kondisi-kondisi yang harus dipenuhi agar hasil
                                        pelatihan dapat diaplikasikan
                                    </h3>
                                    <div class="col-lg-3 col-md-4">
                                        <asp:TextBox id="TextArea2" TextMode="multiline" Columns="100" Rows="5" runat="server" />
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <hr />

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> Saran Anda: </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox id="TextArea3" TextMode="multiline" Columns="100" Rows="5" runat="server" />
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
