codeunit 81751 "PDFV2 Incoming Doc. Attachment"
{
    TableNo = "Incoming Document Attachment";
    trigger OnRun()
    var
        // Rec: Record "Incoming Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        PDFViewer: Page "PDFV2 PDF Viewer";
        PDFOutStream: OutStream;
        PDFInStream: InStream;
    begin
        message('IncomingDocumentAttachment.Content.Length:%1', Rec.Content.Length);
        TempBlob.CreateOutStream(PDFOutStream, TextEncoding::UTF8);
        // if Rec.Get(Rec."Incoming Document Entry No.", Rec."Line No.") then begin
        Rec.CalcFields(Content);
        Rec.Content.CreateInStream(PDFInStream, TextEncoding::UTF8);
        // end;
        PDFViewer.SetPDFDocument(PDFInStream);
        PDFViewer.Run();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Inc. Doc. Attachment Overview", OnBeforeNameDrillDown, '', false, false)]
    local procedure OnBeforeNameDrillDown(var IncDocAttachmentOverview: Record "Inc. Doc. Attachment Overview"; var IsHandled: Boolean)
    var
        IncomingDocumentAttachment: Record "Incoming Document Attachment";
    begin
        case IncDocAttachmentOverview."Attachment Type" of
            IncDocAttachmentOverview."Attachment Type"::"Main Attachment",
            IncDocAttachmentOverview."Attachment Type"::"Supporting Attachment":
                if IncomingDocumentAttachment.Get(IncDocAttachmentOverview."Incoming Document Entry No.", IncDocAttachmentOverview."Line No.") and
                    (IncomingDocumentAttachment."File Extension".ToLower() = 'pdf') then
                    IsHandled := Codeunit.Run(Codeunit::"PDFV2 Incoming Doc. Attachment", IncomingDocumentAttachment);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Incoming Document Attachment", OnBeforeExport, '', false, false)]
    local procedure OnBeforeExport(var IncomingDocumentAttachment: Record "Incoming Document Attachment")
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        if not IncomingDocumentAttachment.GetContent(TempBlob) then
            exit;

        if IncomingDocumentAttachment."File Extension".ToLower() = 'pdf' then
            if Codeunit.Run(Codeunit::"PDFV2 Incoming Doc. Attachment", IncomingDocumentAttachment) then
                error('');
    end;
}