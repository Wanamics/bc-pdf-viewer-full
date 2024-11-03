pageextension 81790 "wan Vendor List" extends "Vendor List"
{
    layout
    {
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
}
