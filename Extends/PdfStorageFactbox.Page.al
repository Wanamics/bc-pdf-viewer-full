page 81790 "wan PDF Storage Factbox"
{
    ApplicationArea = All;
    Caption = 'PDF Documents';
    PageType = CardPart;
    SourceTable = "PDFV2 PDF Storage";
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        RunViewer();
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(UploadContent)
            {
                ApplicationArea = All;
                Image = MoveUp;
                Caption = 'Upload';
                ToolTip = 'Upload';
                trigger OnAction()
                var
                    PDFStorage: Record "PDFV2 PDF Storage";
                    SourceRecordID: RecordId;
                begin
                    if Rec.GetFilter("Source Record ID") <> '' then
                        Evaluate(SourceRecordID, Rec.GetFilter("Source Record ID"));
                    PDFStorage.UploadContent(SourceRecordID);
                    CurrPage.Update(true);
                end;
            }

            action(DownloadContent)
            {
                ApplicationArea = All;
                Image = MoveDown;
                Caption = 'Download';
                ToolTip = 'Download';
                trigger OnAction()
                begin
                    Rec.DownloadContent();
                    CurrPage.Update(true);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.Update(true);
    end;

    procedure SetFilterOnRecord(pRecordID: RecordId)
    begin
        Rec.SetRange("Source Record ID", pRecordID);
        CurrPage.Update();
    end;

    local procedure RunViewer()
    var
        PDFViewer: Page "PDFV2 PDF Viewer";
        PDFInStream: InStream;
    begin
        Rec.CalcFields("PDF Value");

        if not Rec."PDF Value".HasValue() then
            exit;
        Rec."PDF Value".CreateInStream(PDFInStream);
        PDFViewer.SetPDFDocument(PDFInStream);
        PDFViewer.Run();
    end;
}
