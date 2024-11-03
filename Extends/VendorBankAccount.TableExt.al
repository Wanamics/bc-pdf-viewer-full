tableextension 81790 "wan Vendor Bank Account" extends "Vendor Bank Account"
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
