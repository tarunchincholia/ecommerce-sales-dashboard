let
    Source   = Excel.Workbook(File.Contents("D:\ecommerce-sales-dashboard\data\raw\Superstore_Raw.xlsx"), null, true),
    Sheet    = Source{[Item="Orders", Kind="Sheet"]}[Data],
    Promoted = Table.PromoteHeaders(Sheet, [PromoteAllScalars=true])
in
    Promoted
