let
    Source = Orders_Raw,
    Trim   = Table.TransformColumns(Source, {{"Customer Name", Text.Trim, type text}}),
    Cols   = Table.SelectColumns(Trim, {"Customer ID", "Customer Name", "Segment"}),
    Result = Table.Distinct(Cols, {"Customer ID"})
in
    Result
