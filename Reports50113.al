// report 50113 StockReport
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = './uk.rdl';


//     dataset
//     {
//         dataitem("Item Ledger Entry"; "Item Ledger Entry")
//         {
//             RequestFilterFields = "Item No.", "Location Code";
//             // DataItemTableView = sorting("Posting Date");

//             column(Item_No_; "Item No.") { }
//             column(item; item.Description) { }
//             column(CTN; UnitofMeasure) { }
//             column(Remaining_Quantity; "Remaining Quantity") { }

//             //column(Location; Location.Code) { }
//             column(Location_Code; "Location Code") { }
//             column(Expiration_Date; "Expiration Date") { }

//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//             begin
//                 // iteml.Reset();
//                 // iteml.SetRange("Item No.", item."No.");
//                 // if item.FindSet() then begin
//                 // iteml := item.Description;
//                 item.Reset();
//                 item.SetRange("No.", "Item Ledger Entry"."Item No.");
//                 if item.FindFirst() then begin
//                     ItemDescription := item.Description;

//                 end;

//                 Ctn.Reset();
//                 Ctn.SetRange("Item No.", item."No.");
//                 if Ctn.FindFirst() then begin
//                     UnitofMeasure := Ctn."Qty. per Unit of Measure"
//                 end;


//                 // item.Reset();
//                 // item.SetRange("No.", Ctn."Item No.");
//                 // if item.FindFirst() then begin
//                 //     // UnitofMeasure:=item.

//                 // end;

//                 Location.Reset();
//                 Location.SetRange(Code, "Item Ledger Entry"."Location Code");
//                 if Location.FindFirst() then begin
//                     Blue := Location.Code;
//                 end;


//             end;






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
//                     // field(StartDate; StartDate)
//                     // {
//                     //     ApplicationArea = all;
//                     // }
//                     // field(EndDate; EndDate)
//                     // {
//                     //     ApplicationArea = all;

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
//     }

//     trigger OnInitReport()
//     var
//         myInt: Integer;
//     begin
//         //Location.get();
//     end;




//     var
//         myInt: Integer;
//         item: Record Item;
//         iteml: Record "Item Ledger Entry";
//         StartDate: Date;
//         EndDate: Date;
//         Location: Record Location;
//         ItemDescription: text[200];
//         Blue: Code[20];
//         Red: Code[20];
//         UnitofMeasure: Decimal;
//         Ctn: Record "Item Unit of Measure";



// }