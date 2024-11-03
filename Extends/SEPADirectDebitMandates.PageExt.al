pageextension 81794 "wan SEPA Direct Debit Mand." extends "SEPA Direct Debit Mandates"
{
    layout
    {
        addlast(Group)
        {
            field(wanPdfStorageCount; wanPdfStorageCount())
            {
                Caption = 'Pdf Storage Count';
                ApplicationArea = All;
                BlankZero = true;
            }
        }
        addlast(factboxes)
        {
            part(PDFV2StorageFactbox; "wan PDF Storage Factbox")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.PDFV2StorageFactbox.Page.SetFilterOnRecord(Rec.RecordId());
    end;

    local procedure wanPdfStorageCount(): Integer
    var
        PDFV2Storage: Record "PDFV2 PDF Storage";
    begin
        PDFV2Storage.SetCurrentKey("Source Record ID");
        PDFV2Storage.SetRange("Source Record ID", Rec.RecordId());
        exit(PDFV2Storage.Count());
    end;
}
