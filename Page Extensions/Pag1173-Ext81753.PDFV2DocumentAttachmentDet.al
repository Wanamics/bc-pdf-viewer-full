pageextension 81753 "PDFV2 Document Attachment Det" extends "Document Attachment Details" //1173
{
    actions
    {
        addfirst(processing)
        {
            action("PDFV2 View PDF")
            {
                ApplicationArea = All;
                Image = Text;
                Caption = 'View PDF';
                ToolTip = 'View PDF';
                // Promoted = true;
                // PromotedOnly = true;
                // PromotedCategory = Process;
                Enabled = IsPdf; //Rec."File Extension" = 'pdf';
                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    PDFViewer: Page "PDFV2 PDF Viewer";
                    PDFOutStream: OutStream;
                    PDFInStream: InStream;
                begin
                    TempBlob.CreateOutStream(PDFOutStream, TextEncoding::UTF8);
                    Rec."Document Reference ID".ExportStream(PDFOutStream);
                    TempBlob.CreateInStream(PDFInStream, TextEncoding::UTF8);
                    PDFViewer.SetPDFDocument(PDFInStream);
                    PDFViewer.Run();
                end;
            }
        }
        //[
        addfirst(Category_Process)
        {
            actionref("PDFV2 View PDF Promoted"; "PDFV2 View PDF") { }
        }
        //]
    }
    var
        IsPdf: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        IsPdf := Rec."File Extension".ToLower() = 'pdf';
    end;
}
