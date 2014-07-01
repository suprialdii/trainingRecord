﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormUpdateProductQualityControl.aspx.cs" Inherits="BioPM.FormUpdateProductQualityControl" %>

<!DOCTYPE html>
<script runat="server">
    BioPM.ClassObjects.Product product = new BioPM.ClassObjects.Product();
    protected void Page_Load(object sender, EventArgs e)
    {
        sessionCreator();
        if (!IsPostBack) SetDataToForm();
    }
    protected void sessionCreator()
    {
        Session["username"] = "K495";
        Session["name"] = "ALLAN PRAKOSA";
        Session["password"] = "admin1234";
        Session["role"] = "111111";
    }

    protected void SetProductQualityControlToForm()
    {
        BioPM.ClassObjects.QualityControl qualitycontrol = BioPM.ClassEngines.ObjectFactory.GetDataQualityControlByID(Request.QueryString["key"]);
        ddlQualityControlType.SelectedValue = qualitycontrol.QualityControlTypeID;
        txtQualityControlID.Text = qualitycontrol.QualityControlID;
        txtQualityControlName.Text = qualitycontrol.QualityControlName;
        txtQualityControlAlias.Text = qualitycontrol.QualityControlAlias;
        txtQCRequirement.Text = qualitycontrol.QualityControlRequirement;
        txtQCRequirementAlias.Text = qualitycontrol.QualityControlRequirementAlias;
        txtQualityControlMinValue.Text = qualitycontrol.QualityControlMinValue;
        txtQualityControlMaxValue.Text = qualitycontrol.QualityControlMaxValue;
        txtQualityControlUnit.Text = qualitycontrol.QualityControlUnit;
    }

    protected void SetQualityControlType()
    {
        ddlQualityControlType.Items.Clear();
        foreach (BioPM.ClassObjects.QualityControlType qctype in BioPM.ClassEngines.ObjectFactory.GetAllDataQualityControlType())
        {
            ddlQualityControlType.Items.Add(new ListItem(qctype.QualityControlTypeName, qctype.QualityControlTypeID));
        }
    }

    protected void SetDataToForm()
    {
        product = BioPM.ClassEngines.ObjectFactory.GetDataProductByID(Session["productid"].ToString());
        SetQualityControlType();
        SetProductQualityControlToForm();
    }
        
    protected void UpdateProductQualityControlIntoDatabase()
    {
        BioPM.ClassObjects.QualityControl qualitycontrol = BioPM.ClassObjects.QualityControlFactory.CreateQualityControl(product.ProductID, txtQualityControlID.Text, txtQualityControlName.Text, txtQualityControlAlias.Text, txtQCRequirement.Text, txtQCRequirementAlias.Text, txtQualityControlMinValue.Text, txtQualityControlMaxValue.Text, txtQualityControlUnit.Text, ddlQualityControlType.SelectedValue, "", "");
        BioPM.ClassEngines.ObjectFactory.UpdateDataQualityControl(qualitycontrol, Session["username"].ToString());
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (IsPostBack) UpdateProductQualityControlIntoDatabase();
        Response.Redirect("PageProduct.aspx");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
    }
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>


    <title>PRODUCT QC UPDATE</title>

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
                    <header class="panel-heading" style="font-weight:bold">
                        <% Response.Write(product.ProductID + " - " + product.ProductName); %> | Quality Control Update Form
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <form class="form-horizontal " runat="server" >
                         
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QUALITY CONTROL TYPE </label>
                            <div class="col-lg-3 col-md-4">
                            <asp:DropDownList ID="ddlQualityControlType" AutoPostBack="true" runat="server" class="form-control m-bot15">   
                                
                                </asp:DropDownList> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QUALITY CONTROL ID </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQualityControlID" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL ID" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QUALITY CONTROL NAME </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQualityControlName" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL NAME" ></asp:TextBox>
                            </div>
                        </div>
                            
                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QUALITY CONTROL ALIAS </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQualityControlAlias" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL ALIAS NAME" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QC REQUIREMENT </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQCRequirement" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL REQUIREMENT" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QC REQUIREMENT ALIAS </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQCRequirementAlias" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL REQUIREMENT ALIAS" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QC MIN VALUE </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQualityControlMinValue" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL MIN VALUE" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QC MAX VALUE </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQualityControlMaxValue" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL MAX VALUE" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"> QUALITY CONTROL UNIT </label>
                            <div class="col-lg-3 col-md-4">
                                <asp:TextBox ID="txtQualityControlUnit" runat="server" class="form-control m-bot15" placeholder="QUALITY CONTROL UNIT" ></asp:TextBox>
                            </div>
                        </div>

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
