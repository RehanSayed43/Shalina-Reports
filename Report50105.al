// report 50105 "SalesInvoice Report"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = './Sales.rdl';

//     dataset
//     {
//         dataitem("Sales Header"; "Sales Header")
//         {
//             column(No_; "No.") { }
//             column(Bill_to_Name; "Bill-to Name") { }
//             column(Bill_to_Address; "Bill-to Address") { }
//             column(Bill_to_City; "Bill-to City") { }
//             column(Sell_to_Phone_No_; "Sell-to Phone No.") { }
//             column(Posting_Date; "Posting Date") { }
//             column(Bill_to_Post_Code; "Bill-to Post Code") { }

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
//     }

//     // rendering
//     // {
//     //     layout(LayoutName)
//     //     {
//     //         Type = Excel;
//     //         LayoutFile = 'mySpreadsheet.xlsx';
//     //     }
//     // }

//     var
//         myInt: Integer;
//         customer: Record Customer;
//         companyinfo: Record "Company Information";
// }