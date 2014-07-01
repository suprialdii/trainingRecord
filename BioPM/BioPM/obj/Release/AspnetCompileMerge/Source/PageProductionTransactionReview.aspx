﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageProductionTransactionReview.aspx.cs" Inherits="BioPM.PageProductionTransactionReview" %>

<!DOCTYPE html>
<script runat="server">
    private const int _firstEditCellIndexBatch = 99;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null && Session["password"] == null) Response.Redirect("PageLogin.aspx");
        if (Session["coctr"].ToString() != "64100") Response.Redirect("PageUserPanel.aspx");
        
        if (!IsPostBack)
        {
            _FormulaData = null;
            this.GridViewFormula.DataSource = _FormulaData;
            this.GridViewFormula.DataBind();

            _ProductionData = null;
            this.GridViewProduction.DataSource = _ProductionData;
            this.GridViewProduction.DataBind();

            SetDataToForm();
        }

        if (this.GridViewFormula.SelectedIndex > -1)
        {
            // Call UpdateRow on every postback 
            this.GridViewFormula.UpdateRow(this.GridViewFormula.SelectedIndex, false);
        }

        if (this.GridViewProduction.SelectedIndex > -1)
        {
            // Call UpdateRow on every postback 
            this.GridViewProduction.UpdateRow(this.GridViewProduction.SelectedIndex, false);
        }
        
    }

    // Register the dynamically created client scripts 
    protected override void Render(HtmlTextWriter writer)
    {
        // The client events for GridViewBatch were created in GridViewBatch_RowDataBound 
        foreach (GridViewRow r in GridViewFormula.Rows)
        {
            if (r.RowType == DataControlRowType.DataRow)
            {
                for (int columnIndex = _firstEditCellIndexBatch; columnIndex < r.Cells.Count; columnIndex++)
                {
                    Page.ClientScript.RegisterForEventValidation(r.UniqueID + "$ctl00", columnIndex.ToString());
                }
            }
        }

        foreach (GridViewRow r in GridViewProduction.Rows)
        {
            if (r.RowType == DataControlRowType.DataRow)
            {
                for (int columnIndex = _firstEditCellIndexBatch; columnIndex < r.Cells.Count; columnIndex++)
                {
                    Page.ClientScript.RegisterForEventValidation(r.UniqueID + "$ctl00", columnIndex.ToString());
                }
            }
        }
        base.Render(writer);
    }

    protected void sessionCreator()
    {
        Session["username"] = "K495";
        Session["name"] = "ALLAN PRAKOSA";
        Session["password"] = "admin1234";
        Session["role"] = "111111";
        Session["coctr"] = "64100";
    }

    protected void GridViewQC_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            
           
            // Get the LinkButton control in the first cell 
            LinkButton _singleClickButton = (LinkButton)e.Row.Cells[0].Controls[0];
            // Get the javascript which is assigned to this LinkButton 
            string _jsSingle = ClientScript.GetPostBackClientHyperlink(_singleClickButton, "");

            // If the page contains validator controls then call  
            // Page_ClientValidate before allowing a cell to be edited 
            if (Page.Validators.Count > 0)
                _jsSingle = _jsSingle.Insert(11, "if(Page_ClientValidate())");

            // Add events to each editable cell 
            for (int columnIndex = _firstEditCellIndexBatch; columnIndex < e.Row.Cells.Count; columnIndex++)
            {
                // Add the column index as the event argument parameter 
                string js = _jsSingle.Insert(_jsSingle.Length - 2, columnIndex.ToString());
                // Add this javascript to the onclick Attribute of the cell 
                e.Row.Cells[columnIndex].Attributes["onclick"] = js;
                // Add a cursor style to the cells 
                e.Row.Cells[columnIndex].Attributes["style"] += "cursor:pointer;cursor:hand;";
            }
        }
    }

    protected void GridViewQC_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView _gridView = (GridView)sender;

        switch (e.CommandName)
        {
            case ("SingleClick"):
                // Get the row index 
                int _rowIndex = int.Parse(e.CommandArgument.ToString());
                // Parse the event argument (added in RowDataBound) to get the selected column index 
                int _columnIndex = int.Parse(Request.Form["__EVENTARGUMENT"]);
                // Set the Gridview selected index 
                _gridView.SelectedIndex = _rowIndex;
                // Bind the Gridview 
                _gridView.DataSource = _QCData;
                _gridView.DataBind();

                // Write out a history if the event 
                //this.Message.Text += "Single clicked GridView row at index " + _rowIndex.ToString()
                //    + " on column index " + _columnIndex + "<br />";

                // Get the display control for the selected cell and make it invisible 
                Control _displayControl = _gridView.Rows[_rowIndex].Cells[_columnIndex].Controls[1];
                _displayControl.Visible = false;
                // Get the edit control for the selected cell and make it visible 
                Control _editControl = _gridView.Rows[_rowIndex].Cells[_columnIndex].Controls[3];
                _editControl.Visible = true;
                // Clear the attributes from the selected cell to remove the click event 
                _gridView.Rows[_rowIndex].Cells[_columnIndex].Attributes.Clear();

                // Set focus on the selected edit control 
                ScriptManager.RegisterStartupScript(this, GetType(), "SetFocus", "document.getElementById('" + _editControl.ClientID + "').focus();", true);
                // If the edit control is a dropdownlist set the 
                // SelectedValue to the value of the display control 
                if (_editControl is DropDownList && _displayControl is Label)
                {
                    ((DropDownList)_editControl).SelectedValue = ((Label)_displayControl).Text;
                }
                // If the edit control is a textbox then select the text 
                if (_editControl is TextBox)
                {
                    ((TextBox)_editControl).Attributes.Add("onfocus", "this.select()");
                }
                // If the edit control is a checkbox set the 
                // Checked value to the value of the display control 
                if (_editControl is CheckBox && _displayControl is Label)
                {
                    ((CheckBox)_editControl).Checked = bool.Parse(((Label)_displayControl).Text);
                }

                break;
        }
    }

    /// <summary> 
    /// Update the sample data 
    /// </summary> 
    /// <param name="sender"></param> 
    /// <param name="e"></param> 
    protected void GridViewQC_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView _gridView = (GridView)sender;

        if (e.RowIndex > -1)
        {
            // Loop though the columns to find a cell in edit mode 
            for (int i = _firstEditCellIndexBatch; i < _gridView.Columns.Count; i++)
            {
                // Get the editing control for the cell 
                Control _editControl = _gridView.Rows[e.RowIndex].Cells[i].Controls[3];
                if (_editControl.Visible)
                {
                    int _dataTableColumnIndex = i - 1;

                    try
                    {
                        // Get the id of the row 
                        Label idLabel = (Label)_gridView.Rows[e.RowIndex].FindControl("NOQCTLabel");
                        string id = idLabel.Text;
                        // Get the value of the edit control and update the DataTable 
                        System.Data.DataTable dt = _QCData;
                        System.Data.DataRow dr = dt.Rows.Find(id);
                        dr.BeginEdit();
                        if (_editControl is TextBox)
                        {
                            dr[_dataTableColumnIndex] = ((TextBox)_editControl).Text;
                        }
                        else if (_editControl is DropDownList)
                        {
                            dr[_dataTableColumnIndex] = ((DropDownList)_editControl).SelectedValue;
                        }
                        else if (_editControl is CheckBox)
                        {
                            dr[_dataTableColumnIndex] = ((CheckBox)_editControl).Checked;
                        }
                        dr.EndEdit();

                        // Save the updated DataTable 
                        _QCData = dt;

                        // Clear the selected index to prevent  
                        // another update on the next postback 
                        _gridView.SelectedIndex = -1;

                        // Repopulate the GridView 
                        _gridView.DataSource = dt;
                        _gridView.DataBind();
                    }
                    catch (ArgumentException)
                    {
                        //this.Message.Text += "Error updating GridView row at index "
                        //    + e.RowIndex + "<br />";

                        // Repopulate the GridView 
                        _gridView.DataSource = _QCData;
                        _gridView.DataBind();
                    }
                }
            }
        }
    }

    /// <summary> 
    /// Property to manage data 
    /// </summary> 
    private System.Data.DataTable _QCData
    {
        get
        {
            System.Data.DataTable dt = (System.Data.DataTable)Session["QCData"];

            if (dt == null)
            {
                // Create a DataTable and save it to session 
                dt = new System.Data.DataTable();
                dt.Columns.Add(new System.Data.DataColumn("NOQCT", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("ALIAS", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("QCREQ", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("QCRST", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("QCVAL", typeof(string)));

                // Add the id column as a primary key 
                System.Data.DataColumn[] keys = new System.Data.DataColumn[1];
                keys[0] = dt.Columns["NOQCT"];
                dt.PrimaryKey = keys;

                _QCData = dt;
            }

            return dt;
        }
        set
        {
            Session["QCData"] = value;
        }
    }

    protected void GridViewFormula_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            
            // Get the LinkButton control in the first cell 
            LinkButton _singleClickButton = (LinkButton)e.Row.Cells[0].Controls[0];
            // Get the javascript which is assigned to this LinkButton 
            string _jsSingle = ClientScript.GetPostBackClientHyperlink(_singleClickButton, "");

            // If the page contains validator controls then call  
            // Page_ClientValidate before allowing a cell to be edited 
            if (Page.Validators.Count > 0)
                _jsSingle = _jsSingle.Insert(11, "if(Page_ClientValidate())");

            // Add events to each editable cell 
            for (int columnIndex = _firstEditCellIndexBatch; columnIndex < e.Row.Cells.Count; columnIndex++)
            {
                // Add the column index as the event argument parameter 
                string js = _jsSingle.Insert(_jsSingle.Length - 2, columnIndex.ToString());
                // Add this javascript to the onclick Attribute of the cell 
                e.Row.Cells[columnIndex].Attributes["onclick"] = js;
                // Add a cursor style to the cells 
                e.Row.Cells[columnIndex].Attributes["style"] += "cursor:pointer;cursor:hand;";
            }
        }
    }

    protected void GridViewFormula_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView _gridView = (GridView)sender;

        switch (e.CommandName)
        {
            case ("SingleClick"):
                // Get the row index 
                int _rowIndex = int.Parse(e.CommandArgument.ToString());
                // Parse the event argument (added in RowDataBound) to get the selected column index 
                int _columnIndex = int.Parse(Request.Form["__EVENTARGUMENT"]);
                // Set the Gridview selected index 
                _gridView.SelectedIndex = _rowIndex;
                // Bind the Gridview 
                _gridView.DataSource = _FormulaData;
                _gridView.DataBind();

                // Write out a history if the event 
                //this.Message.Text += "Single clicked GridView row at index " + _rowIndex.ToString()
                //    + " on column index " + _columnIndex + "<br />";

                // Get the display control for the selected cell and make it invisible 
                Control _displayControl = _gridView.Rows[_rowIndex].Cells[_columnIndex].Controls[1];
                _displayControl.Visible = false;
                // Get the edit control for the selected cell and make it visible 
                Control _editControl = _gridView.Rows[_rowIndex].Cells[_columnIndex].Controls[3];
                _editControl.Visible = true;
                // Clear the attributes from the selected cell to remove the click event 
                _gridView.Rows[_rowIndex].Cells[_columnIndex].Attributes.Clear();

                // Set focus on the selected edit control 
                ScriptManager.RegisterStartupScript(this, GetType(), "SetFocus", "document.getElementById('" + _editControl.ClientID + "').focus();", true);
                // If the edit control is a dropdownlist set the 
                // SelectedValue to the value of the display control 
                if (_editControl is DropDownList && _displayControl is Label)
                {
                    ((DropDownList)_editControl).SelectedValue = ((Label)_displayControl).Text;
                }
                // If the edit control is a textbox then select the text 
                if (_editControl is TextBox)
                {
                    ((TextBox)_editControl).Attributes.Add("onfocus", "this.select()");
                }
                // If the edit control is a checkbox set the 
                // Checked value to the value of the display control 
                if (_editControl is CheckBox && _displayControl is Label)
                {
                    ((CheckBox)_editControl).Checked = bool.Parse(((Label)_displayControl).Text);
                }

                break;
        }
    }

    /// <summary> 
    /// Update the sample data 
    /// </summary> 
    /// <param name="sender"></param> 
    /// <param name="e"></param> 
    protected void GridViewFormula_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView _gridView = (GridView)sender;

        if (e.RowIndex > -1)
        {
            // Loop though the columns to find a cell in edit mode 
            for (int i = _firstEditCellIndexBatch; i < _gridView.Columns.Count; i++)
            {
                // Get the editing control for the cell 
                Control _editControl = _gridView.Rows[e.RowIndex].Cells[i].Controls[3];
                if (_editControl.Visible)
                {
                    int _dataTableColumnIndex = i - 1;

                    try
                    {
                        // Get the id of the row 
                        Label idLabel = (Label)_gridView.Rows[e.RowIndex].FindControl("NOFRMLabel");
                        string id = idLabel.Text;
                        // Get the value of the edit control and update the DataTable 
                        System.Data.DataTable dt = _FormulaData;
                        System.Data.DataRow dr = dt.Rows.Find(id);
                        dr.BeginEdit();
                        if (_editControl is TextBox)
                        {
                            dr[_dataTableColumnIndex] = ((TextBox)_editControl).Text;
                        }
                        else if (_editControl is DropDownList)
                        {
                            dr[_dataTableColumnIndex] = ((DropDownList)_editControl).SelectedValue;
                        }
                        else if (_editControl is CheckBox)
                        {
                            dr[_dataTableColumnIndex] = ((CheckBox)_editControl).Checked;
                        }
                        dr.EndEdit();

                        // Save the updated DataTable 
                        _FormulaData = dt;

                        // Clear the selected index to prevent  
                        // another update on the next postback 
                        _gridView.SelectedIndex = -1;

                        // Repopulate the GridView 
                        _gridView.DataSource = dt;
                        _gridView.DataBind();
                    }
                    catch (ArgumentException)
                    {

                        // Repopulate the GridView 
                        _gridView.DataSource = _FormulaData;
                        _gridView.DataBind();
                    }
                }
            }
        }
    }

    /// <summary> 
    /// Property to manage data 
    /// </summary> 
    private System.Data.DataTable _FormulaData
    {
        get
        {
            System.Data.DataTable dt = (System.Data.DataTable)Session["FormulaData"];

            if (dt == null)
            {
                // Create a DataTable and save it to session 
                dt = new System.Data.DataTable();
                dt.Columns.Add(new System.Data.DataColumn("NOFRM", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("ITMID", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("ITMNM", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("NOQTY", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("NOQPR", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("UNTID", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("FRVAL", typeof(string)));

                // Add the id column as a primary key 
                System.Data.DataColumn[] keys = new System.Data.DataColumn[1];
                keys[0] = dt.Columns["NOFRM"];
                dt.PrimaryKey = keys;

                _FormulaData = dt;
            }

            return dt;
        }
        set
        {
            Session["FormulaData"] = value;
        }
    }

    protected void GridViewProduction_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {


            // Get the LinkButton control in the first cell 
            LinkButton _singleClickButton = (LinkButton)e.Row.Cells[0].Controls[0];
            // Get the javascript which is assigned to this LinkButton 
            string _jsSingle = ClientScript.GetPostBackClientHyperlink(_singleClickButton, "");

            // If the page contains validator controls then call  
            // Page_ClientValidate before allowing a cell to be edited 
            if (Page.Validators.Count > 0)
                _jsSingle = _jsSingle.Insert(11, "if(Page_ClientValidate())");

            // Add events to each editable cell 
            for (int columnIndex = _firstEditCellIndexBatch; columnIndex < e.Row.Cells.Count; columnIndex++)
            {
                // Add the column index as the event argument parameter 
                string js = _jsSingle.Insert(_jsSingle.Length - 2, columnIndex.ToString());
                // Add this javascript to the onclick Attribute of the cell 
                e.Row.Cells[columnIndex].Attributes["onclick"] = js;
                // Add a cursor style to the cells 
                e.Row.Cells[columnIndex].Attributes["style"] += "cursor:pointer;cursor:hand;";
            }
        }
    }

    protected void GridViewProduction_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridView _gridView = (GridView)sender;

        switch (e.CommandName)
        {
            case ("SingleClick"):
                // Get the row index 
                int _rowIndex = int.Parse(e.CommandArgument.ToString());
                // Parse the event argument (added in RowDataBound) to get the selected column index 
                int _columnIndex = int.Parse(Request.Form["__EVENTARGUMENT"]);
                // Set the Gridview selected index 
                _gridView.SelectedIndex = _rowIndex;
                // Bind the Gridview 
                _gridView.DataSource = _ProductionData;
                _gridView.DataBind();

                // Write out a history if the event 
                //this.Message.Text += "Single clicked GridView row at index " + _rowIndex.ToString()
                //    + " on column index " + _columnIndex + "<br />";

                // Get the display control for the selected cell and make it invisible 
                Control _displayControl = _gridView.Rows[_rowIndex].Cells[_columnIndex].Controls[1];
                _displayControl.Visible = false;
                // Get the edit control for the selected cell and make it visible 
                Control _editControl = _gridView.Rows[_rowIndex].Cells[_columnIndex].Controls[3];
                _editControl.Visible = true;
                // Clear the attributes from the selected cell to remove the click event 
                _gridView.Rows[_rowIndex].Cells[_columnIndex].Attributes.Clear();

                // Set focus on the selected edit control 
                ScriptManager.RegisterStartupScript(this, GetType(), "SetFocus", "document.getElementById('" + _editControl.ClientID + "').focus();", true);
                // If the edit control is a dropdownlist set the 
                // SelectedValue to the value of the display control 
                if (_editControl is DropDownList && _displayControl is Label)
                {
                    ((DropDownList)_editControl).SelectedValue = ((Label)_displayControl).Text;
                }
                // If the edit control is a textbox then select the text 
                if (_editControl is TextBox)
                {
                    ((TextBox)_editControl).Attributes.Add("onfocus", "this.select()");
                }
                // If the edit control is a checkbox set the 
                // Checked value to the value of the display control 
                if (_editControl is CheckBox && _displayControl is Label)
                {
                    ((CheckBox)_editControl).Checked = bool.Parse(((Label)_displayControl).Text);
                }

                break;
        }
    }

    /// <summary> 
    /// Update the sample data 
    /// </summary> 
    /// <param name="sender"></param> 
    /// <param name="e"></param> 
    protected void GridViewProduction_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView _gridView = (GridView)sender;

        if (e.RowIndex > -1)
        {
            // Loop though the columns to find a cell in edit mode 
            for (int i = _firstEditCellIndexBatch; i < _gridView.Columns.Count; i++)
            {
                // Get the editing control for the cell 
                Control _editControl = _gridView.Rows[e.RowIndex].Cells[i].Controls[3];
                if (_editControl.Visible)
                {
                    int _dataTableColumnIndex = i - 1;

                    try
                    {
                        // Get the id of the row 
                        Label idLabel = (Label)_gridView.Rows[e.RowIndex].FindControl("NOPRDLabel");
                        string id = idLabel.Text;
                        // Get the value of the edit control and update the DataTable 
                        System.Data.DataTable dt = _ProductionData;
                        System.Data.DataRow dr = dt.Rows.Find(id);
                        dr.BeginEdit();
                        if (_editControl is TextBox)
                        {
                            dr[_dataTableColumnIndex] = ((TextBox)_editControl).Text;
                        }
                        else if (_editControl is DropDownList)
                        {
                            dr[_dataTableColumnIndex] = ((DropDownList)_editControl).SelectedValue;
                        }
                        else if (_editControl is CheckBox)
                        {
                            dr[_dataTableColumnIndex] = ((CheckBox)_editControl).Checked;
                        }
                        dr.EndEdit();

                        // Save the updated DataTable 
                        _ProductionData = dt;

                        // Clear the selected index to prevent  
                        // another update on the next postback 
                        _gridView.SelectedIndex = -1;

                        // Repopulate the GridView 
                        _gridView.DataSource = dt;
                        _gridView.DataBind();
                    }
                    catch (ArgumentException)
                    {
                        //this.Message.Text += "Error updating GridView row at index "
                        //    + e.RowIndex + "<br />";

                        // Repopulate the GridView 
                        _gridView.DataSource = _ProductionData;
                        _gridView.DataBind();
                    }
                }
            }
        }
    }

    /// <summary> 
    /// Property to manage data 
    /// </summary> 
    private System.Data.DataTable _ProductionData
    {
        get
        {
            System.Data.DataTable dt = (System.Data.DataTable)Session["ProductionData"];

            if (dt == null)
            {
                // Create a DataTable and save it to session 
                dt = new System.Data.DataTable();
                dt.Columns.Add(new System.Data.DataColumn("NOPRD", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("BATCH", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("BEGDA", typeof(string)));
                dt.Columns.Add(new System.Data.DataColumn("PRVAL", typeof(string)));

                // Add the id column as a primary key 
                System.Data.DataColumn[] keys = new System.Data.DataColumn[1];
                keys[0] = dt.Columns["NOPRD"];
                dt.PrimaryKey = keys;

                _ProductionData = dt;
            }

            return dt;
        }
        set
        {
            Session["ProductionData"] = value;
        }
    }

    protected void SetLabelVisible()
    {
        lblProductName.Visible = true;
        lblProductStatus.Visible = true;
        lblQuantity.Visible = true;
        lblStorage.Visible = true;
        lblPackage.Visible = true;
        lblProductionDate.Visible = true;
        lblExpiredDate.Visible = true;
        txtProductName.Visible = true;
        txtProductStatus.Visible = true;
        txtQuantity.Visible = true;
        txtPackage.Visible = true;
        txtStorage.Visible = true;
        txtProductionDate.Visible = true;
        txtExpiredDate.Visible = true;
        btnCancel.Visible = true;
        txtUnit.Visible = true;
    }

    protected void SetLabelInvisible()
    {
        lblProductName.Visible = false;
        lblProductStatus.Visible = false;
        lblQuantity.Visible = false;
        lblStorage.Visible = false;
        lblPackage.Visible = false;
        lblProductionDate.Visible = false;
        lblExpiredDate.Visible = false;
        txtProductName.Visible = false;
        txtProductStatus.Visible = false;
        txtQuantity.Visible = false;
        txtPackage.Visible = false;
        txtStorage.Visible = false;
        txtProductionDate.Visible = false;
        txtExpiredDate.Visible = false;
        btnCancel.Visible = false;
        txtUnit.Visible = false;
    }

    protected void GenerateDataProduction(string BATCH)
    {
        int index = 1;
        _ProductionData = null;
        foreach (object[] data in BioPM.ClassObjects.ProductionCatalog.GetProductProductionByBatch(BATCH))
        {
            System.Data.DataTable dt = _ProductionData;
            int newid = dt.Rows.Count + 1;
            dt.Rows.Add(new object[] { index.ToString(), data[2].ToString(), BioPM.ClassEngines.DateFormatFactory.GetDateFormat(data[0].ToString()), BioPM.ClassObjects.ProductionCatalog.ValidateProductionFlowByStatus(BATCH, "REVIEWED") == 0 ? "false" : "true" });
            index++;
            _ProductionData = dt;
        }
        this.GridViewProduction.DataSource = _ProductionData;
        this.GridViewProduction.DataBind();
    }

    protected void GenerateDataFormula(string BATCH)
    {
        int index = 1;
        _FormulaData = null;
        foreach (object[] data in BioPM.ClassObjects.ProductionCatalog.GetProductionFormulaByBatch(BATCH))
        {
            System.Data.DataTable dt = _FormulaData;
            int newid = dt.Rows.Count + 1;
            dt.Rows.Add(new object[] { index.ToString(), data[0].ToString(), data[1].ToString(), Convert.ToDecimal(data[2]).ToString("F"), data[3].ToString(), data[4].ToString(), data[5].ToString() == "1" ? "true" : "false" });
            index++;
            _FormulaData = dt;
        }
        this.GridViewFormula.DataSource = _FormulaData;
        this.GridViewFormula.DataBind();
    }

    protected void SetDataToForm()
    {
        string BATCH = Request.QueryString["key"];

        if (BioPM.ClassObjects.ProductionCatalog.ValidateProductBatch(BATCH) >= 1)
        {
            object[] values = BioPM.ClassObjects.ProductionCatalog.GetProductBatchByBatch(BATCH);
            txtBatch.Text = values[1].ToString();
            Session["PRDID"] = values[2].ToString();
            txtProductName.Text = values[3].ToString();
            txtProductionDate.Text = BioPM.ClassEngines.DateFormatFactory.GetDateFormat(values[0].ToString());
            txtProductStatus.Text = BioPM.ClassObjects.ProductionCatalog.GetProductionStatusByBatch(BATCH, "2") == null ? "QUARANTINE" : BioPM.ClassObjects.ProductionCatalog.GetProductionStatusByBatch(BATCH, "2")[2].ToString().ToUpper();
            GenerateDataProduction(BATCH);
            GenerateDataFormula(BATCH);
        }

        if (BioPM.ClassObjects.ProductionCatalog.ValidateProductionBatch(BATCH) >= 1)
        {
            object[] values = BioPM.ClassObjects.ProductionCatalog.GetProductionByBatch(BATCH);
            txtQuantity.Text = Convert.ToDecimal(values[6].ToString()).ToString("F");
            txtUnit.Text = values[7].ToString();
            txtPackage.Text = values[4].ToString();
            txtStorage.Text = values[5].ToString();
            txtExpiredDate.Text = BioPM.ClassEngines.DateFormatFactory.GetDateFormat(values[1].ToString());
        }

        SetLabelVisible();
    }

    protected void UpdateDataProductionFormulaOnDatabase()
    {
        bool isReviewed = true;
        
        for (int i = 0; i < _FormulaData.Rows.Count; i++)
        {
            BioPM.ClassObjects.ProductionCatalog.UpdateProductionFormulaReview(txtBatch.Text, _FormulaData.Rows[i]["ITMID"].ToString(), ((CheckBox)GridViewFormula.Rows[i].FindControl("FRVALReview")).Checked == true ? "1" : "0", Session["username"].ToString());
            if ( ((CheckBox)GridViewFormula.Rows[i].FindControl("FRVALReview")).Checked == false)
            {
                isReviewed = false;
            }
        }

        if (isReviewed) InsertProductionTransactionFlow("REVIEW");
        else InsertProductionTransactionFlow("CORECTION");
        
    }

    protected void InsertProductionTransactionFlow(string FLWST)
    {
        BioPM.ClassObjects.ProductionCatalog.InsertProductionTransactionFlow(txtBatch.Text, "1", FLWST, Session["username"].ToString().ToString(), txtNote.Text, Session["username"].ToString());
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Session["password"].ToString() == BioPM.ClassEngines.CryptographFactory.Encrypt(txtConfirmation.Text, true))
        {
            UpdateDataProductionFormulaOnDatabase();
            Response.Redirect("PageBatchProductProductionReview.aspx");
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "YOUR PASSWORD IS INCORRECT" + "');", true);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("PageUserPanel.aspx");
    }
    
</script>

<html lang="en">
<head>
    <% Response.Write(BioPM.ClassScripts.BasicScripts.GetMetaScript()); %>

    <title>Production Review</title>

    <% Response.Write(BioPM.ClassScripts.StyleScripts.GetCoreStyle()); %>
    <% Response.Write(BioPM.ClassScripts.StyleScripts.GetGritterStyle()); %>
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
                        Production Transaction Review
                          <span class="tools pull-right">
                            <a class="fa fa-chevron-down" href="javascript:;"></a>
                            <a class="fa fa-times" href="javascript:;"></a>
                         </span>
                    </header>
                    <div class="panel-body">
                        <form class="form-horizontal " runat="server" >
                       
                        <div class="form-group">
                            <asp:Label  runat="server" class="col-sm-3 control-label"> PRODUCT BATCH </asp:Label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtBatch" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" ID="lblProductStatus" Visible="false" class="col-sm-3 control-label"> STATUS </asp:Label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtProductStatus" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" ID="lblProductName" Visible="false" class="col-sm-3 control-label"> PRODUCT NAME </asp:Label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtProductName" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" ID="lblProductionDate" Visible="false" class="col-sm-3 control-label"> PRODUCTION DATE </asp:Label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtProductionDate" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <asp:Label runat="server" ID="lblQuantity" Visible="false" class="col-sm-3 control-label"> QUANTITY </asp:Label>
                            <div class="col-lg-2 col-md-3">
                                <asp:Label ID="txtQuantity" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                            <div class="col-lg-1 col-md-1">
                                <asp:Label ID="txtUnit" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" ID="lblPackage" Visible="false" class="col-sm-3 control-label"> PRESENTATION </asp:Label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtPackage" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" ID="lblStorage" Visible="false" class="col-sm-3 control-label"> STORAGE </asp:Label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtStorage" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Label runat="server" ID="lblExpiredDate" Visible="false" class="col-sm-3 control-label"> EXPIRED DATE </asp:Label>
                            <div class="col-lg-3 col-md-4">
                                <asp:Label ID="txtExpiredDate" Visible="false" runat="server" class="form-control m-bot15"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="panel-group m-bot20" id="accordion">
                        
                            <div class="panel">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                            Production Data
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseOne" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <label class="col-sm-3 control-label"> </label>
                                        <div class="adv-table col-lg-6 col-md-4">
                                        <div class="clearfix">
                                            
                                        </div>
                                        <asp:GridView ID="GridViewProduction" runat="server" BackColor="White" BorderColor="#e9ecef" AutoGenerateColumns="False"  
                                                BorderStyle="Solid" BorderWidth="2px" CellPadding="4" ForeColor="Black" GridLines="Both"
                                                OnRowDataBound="GridViewProduction_RowDataBound" OnRowCommand="GridViewProduction_RowCommand" OnRowUpdating="GridViewProduction_RowUpdating" ShowFooter="True"> 
                                                <Columns>                 
                                                    <asp:ButtonField Text="SingleClick" CommandName="SingleClick" Visible="false"/> 
                                                    <asp:TemplateField HeaderText="No."> 
                                                        <ItemTemplate>
                                                            <asp:Label ID="NOPRDLabel" runat="server" Text='<%# Eval("NOPRD") %>'></asp:Label>    
                                                        </ItemTemplate>                
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Batch"> 
                                                        <ItemTemplate>
                                                            <asp:Label ID="BATCHLabel" runat="server" Text='<%# Eval("BATCH") %>'></asp:Label>    
                                                        </ItemTemplate>                
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Production Date"> 
                                                        <ItemTemplate> 
                                                            <asp:Label ID="BEGDALabel" runat="server" Text='<%# Eval("BEGDA") %>'></asp:Label>      
                                                        </ItemTemplate>
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Review"> 
                                                        <ItemTemplate> 
                                                            <asp:CheckBox ID="PRVALReview" runat="server" Checked='<%# Convert.ToBoolean(Eval("PRVAL")) %>' class="switch-small"></asp:CheckBox>      
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns> 
                                            </asp:GridView>     
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
                                            Formula
                                        </a>
                                    </h4>
                                </div>
                                <div id="collapseThree" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <div class="col-sm-3">
                                        
                                        </div>
                                        <div class="adv-table col-lg-6 col-md-4">
                                        <div class="clearfix">
                                            
                                        </div>
                                        <asp:GridView ID="GridViewFormula" runat="server" BackColor="White" BorderColor="#e9ecef" AutoGenerateColumns="False"  
                                                BorderStyle="Solid" BorderWidth="2px" CellPadding="4" ForeColor="Black" GridLines="Both"
                                                OnRowDataBound="GridViewFormula_RowDataBound" OnRowCommand="GridViewFormula_RowCommand" OnRowUpdating="GridViewFormula_RowUpdating" ShowFooter="True"> 
                                                <Columns>                 
                                                    <asp:ButtonField Text="SingleClick" CommandName="SingleClick" Visible="false"/> 
                                                    <asp:TemplateField HeaderText="No."> 
                                                        <ItemTemplate>
                                                            <asp:Label ID="NOFRMLabel" runat="server" Text='<%# Eval("NOFRM") %>'></asp:Label>    
                                                        </ItemTemplate>                
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Item ID"> 
                                                        <ItemTemplate>
                                                            <asp:Label ID="ITMIDLabel" runat="server" Text='<%# Eval("ITMID") %>'></asp:Label>    
                                                        </ItemTemplate>                
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Item Name"> 
                                                        <ItemTemplate> 
                                                            <asp:Label ID="ITMNMLabel" runat="server" Text='<%# Eval("ITMNM") %>'></asp:Label>      
                                                        </ItemTemplate>
                                                    </asp:TemplateField> 
                                                    <asp:TemplateField HeaderText="Quantity Reference"> 
                                                        <ItemTemplate> 
                                                            <asp:Label ID="NOQTYLabel" runat="server" Text='<%# Eval("NOQTY") %>'></asp:Label>      
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Quantity Production"> 
                                                        <ItemTemplate> 
                                                            <asp:TextBox ID="NOQPRLabel" runat="server" Text='<%# Eval("NOQPR") %>'></asp:TextBox>      
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Unit"> 
                                                        <ItemTemplate> 
                                                            <asp:Label ID="UNTIDLabel" runat="server" Text='<%# Eval("UNTID") %>'></asp:Label>      
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Review"> 
                                                        <ItemTemplate> 
                                                            <asp:CheckBox ID="FRVALReview" runat="server" Checked='<%# Convert.ToBoolean(Eval("FRVAL")) %>' class="switch-small"></asp:CheckBox>      
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns> 
                                            </asp:GridView>     
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Modal -->
                        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h4 class="modal-title">Reviewer Confirmation</h4>
                                    </div>
                                    <div class="modal-body">
                                        <p>You Are Logged In As <% Response.Write(Session["name"].ToString()); %></p>
                                        <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" placeholder="Your Note If Any" class="form-control placeholder-no-fix"></asp:TextBox>
                                        <p></p>
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
                                <asp:LinkButton data-toggle="modal" class="btn btn-round btn-primary" ID="btnAction" runat="server" Text="Save" href="#myModal"/>
                                <asp:Button class="btn btn-round btn-primary" ID="btnCancel" Visible="false" runat="server" Text="Cancel" OnClick="btnCancel_Click"/>
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

<% Response.Write(BioPM.ClassScripts.JS.GetGritterScript()); %>
</body>
</html>
