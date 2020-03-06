table 50135 MyTable
{
    fields
    {
        field(1; MyField; Decimal)
        {
            Description = 'New field';
        }
        field(2; "No."; Code[20])
        {
            Description = 'Serial number of the service';
        }
        field(3; "Global Dimension 1 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(4; "Global Dimension 2 Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(5; "Currency Filter"; Code[10])
        {
            FieldClass = FlowFilter;
        }
        field(6; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Detailed Cust. Ledg. Entry"."Amount (LCY)"
            where("Customer No." = field("No."),
            "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
            "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
            "Currency Code" = field("Currency Filter")
            ));
        }
        field(7; "Amount upper bound"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = max ("Detailed Cust. Ledg. Entry"."Amount (LCY)"
            where("Customer No." = field("No."),
            "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
            "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
            "Currency Code" = field("Currency Filter")
            ));
        }
        field(8; "Amount lower bound"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = min ("Detailed Cust. Ledg. Entry"."Amount (LCY)"
            where("Customer No." = field("No."),
            "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
            "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
            "Currency Code" = field("Currency Filter")
            ));
        }
        field(9; "First Entry"; Boolean)
        {
            CalcFormula = exist (Customer where(Payments = const(0),
            "No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Specifies whether it is the customers''s first entry';
        }
        field(10; "Customer Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Customer.Balance where("No." = field("No.")));
        }
    }
}