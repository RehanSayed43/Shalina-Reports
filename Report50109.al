report 50109 SalesInv
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './salesss.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Posting_Date; "Posting Date") { }
            column(Nature_of_Supply; "Nature of Supply") { }
            column(CustomerGstno; CustomerGstno) { }
            column(Bill_to_City; "Bill-to City") { }
            column(Location_State_Code; "Location State Code") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(companyName; company.Name) { }
            column(companyAddress; company.Address) { }
            column(companygstno; company."GST Registration No.") { }
            column(companyCity; company.City) { }
            column(companyPanno; company."P.A.N. No.") { }
            column(companyBankaccno; company."Bank Account No.") { }
            column(companyBankname; company."Bank Name") { }
            column(companyIFSCCODE; company."Bank Branch No.") { }
            column(companySWIFTCODE; company."SWIFT Code") { }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No." = field("No.");
                column(No_s; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Per; "Unit of Measure Code") { }
                column(HSN_SAC_Code; "HSN/SAC Code") { }
                column(Unit_Cost; "Unit Cost") { }
                column(Line_Amount; "Line Amount") { }
                column(IGST; IGST) { }
                column(SGST; SGST) { }
                column(CGST; CGST) { }
                column(CGSTRATE; CGSTRATE) { }
                column(SGSTRATE; SGSTRATE) { }
                column(IGSTRATE; IGSTRATE) { }
                column(GrandTotal; GrandTotal) { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Customer.Reset();
                    Customer.SetRange("No.", "Sell-to Customer No.");
                    if Customer.Find('-')
                    then begin
                        CustomerGstno := Customer."GST Registration No.";

                    end;
                    Saleslines.Reset();
                    Saleslines.SetRange("Document No.", "Sales Header"."No.");
                    Saleslines.SetRange("Document Type", "Sales Header"."Document Type");
                    Saleslines.SetFilter("GST Group Code", '<>%1', '');

                    if Saleslines.FindSet()
                    then
                        repeat
                            TaxRecordId := Saleslines.RecordId;

                            TaxtransactionValue.SetRange("Tax Record ID", TaxRecordId);
                            TaxtransactionValue.SetRange("Value Type", TaxtransactionValue."Value Type"::COMPONENT);
                            TaxtransactionValue.SetRange("Visible on Interface", true);
                            TaxtransactionValue.SetFilter("Tax Type", '=%1', 'GST');
                            TaxtransactionValue.SetFilter(Percent, '<>%1', 0);
                            TaxtransactionValue.SetFilter("Value ID", '%1|%2', 6, 2);
                            if TaxtransactionValue.FindSet() then begin
                                CGSTRATE := TaxtransactionValue.Percent;
                                SGSTRATE := TaxtransactionValue.Percent;
                                CGST := TaxtransactionValue.Amount;
                                SGST := TaxtransactionValue.Amount;

                                TotalCGST += CGST;
                                TotalSGST += SGST;
                            end else begin
                                TaxtransactionValue.SetRange("Tax Record ID", TaxRecordId);
                                TaxtransactionValue.SetRange("Value Type", TaxtransactionValue."Value Type"::COMPONENT);
                                TaxtransactionValue.SetRange("Visible on Interface", true);
                                TaxtransactionValue.SetFilter("Tax Type", '=%1', 'GST');
                                TaxtransactionValue.SetFilter(Percent, '<>%1', 0);
                                TaxtransactionValue.SetFilter("Value ID", '%1', 3);
                                if TaxtransactionValue.FindSet() then
                                    IGSTRATE := TaxtransactionValue.Percent;
                                IGST := TaxtransactionValue.Amount;

                                TotalIGST += IGST;
                            end;
                            Total := Total + Saleslines.Amount;
                            GrandTotal := Total + CGST + SGST + IGST;
                        until Saleslines.Next() = 0;

                    PostedVoucher.InitTextVariable();
                    "Sales Header".CalcFields(Amount);
                    PostedVoucher.FormatNoText(AmountinWords, Round(GrandTotal), "Sales Header"."Currency Code");
                    AmntinWrds := AmountinWords[1] + AmountinWords[2];




                end;







            }
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        company.get();
    end;

    var
        myInt: Integer;
        Customer: Record Customer;
        TaxRecordId: RecordId;
        Saleslines: Record "Sales Line";

        company: Record "Company Information";
        GrandTotal: Decimal;
        CGST: Decimal;
        SGST: Decimal;
        IGST: Decimal;
        Total: Decimal;
        CGSTRATE: Decimal;
        SGSTRATE: Decimal;
        IGSTRATE: Decimal;
        TotalCGST: Decimal;
        TotalSGST: Decimal;
        TotalIGST: Decimal;
        TaxtransactionValue: record "Tax Transaction Value";
        PostedVoucher: Report "Posted Voucher";
        Gstno: Code[20];
        Panno: Code[20];
        Phoneno: Code[20];
        AmountinWords: array[2] of text;
        AmntinWrds: Text;
        CustomerGstno: Code[20];
        CustomerPanno: Code[20];







}