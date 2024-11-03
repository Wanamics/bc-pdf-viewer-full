tableextension 81792 "PDFV2 Cust. Bank Account" extends "Customer Bank Account"
{
    trigger OnAfterDelete()
    var
        PDFStorage: Record "PDFV2 PDF Storage";
    begin
        PDFStorage.SetCurrentKey("Source Record ID");
        PDFStorage.SetRange("Source Record ID", RecordId);
        PDFStorage.DeleteAll(true);
    end;
}
