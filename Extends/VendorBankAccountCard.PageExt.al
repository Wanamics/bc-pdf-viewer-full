pageextension 81793 "wan Vendor Bank Account Card" extends "Vendor Bank Account Card"
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
