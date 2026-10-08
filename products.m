let
    Source = Orders_Raw,
    Cols   = Table.SelectColumns(Source, {"Product ID", "Product Name", "Category", "Sub-Category"}),
    Result = Table.Distinct(Cols, {"Product ID"})
in
    Result
