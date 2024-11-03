/*
pageextension 81755 "PDFV2 Inc.Doc.Attach.FactBox" extends "Incoming Doc. Attach. FactBox" //81755
{
    actions
    {
        addlast(processing)
        {
            action("PDFV2 View PDF")
            {
                ApplicationArea = All;
                Image = Text;
                Caption = 'View PDF';
                ToolTip = 'View the PDF document.';
                Scope = Repeater;
                Enabled = IsPdf; //Rec."File Extension" = 'pdf';
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"PdfViewer Events",Rec);
                end;
            }
        }
    }

    var
        IsPdf: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        IsPdf := Rec."File Extension".ToLower() = 'pdf';
    end;
}
*/
