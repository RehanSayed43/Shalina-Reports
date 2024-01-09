// report 50131 PurchaseS
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     Caption = 'yyy';
//     RDLCLayout = './re.rdl';



//     dataset
//     {
//         dataitem("Purchase Header"; "Purchase Header")
//         {
//             DataItemTableView = sorting("No.");
//             RequestFilterFields = "No.";
//             column(No_; "No.") { }
//             column(Pay_to_Name; "Pay-to Name") { }
//             column(Pay_to_Address; "Pay-to Address") { }
//             column(Location_Code; "Location Code") { }
//             column(Pay_to_City; "Pay-to City") { }
//             column(Ship_to_City; "Ship-to City") { }
//             column(Ship_to_Address; "Ship-to Address") { }
//             column(Location_GST_Reg__No_; "Location GST Reg. No.") { }

//             column(NameContact; "Pay-to Contact") { }
//             column(Buyersno; "Buy-from Vendor No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Companyinfoname; Companyinfo.Name) { }
//             column(Companyinfoaddress; Companyinfo.Address) { }
//             column(CompanyinfoCity; Companyinfo.City) { }
//             column(Companyinfogstno; Companyinfo."GST Registration No.") { }
//             column(Companyinfopanno; Companyinfo."P.A.N. No.") { }
//             column(CompanyinfoBankname; Companyinfo."Bank Name") { }
//             column(Companyinfobankno; Companyinfo."Bank Branch No.") { }
//             column(CompanyinfoSwiftcode; Companyinfo."SWIFT Code") { }
//             column(CompanyinfoAccno; Companyinfo."Bank Account No.") { }

//             dataitem("Purchase Line"; "Purchase Line")
//             {
//                 DataItemLinkReference = "Purchase Header";
//                 DataItemLink = "Document No." = field("No.");
//                 column(Noss_; "No.") { }
//                 column(Description; Description) { }
//                 column(Quantity; Quantity) { }
//                 column(HSN_SAC_Code; "HSN/SAC Code") { }
//                 column(Rate; "Unit Cost") { }
//                 column(Per; "Unit of Measure Code") { }
//                 column(Amount; "Line Amount") { }
//                 column(AmntinWrds; AmntinWrds) { }
//                 column(CGST; CGST) { }
//                 column(SGST; SGST) { }
//                 column(IGST; IGST) { }
//                 column(CGSTRATE; CGSTRATE) { }
//                 column(SGSTRATE; SGSTRATE) { }
//                 column(IGSTRATE; IGSTRATE) { }
//                 column(TotalCGST; TotalCGST) { }
//                 column(TotalSGST; TotalSGST) { }
//                 column(TotalIGST; TotalIGST) { }
//                 column(Grandtotal; Grandtotal) { }
//                 trigger OnAfterGetRecord()
//                 begin
//                     vendor.Reset();
//                     vendor.SetRange("No.", "Buy-from Vendor No.");
//                     if vendor.Find('-') then begin
//                         Gstno := vendor."GST Registration No.";
//                         Phoneno := vendor."Phone No.";
//                         Panno := vendor."P.A.N. No.";
//                     end;


//                     Purchasline.Reset();
//                     Purchasline.SetRange("Document No.", "Purchase Header"."No.");
//                     Purchasline.SetRange("Document Type", "Purchase Header"."Document Type");
//                     Purchasline.SetFilter("GST Group Code", '<>%1', '');


//                     if Purchasline.FindSet() then
//                         repeat
//                             TaxRecordId := Purchasline.RecordId;

//                             TaxtransctionValue.Reset();
//                             TaxtransctionValue.SetRange("Tax Record ID", TaxRecordId);
//                             TaxtransctionValue.SetRange("Value Type", TaxtransctionValue."Value Type");
//                             TaxtransctionValue.SetRange("Visible on Interface", true);
//                             TaxtransctionValue.SetFilter("Tax Type", '=%1', 'GST');
//                             TaxtransctionValue.SetFilter(Percent, '<>%1', 0);
//                             TaxtransctionValue.SetFilter("Value ID", '%1|%2', 6, 2);
//                             if TaxtransctionValue.FindSet() then begin
//                                 CGSTRATE := TaxtransctionValue.Percent;
//                                 SGSTRATE := TaxtransctionValue.Percent;
//                                 CGST := TaxtransctionValue.Amount;
//                                 SGST := TaxtransctionValue.Amount;
//                                 TotalCGST += CGST;
//                                 TotalSGST += SGST;

//                             end else begin
//                                 TaxtransctionValue.Reset();
//                                 TaxtransctionValue.SetRange("Tax Record ID", TaxRecordId);
//                                 TaxtransctionValue.SetRange("Value Type", TaxtransctionValue."Value Type");
//                                 TaxtransctionValue.SetRange("Visible on Interface", true);
//                                 TaxtransctionValue.SetFilter("Tax Type", '=%1', 'GST');
//                                 TaxtransctionValue.SetFilter(Percent, '<>%1', 0);
//                                 TaxtransctionValue.SetFilter("Value ID", '%1', 3);
//                                 if TaxtransctionValue.FindSet() then
//                                     IGSTRATE := TaxtransctionValue.Percent;
//                                 IGST := TaxtransctionValue.Amount;
//                                 TotalIGST += IGST;
//                             end;
//                             Total := Total + Purchasline.Amount;
//                             Grandtotal := Total + TotalCGST + TotalSGST + TotalIGST;
//                         until Purchasline.Next() = 0;


//                     PostedVoucher.InitTextVariable();
//                     "Purchase Header".CalcFields(Amount);
//                     PostedVoucher.FormatNoText(AmountinWords, Round(Grandtotal), "Purchase Header"."Currency Code");
//                     AmntinWrds := AmountinWords[1] + AmountinWords[2];

//                 end;


//             }

//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     // field(Name; SourceExpression)
//                     // {
//                     //     ApplicationArea = All;

//                     // }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//         trigger OnInit()
//         var
//             myInt: Integer;
//         begin
//             Companyinfo.get();
//         end;
//     }

//     // rendering
//     // {
//     //     layout(LayoutName)
//     //     {
//     //         Type = RDLC;
//     //         LayoutFile = 'mylayout.rdl';
//     //     }
//     // }

//     var
//         myInt: Integer;
//         vendor: Record Vendor;
//         Companyinfo: Record "Company Information";
//         PostedVoucher: Report "Posted Voucher";

//         Gstno: Code[20];
//         Panno: Code[20];
//         Phoneno: Text[30];
//         Purchasline: Record "Purchase Line";

//         AmountinWords: array[2] of Text;
//         AmntinWrds: Text;
//         Total: Decimal;


//         TaxtransctionValue: Record "Tax Transaction Value";
//         CGST: Decimal;
//         SGST: Decimal;
//         IGST: Decimal;
//         CGSTRATE: Decimal;
//         SGSTRATE: Decimal;
//         IGSTRATE: Decimal;
//         TotalCGST: Decimal;
//         TotalIGST: Decimal;
//         TotalSGST: Decimal;


//         TaxRecordId: RecordId;

//         Taaxtotal: Decimal;
//         Grandtotal: Decimal;
// }