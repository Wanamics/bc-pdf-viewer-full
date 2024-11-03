pageextension 81795 "PDFV2 Cust. Bank Account Card" extends "Customer Bank Account Card"
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
