// report 50107 Sayed
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = './rehan.rdl';

//     dataset
//     {
//         dataitem("Sales Header"; "Sales Header")
//         {
//             column(No_; "No.")
//             {

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
//     }

//     // rendering
//     // {
//     //     // layout(LayoutName)
//     //     // {
//     //     //     Type = Excel;
//     //     //     // LayoutFile = 'mySpreadsheet.xlsx';
//     //     // }
//     // }

//     var
//         myInt: Integer;
// }