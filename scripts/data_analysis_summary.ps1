# data_analysis_summary.ps1 - Computes aggregate EDA and metrics for the 3 Scenarios
$csvPath = "C:\Users\Shubham Soni\.gemini\antigravity\scratch\ev_market_analysis\data\ev_market_dataset.csv"
$data = Import-Csv -Path $csvPath

$totalRecords = $data.Count
$totalSales = [double]($data | Measure-Object -Property Annual_Sales_Units -Sum).Sum
$totalRevenue = [double]($data | Measure-Object -Property Annual_Revenue_USD -Sum).Sum
$avgPrice = [Math]::Round(($data | Measure-Object -Property Base_Price_USD -Average).Average, 2)
$avgRange = [Math]::Round(($data | Measure-Object -Property Driving_Range_km -Average).Average, 1)
$avgRating = [Math]::Round(($data | Measure-Object -Property Customer_Rating -Average).Average, 2)
$totalCarbon = [Math]::Round(($data | Measure-Object -Property Total_Carbon_Offset_Tons -Sum).Sum, 0)

Write-Host "================ GLOBAL EV MARKET OVERVIEW ================" -ForegroundColor Cyan
Write-Host "Total Model Configurations: $totalRecords"
Write-Host ("Total Cumulative Sales Units: {0:N0}" -f $totalSales)
Write-Host ("Total Cumulative Revenue: `${0:N2}" -f $totalRevenue)
Write-Host ("Average Base Price: `${0:N2}" -f $avgPrice)
Write-Host ("Average Driving Range: {0} km" -f $avgRange)
Write-Host ("Average Customer Satisfaction: {0} / 5.0" -f $avgRating)
Write-Host ("Total Carbon Offsets: {0:N0} Metric Tons" -f $totalCarbon)

# Scenario 1: Emily Johnson
$catGroups = $data | Group-Object Vehicle_Category | ForEach-Object {
    $catSales = [double]($_.Group | Measure-Object -Property Annual_Sales_Units -Sum).Sum
    $catRev = [double]($_.Group | Measure-Object -Property Annual_Revenue_USD -Sum).Sum
    $catAvgPrice = [Math]::Round(($_.Group | Measure-Object -Property Base_Price_USD -Average).Average, 0)
    $catAvgRange = [Math]::Round(($_.Group | Measure-Object -Property Driving_Range_km -Average).Average, 0)
    $catAvgRating = [Math]::Round(($_.Group | Measure-Object -Property Customer_Rating -Average).Average, 2)
    $salesShare = [Math]::Round(($catSales / $totalSales) * 100, 2)
    [PSCustomObject]@{
        Category = $_.Name
        Sales_Units = $catSales
        Sales_Share_Pct = $salesShare
        Revenue_USD = $catRev
        Avg_Price_USD = $catAvgPrice
        Avg_Range_km = $catAvgRange
        Avg_Rating = $catAvgRating
    }
} | Sort-Object Sales_Units -Descending

# Scenario 2: David Chen
$oemGroups = $data | Group-Object Manufacturer | ForEach-Object {
    $oemSales = [double]($_.Group | Measure-Object -Property Annual_Sales_Units -Sum).Sum
    $oemRev = [double]($_.Group | Measure-Object -Property Annual_Revenue_USD -Sum).Sum
    $oemAvgRating = [Math]::Round(($_.Group | Measure-Object -Property Customer_Rating -Average).Average, 2)
    $share = [Math]::Round(($oemSales / $totalSales) * 100, 2)
    $topBattery = ($_.Group | Group-Object Battery_Technology | Sort-Object Count -Descending | Select-Object -First 1).Name
    $topCountry = ($_.Group | Group-Object Manufacturing_Country | Sort-Object Count -Descending | Select-Object -First 1).Name
    [PSCustomObject]@{
        Manufacturer = $_.Name
        Sales_Units = $oemSales
        Market_Share_Pct = $share
        Revenue_USD = $oemRev
        Primary_Battery = $topBattery
        Primary_Hub = $topCountry
        Avg_Rating = $oemAvgRating
    }
} | Sort-Object Sales_Units -Descending

# Scenario 3: Dr. Sarah Williams
$batGroups = $data | Group-Object Battery_Technology | ForEach-Object {
    $bSales = [double]($_.Group | Measure-Object -Property Annual_Sales_Units -Sum).Sum
    $bAvgRange = [Math]::Round(($_.Group | Measure-Object -Property Driving_Range_km -Average).Average, 1)
    $bAvgCap = [Math]::Round(($_.Group | Measure-Object -Property Battery_Capacity_kWh -Average).Average, 1)
    $bAvgEfficiency = [Math]::Round(($_.Group | Measure-Object -Property Energy_Efficiency_km_per_kWh -Average).Average, 2)
    $bAvgCharge = [Math]::Round(($_.Group | Measure-Object -Property Charging_Time_Min -Average).Average, 0)
    $share = [Math]::Round(($bSales / $totalSales) * 100, 2)
    [PSCustomObject]@{
        Battery_Tech = $_.Name
        Record_Count = $_.Count
        Adoption_Share_Pct = $share
        Avg_Range_km = $bAvgRange
        Avg_Capacity_kWh = $bAvgCap
        Efficiency_km_per_kWh = $bAvgEfficiency
        Avg_Charge_Time_Min = $bAvgCharge
    }
} | Sort-Object Avg_Range_km -Descending

# Save summary JSON
$summaryJson = [PSCustomObject]@{
    Overview = @{
        TotalRecords = $totalRecords
        TotalSalesUnits = $totalSales
        TotalRevenueUSD = $totalRevenue
        AvgPriceUSD = $avgPrice
        AvgRangeKm = $avgRange
        AvgRating = $avgRating
        TotalCarbonOffsetTons = $totalCarbon
    }
    Scenario1_Categories = $catGroups
    Scenario2_Manufacturers = $oemGroups
    Scenario3_Batteries = $batGroups
} | ConvertTo-Json -Depth 5

$summaryJson | Out-File -FilePath "C:\Users\Shubham Soni\.gemini\antigravity\scratch\ev_market_analysis\data\ev_market_summary.json" -Encoding UTF8
Write-Host "Summary JSON exported to data/ev_market_summary.json" -ForegroundColor Green
