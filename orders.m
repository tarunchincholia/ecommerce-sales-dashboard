let
    Source     = Orders_Raw,
    Typed      = Table.TransformColumnTypes(Source, {
                    {"Row ID", Int64.Type}, {"Order Date", type date}, {"Ship Date", type date},
                    {"Sales", type number}, {"Quantity", Int64.Type},
                    {"Discount", type number}, {"Profit", type number}}),
    Trimmed    = Table.TransformColumns(Typed, {
                    {"Customer Name", Text.Trim, type text},
                    {"State", Text.Trim, type text}}),
    NoDupes    = Table.Distinct(Trimmed, {"Row ID"}),
    FixState   = Table.ReplaceValue(NoDupes, null, "Unknown", Replacer.ReplaceValue, {"State"}),
    DaysToShip = Table.AddColumn(FixState, "Days To Ship",
                    each Duration.Days([Ship Date] - [Order Date]), Int64.Type),
    Result     = Table.SelectColumns(DaysToShip, {
                    "Row ID", "Order ID", "Order Date", "Ship Date", "Days To Ship", "Ship Mode",
                    "Customer ID", "Product ID", "State", "Region", "Sales", "Quantity", "Discount", "Profit"})
in
    Result
