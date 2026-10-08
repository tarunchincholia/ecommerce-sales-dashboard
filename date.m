let
    StartDate = #date(2021, 1, 1),
    EndDate   = #date(2024, 12, 31),
    Days      = Duration.Days(EndDate - StartDate) + 1,
    DateList  = List.Dates(StartDate, Days, #duration(1, 0, 0, 0)),
    ToTable   = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),
    Typed     = Table.TransformColumnTypes(ToTable, {{"Date", type date}}),
    Year      = Table.AddColumn(Typed, "Year", each Date.Year([Date]), Int64.Type),
    MonthNo   = Table.AddColumn(Year, "Month No", each Date.Month([Date]), Int64.Type),
    Month     = Table.AddColumn(MonthNo, "Month", each Date.ToText([Date], "MMM"), type text),
    Quarter   = Table.AddColumn(Month, "Quarter", each "Q" & Text.From(Date.QuarterOfYear([Date])), type text)
in
    Quarter
