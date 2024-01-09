report 50114 "Stock Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Trial Balance Rep.rdl';
    //SHALINA STOCK REPORT FORMAT

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.");
            RequestFilterFields = "Item No.", "Location Code";
            column(GL_No; "Item Ledger Entry"."Item No.")
            {
            }
            column(GL_PostingDate; "Item Ledger Entry"."Posting Date")
            {
            }
            column(ItemDescription; ItemDescription) { }
            column(GL_Amt; "Item Ledger Entry"."Remaining Quantity")//Amount
            {
            }
            column(Gl_Location; "Item Ledger Entry"."Location Code")
            {
            }
            column(Gl_AccName; '')//"G/L Account Name"
            {
            }
            // column(gl_name; GLName)
            // {
            // }
            // column(GL_AccType; GlAccType)
            // {
            // }
            // column(GL_incomeBal; GlincomeBal)
            // {
            // }
            column(Comp_pic; CompInfo.Picture)
            {
            }
            column(Expiration_Date; "Expiration Date") { }
            column(Lot_No_; "Lot No.") { }
            column(UnitofMeasure; UnitofMeasure) { }

            trigger OnAfterGetRecord()
            begin
                /*IF "Item Ledger Entry"."Location Code"='' then
                  CurrReport.SKIP;*/
                IF "Item Ledger Entry"."Location Code" = '' THEN
                    "Item Ledger Entry"."Location Code" := 'Blank';

                item.Reset();
                item.SetRange("No.", "Item Ledger Entry"."Item No.");
                if item.FindFirst() then begin
                    ItemDescription := item.Description;


                end;

                Ctn.Reset();
                Ctn.SetRange("Item No.", item."No.");
                if Ctn.FindFirst() then begin
                    UnitofMeasure := Ctn."Qty. per Unit of Measure"
                end;
                // RecGlAcc.RESET();
                // RecGlAcc.SETRANGE("No.", "Item Ledger Entry"."Item No.");
                // IF RecGlAcc.FINDFIRST THEN BEGIN
                //     GLName := RecGlAcc.Name;
                //     GlAccType := RecGlAcc."Account Type";
                //     GlincomeBal := RecGlAcc."Income/Balance";
                // END;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET();
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        RecGlAcc: Record "15";
        GLName: Text;
        GlAccType: Option Posting,Heading,Total,"Begin-Total","End-Total";
        GlincomeBal: Option "Income Statement","Balance Sheet";
        CompInfo: Record "79";
        ItemDescription: text[200];
        item: Record Item;
        Ctn: Record "Item Unit of Measure";
        UnitofMeasure: Decimal;

}

