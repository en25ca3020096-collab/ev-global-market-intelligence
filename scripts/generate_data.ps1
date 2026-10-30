# generate_data.ps1 - Generates realistic Electric Vehicle (EV) Industry Dataset
param(
    [string]$OutputPath = "C:\Users\Shubham Soni\.gemini\antigravity\scratch\ev_market_analysis\data\ev_market_dataset.csv",
    [int]$RecordCount = 1250
)

$rnd = New-Object System.Random(42)

# Models dictionary by OEM and Category
$models = @(
    # Tesla
    @{ OEM="Tesla"; Model="Model 3"; Category="Sedan"; Battery="NCA"; Country="USA"; BaseCap=60; CapVar=22; BaseRange=490; RangeVar=130; PriceBase=38990; PriceVar=15000; Rating=4.6 },
    @{ OEM="Tesla"; Model="Model Y"; Category="SUV"; Battery="NMC"; Country="USA"; BaseCap=75; CapVar=15; BaseRange=455; RangeVar=80; PriceBase=44990; PriceVar=12000; Rating=4.7 },
    @{ OEM="Tesla"; Model="Model S"; Category="Sedan"; Battery="NCA"; Country="USA"; BaseCap=100; CapVar=10; BaseRange=650; RangeVar=70; PriceBase=74990; PriceVar=20000; Rating=4.8 },
    @{ OEM="Tesla"; Model="Model X"; Category="SUV"; Battery="NCA"; Country="USA"; BaseCap=100; CapVar=10; BaseRange=560; RangeVar=60; PriceBase=79990; PriceVar=22000; Rating=4.5 },
    @{ OEM="Tesla"; Model="Cybertruck"; Category="Truck"; Battery="NMC"; Country="USA"; BaseCap=123; CapVar=20; BaseRange=510; RangeVar=50; PriceBase=79990; PriceVar=30000; Rating=4.3 },
    @{ OEM="Tesla"; Model="Semi"; Category="Truck"; Battery="NMC"; Country="USA"; BaseCap=500; CapVar=100; BaseRange=800; RangeVar=100; PriceBase=180000; PriceVar=40000; Rating=4.6 },
    
    # BYD
    @{ OEM="BYD"; Model="Seal"; Category="Sedan"; Battery="LFP"; Country="China"; BaseCap=61; CapVar=21; BaseRange=550; RangeVar=100; PriceBase=32000; PriceVar=10000; Rating=4.6 },
    @{ OEM="BYD"; Model="Atto 3"; Category="SUV"; Battery="LFP"; Country="China"; BaseCap=50; CapVar=10; BaseRange=420; RangeVar=60; PriceBase=28000; PriceVar=8000; Rating=4.5 },
    @{ OEM="BYD"; Model="Dolphin"; Category="Hatchback"; Battery="LFP"; Country="China"; BaseCap=44; CapVar=16; BaseRange=340; RangeVar=80; PriceBase=18000; PriceVar=6000; Rating=4.4 },
    @{ OEM="BYD"; Model="Han EV"; Category="Sedan"; Battery="LFP"; Country="China"; BaseCap=85; CapVar=10; BaseRange=605; RangeVar=70; PriceBase=36000; PriceVar=12000; Rating=4.7 },
    @{ OEM="BYD"; Model="K9 Electric Bus"; Category="Electric Bus"; Battery="LFP"; Country="China"; BaseCap=324; CapVar=80; BaseRange=300; RangeVar=60; PriceBase=380000; PriceVar=70000; Rating=4.5 },
    @{ OEM="BYD"; Model="Seagull"; Category="Hatchback"; Battery="Sodium-Ion"; Country="China"; BaseCap=30; CapVar=8; BaseRange=305; RangeVar=50; PriceBase=11500; PriceVar=3000; Rating=4.3 },

    # Volkswagen Group
    @{ OEM="Volkswagen"; Model="ID.3"; Category="Hatchback"; Battery="NMC"; Country="Germany"; BaseCap=58; CapVar=19; BaseRange=420; RangeVar=120; PriceBase=39000; PriceVar=9000; Rating=4.2 },
    @{ OEM="Volkswagen"; Model="ID.4"; Category="SUV"; Battery="NMC"; Country="Germany"; BaseCap=77; CapVar=10; BaseRange=520; RangeVar=60; PriceBase=42000; PriceVar=14000; Rating=4.4 },
    @{ OEM="Volkswagen"; Model="ID.7"; Category="Sedan"; Battery="NMC"; Country="Germany"; BaseCap=77; CapVar=9; BaseRange=620; RangeVar=80; PriceBase=56000; PriceVar=12000; Rating=4.6 },
    @{ OEM="Volkswagen"; Model="ID. Buzz"; Category="SUV"; Battery="NMC"; Country="Germany"; BaseCap=82; CapVar=10; BaseRange=425; RangeVar=50; PriceBase=59000; PriceVar=15000; Rating=4.5 },

    # Hyundai - Kia
    @{ OEM="Hyundai"; Model="Ioniq 5"; Category="SUV"; Battery="NMC"; Country="South Korea"; BaseCap=58; CapVar=26; BaseRange=450; RangeVar=110; PriceBase=41500; PriceVar=15000; Rating=4.7 },
    @{ OEM="Hyundai"; Model="Ioniq 6"; Category="Sedan"; Battery="NMC"; Country="South Korea"; BaseCap=53; CapVar=24; BaseRange=540; RangeVar=110; PriceBase=42500; PriceVar=13000; Rating=4.7 },
    @{ OEM="Hyundai"; Model="Elec City Bus"; Category="Electric Bus"; Battery="NMC"; Country="South Korea"; BaseCap=290; CapVar=50; BaseRange=310; RangeVar=40; PriceBase=360000; PriceVar=50000; Rating=4.4 },
    @{ OEM="Kia"; Model="EV6"; Category="SUV"; Battery="NMC"; Country="South Korea"; BaseCap=58; CapVar=20; BaseRange=470; RangeVar=90; PriceBase=42600; PriceVar=16000; Rating=4.6 },
    @{ OEM="Kia"; Model="EV9"; Category="SUV"; Battery="NMC"; Country="South Korea"; BaseCap=99; CapVar=5; BaseRange=540; RangeVar=40; PriceBase=54900; PriceVar=20000; Rating=4.8 },

    # BMW
    @{ OEM="BMW"; Model="i4 Gran Coupe"; Category="Sedan"; Battery="NMC"; Country="Germany"; BaseCap=70; CapVar=14; BaseRange=490; RangeVar=100; PriceBase=52200; PriceVar=18000; Rating=4.7 },
    @{ OEM="BMW"; Model="iX3"; Category="SUV"; Battery="NMC"; Country="Germany"; BaseCap=74; CapVar=6; BaseRange=460; RangeVar=50; PriceBase=58000; PriceVar=12000; Rating=4.5 },
    @{ OEM="BMW"; Model="i7 xDrive60"; Category="Sedan"; Battery="NMC"; Country="Germany"; BaseCap=101; CapVar=6; BaseRange=625; RangeVar=45; PriceBase=105000; PriceVar=25000; Rating=4.8 },
    @{ OEM="BMW"; Model="Vision Solid-State"; Category="Sedan"; Battery="Solid-State"; Country="Germany"; BaseCap=110; CapVar=15; BaseRange=820; RangeVar=80; PriceBase=115000; PriceVar=30000; Rating=4.9 },

    # Mercedes-Benz
    @{ OEM="Mercedes-Benz"; Model="EQE Sedan"; Category="Sedan"; Battery="NMC"; Country="Germany"; BaseCap=90; CapVar=10; BaseRange=600; RangeVar=70; PriceBase=74900; PriceVar=22000; Rating=4.6 },
    @{ OEM="Mercedes-Benz"; Model="EQS SUV"; Category="SUV"; Battery="NMC"; Country="Germany"; BaseCap=108; CapVar=10; BaseRange=610; RangeVar=60; PriceBase=104400; PriceVar=30000; Rating=4.7 },
    @{ OEM="Mercedes-Benz"; Model="eCitaro Bus"; Category="Electric Bus"; Battery="Solid-State"; Country="Germany"; BaseCap=396; CapVar=50; BaseRange=330; RangeVar=50; PriceBase=440000; PriceVar=60000; Rating=4.6 },

    # Ford
    @{ OEM="Ford"; Model="Mustang Mach-E"; Category="SUV"; Battery="NMC"; Country="USA"; BaseCap=72; CapVar=19; BaseRange=440; RangeVar=100; PriceBase=39995; PriceVar=18000; Rating=4.4 },
    @{ OEM="Ford"; Model="F-150 Lightning"; Category="Truck"; Battery="NMC"; Country="USA"; BaseCap=98; CapVar=33; BaseRange=430; RangeVar=90; PriceBase=49995; PriceVar=35000; Rating=4.5 },
    @{ OEM="Ford"; Model="E-Transit"; Category="Truck"; Battery="LFP"; Country="USA"; BaseCap=68; CapVar=15; BaseRange=240; RangeVar=40; PriceBase=45995; PriceVar=12000; Rating=4.2 },

    # Rivian
    @{ OEM="Rivian"; Model="R1T Pickup"; Category="Truck"; Battery="NCA"; Country="USA"; BaseCap=105; CapVar=44; BaseRange=500; RangeVar=140; PriceBase=69900; PriceVar=25000; Rating=4.7 },
    @{ OEM="Rivian"; Model="R1S SUV"; Category="SUV"; Battery="NCA"; Country="USA"; BaseCap=105; CapVar=44; BaseRange=510; RangeVar=130; PriceBase=74900; PriceVar=24000; Rating=4.8 },
    @{ OEM="Rivian"; Model="EDV Commercial Van"; Category="Truck"; Battery="LFP"; Country="USA"; BaseCap=100; CapVar=20; BaseRange=250; RangeVar=30; PriceBase=82000; PriceVar=15000; Rating=4.5 },

    # NIO
    @{ OEM="NIO"; Model="ET7"; Category="Sedan"; Battery="Solid-State"; Country="China"; BaseCap=150; CapVar=10; BaseRange=1000; RangeVar=50; PriceBase=68000; PriceVar=15000; Rating=4.9 },
    @{ OEM="NIO"; Model="ES8"; Category="SUV"; Battery="NMC"; Country="China"; BaseCap=100; CapVar=20; BaseRange=580; RangeVar=70; PriceBase=65000; PriceVar=18000; Rating=4.6 },
    @{ OEM="NIO"; Model="ET5 Touring"; Category="Hatchback"; Battery="LFP"; Country="China"; BaseCap=75; CapVar=15; BaseRange=560; RangeVar=80; PriceBase=42000; PriceVar=10000; Rating=4.6 },

    # Volvo & Geely
    @{ OEM="Volvo"; Model="EX30"; Category="SUV"; Battery="LFP"; Country="Sweden"; BaseCap=51; CapVar=18; BaseRange=344; RangeVar=130; PriceBase=34950; PriceVar=11000; Rating=4.6 },
    @{ OEM="Volvo"; Model="EX90"; Category="SUV"; Battery="NMC"; Country="Sweden"; BaseCap=111; CapVar=10; BaseRange=600; RangeVar=50; PriceBase=76695; PriceVar=20000; Rating=4.7 },
    @{ OEM="Volvo"; Model="7900 Electric Bus"; Category="Electric Bus"; Battery="NMC"; Country="Sweden"; BaseCap=330; CapVar=40; BaseRange=320; RangeVar=40; PriceBase=410000; PriceVar=50000; Rating=4.5 },
    @{ OEM="Geely"; Model="Geometry C"; Category="Hatchback"; Battery="LFP"; Country="China"; BaseCap=53; CapVar=17; BaseRange=400; RangeVar=80; PriceBase=22000; PriceVar=7000; Rating=4.3 },

    # Tata Motors (Emerging high growth Asian Market)
    @{ OEM="Tata Motors"; Model="Nexon EV"; Category="SUV"; Battery="LFP"; Country="India"; BaseCap=30; CapVar=10.5; BaseRange=325; RangeVar=140; PriceBase=18000; PriceVar=6000; Rating=4.5 },
    @{ OEM="Tata Motors"; Model="Tiago EV"; Category="Hatchback"; Battery="LFP"; Country="India"; BaseCap=19; CapVar=5; BaseRange=250; RangeVar=65; PriceBase=10500; PriceVar=3500; Rating=4.4 },
    @{ OEM="Tata Motors"; Model="Punch EV"; Category="SUV"; Battery="LFP"; Country="India"; BaseCap=25; CapVar=10; BaseRange=315; RangeVar=106; PriceBase=13500; PriceVar=4000; Rating=4.5 },
    @{ OEM="Tata Motors"; Model="Starbus EV"; Category="Electric Bus"; Battery="LFP"; Country="India"; BaseCap=200; CapVar=50; BaseRange=220; RangeVar=40; PriceBase=240000; PriceVar=40000; Rating=4.3 },

    # Two-Wheeler OEMs
    @{ OEM="Ola Electric"; Model="S1 Pro Gen 2"; Category="Two-Wheeler"; Battery="NMC"; Country="India"; BaseCap=4.0; CapVar=0.5; BaseRange=195; RangeVar=15; PriceBase=1800; PriceVar=400; Rating=4.3 },
    @{ OEM="Ola Electric"; Model="S1 Air"; Category="Two-Wheeler"; Battery="LFP"; Country="India"; BaseCap=3.0; CapVar=0.5; BaseRange=151; RangeVar=10; PriceBase=1300; PriceVar=300; Rating=4.2 },
    @{ OEM="Ather Energy"; Model="450 Apex"; Category="Two-Wheeler"; Battery="NMC"; Country="India"; BaseCap=3.7; CapVar=0.5; BaseRange=157; RangeVar=20; PriceBase=2300; PriceVar=500; Rating=4.7 },
    @{ OEM="Ather Energy"; Model="450X Gen 3"; Category="Two-Wheeler"; Battery="NMC"; Country="India"; BaseCap=3.7; CapVar=0.5; BaseRange=150; RangeVar=15; PriceBase=1900; PriceVar=400; Rating=4.6 },
    @{ OEM="Zero Motorcycles"; Model="SR/F"; Category="Two-Wheeler"; Battery="NMC"; Country="USA"; BaseCap=17.3; CapVar=3; BaseRange=270; RangeVar=40; PriceBase=19795; PriceVar=4000; Rating=4.6 },
    @{ OEM="Zero Motorcycles"; Model="FX"; Category="Two-Wheeler"; Battery="NMC"; Country="USA"; BaseCap=7.2; CapVar=1.5; BaseRange=160; RangeVar=25; PriceBase=12995; PriceVar=2500; Rating=4.4 },
    @{ OEM="Yadea"; Model="Keeness VFD"; Category="Two-Wheeler"; Battery="Sodium-Ion"; Country="China"; BaseCap=3.5; CapVar=1; BaseRange=140; RangeVar=30; PriceBase=2100; PriceVar=600; Rating=4.2 },

    # Additional Global Commercial / Buses
    @{ OEM="Proterra"; Model="ZX5 Electric Bus"; Category="Electric Bus"; Battery="NMC"; Country="USA"; BaseCap=450; CapVar=150; BaseRange=400; RangeVar=80; PriceBase=520000; PriceVar=80000; Rating=4.4 },
    @{ OEM="Scania"; Model="25 P Electric Truck"; Category="Truck"; Battery="NMC"; Country="Sweden"; BaseCap=300; CapVar=60; BaseRange=250; RangeVar=50; PriceBase=290000; PriceVar=50000; Rating=4.5 }
)

