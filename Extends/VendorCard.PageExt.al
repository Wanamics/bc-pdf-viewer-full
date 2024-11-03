pageextension 81791 "wan Vendor Card" extends "Vendor Card"
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
        CurrPage.PDFV2StorageFactbox.PAGE.SetFilterOnRecord(Rec.RecordId());
    end;
}