$years = @(2021, 2022, 2023, 2024, 2025)

$records = New-Object System.Collections.Generic.List[PSObject]
$idCounter = 10001

for ($i = 0; $i -lt $RecordCount; $i++) {
    $m = $models[$rnd.Next(0, $models.Count)]
    $year = $years[$rnd.Next(0, $years.Count)]

    # Year trend multiplier (sales grow, battery improves, price stabilizes)
    $yearIndex = $year - 2021 # 0 to 4
    $techProgress = 1.0 + ($yearIndex * 0.035) # Range and capacity improve by ~3.5% per year
    $costProgression = 1.0 - ($yearIndex * 0.02) # Battery costs decline slightly
    $salesAdoptionMultiplier = [Math]::Pow(1.32, $yearIndex) # EV adoption boom ~32% CAGR

    $batteryTech = $m.Battery
    # Solid-state and Sodium-Ion are mostly 2023-2025 innovations
    if ($batteryTech -eq "Solid-State" -and $year -lt 2024) {
        $batteryTech = "NMC"
    }
    if ($batteryTech -eq "Sodium-Ion" -and $year -lt 2023) {
        $batteryTech = "LFP"
    }

    # Battery capacity (kWh)
    $cap = [Math]::Round(($m.BaseCap + ($rnd.NextDouble() * $m.CapVar)) * $techProgress, 1)

    # Driving Range (km)
    $rangeKm = [Math]::Round(($m.BaseRange + ($rnd.NextDouble() * $m.RangeVar)) * $techProgress, 0)
    $rangeMiles = [Math]::Round($rangeKm * 0.621371, 0)

    # Charging time (10-80% mins)
    $baseCharge = 35.0
    if ($m.Category -eq "Two-Wheeler") { $baseCharge = 75.0 }
    elseif ($m.Category -eq "Electric Bus" -or $m.Category -eq "Truck") { $baseCharge = 55.0 }
    elseif ($batteryTech -eq "Solid-State") { $baseCharge = 14.0 }
    elseif ($batteryTech -eq "LFP") { $baseCharge = 28.0 }
    $chargingTime = [Math]::Max(12, [Math]::Round($baseCharge - ($yearIndex * 3.0) + ($rnd.Next(-6, 8)), 0))

    # Base price (USD)
    $price = [Math]::Round(($m.PriceBase + ($rnd.NextDouble() * $m.PriceVar)) * $costProgression, 0)

    # Annual Sales Volume (Units)
    $baseSales = 0
    switch ($m.Category) {
        "SUV" { $baseSales = $rnd.Next(15000, 110000) }
        "Sedan" { $baseSales = $rnd.Next(12000, 95000) }
        "Hatchback" { $baseSales = $rnd.Next(8000, 75000) }
        "Two-Wheeler" { $baseSales = $rnd.Next(25000, 180000) }
        "Truck" { $baseSales = $rnd.Next(2500, 28000) }
        "Electric Bus" { $baseSales = $rnd.Next(800, 7500) }
    }
    # Market leader boost
    if ($m.OEM -in @("Tesla", "BYD")) {
        $baseSales = [Math]::Round($baseSales * 1.85, 0)
    }

    $annualSales = [Math]::Round($baseSales * $salesAdoptionMultiplier * (0.8 + ($rnd.NextDouble() * 0.4)), 0)
    $annualRevenue = [Math]::Round($annualSales * $price, 0)

    # Customer Rating (3.2 to 5.0)
    $ratingBonus = ($m.Rating - 4.0) + ($rnd.NextDouble() * 0.6 - 0.3)
    $customerRating = [Math]::Round([Math]::Min(5.0, [Math]::Max(3.2, 4.2 + $ratingBonus)), 2)

    # Energy Efficiency (km per kWh)
    $efficiencyKmPerKwh = [Math]::Round($rangeKm / [Math]::Max(0.5, $cap), 2)

    # Price per km range
    $pricePerKmRange = [Math]::Round($price / [Math]::Max(10, $rangeKm), 2)

    # Carbon Offset (Metric Tons per unit per year: avg 15,000km ICE produces ~3.2 tons CO2, 2W ~0.8 tons, Bus ~35 tons, Truck ~25 tons)
    $annualOffsetPerUnit = 3.2
    if ($m.Category -eq "Two-Wheeler") { $annualOffsetPerUnit = 0.85 }
    elseif ($m.Category -eq "Electric Bus") { $annualOffsetPerUnit = 38.5 }
    elseif ($m.Category -eq "Truck") { $annualOffsetPerUnit = 28.0 }
    elseif ($m.Category -eq "SUV") { $annualOffsetPerUnit = 3.8 }
    $totalCarbonOffsetTons = [Math]::Round($annualSales * $annualOffsetPerUnit, 1)

    # Secondary Assembly/Manufacturing Facility Country
    $mfgCountry = $m.Country
    if ($m.OEM -eq "Tesla" -and $rnd.Next(0, 3) -eq 1) { $mfgCountry = "China" }
    elseif ($m.OEM -eq "Tesla" -and $rnd.Next(0, 4) -eq 1) { $mfgCountry = "Germany" }
    elseif ($m.OEM -eq "Volkswagen" -and $rnd.Next(0, 3) -eq 1) { $mfgCountry = "China" }
    elseif ($m.OEM -eq "BMW" -and $rnd.Next(0, 4) -eq 1) { $mfgCountry = "USA" }

    $rec = [PSCustomObject]@{
        "Vehicle_ID" = "EV-$idCounter"
        "Model_Year" = $year
        "Manufacturer" = $m.OEM
        "Model_Name" = $m.Model
        "Vehicle_Category" = $m.Category
        "Battery_Technology" = $batteryTech
        "Battery_Capacity_kWh" = $cap
        "Driving_Range_km" = $rangeKm
        "Driving_Range_miles" = $rangeMiles
        "Charging_Time_Min" = $chargingTime
        "Base_Price_USD" = $price
        "Annual_Sales_Units" = $annualSales
        "Annual_Revenue_USD" = $annualRevenue
        "Manufacturing_Country" = $mfgCountry
        "Customer_Rating" = $customerRating
        "Energy_Efficiency_km_per_kWh" = $efficiencyKmPerKwh
        "Price_per_Range_USD_per_km" = $pricePerKmRange
        "Total_Carbon_Offset_Tons" = $totalCarbonOffsetTons
    }
    $records.Add($rec)
    $idCounter++
}

$records | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
Write-Output "Successfully generated $($records.Count) EV records at: $OutputPath"
