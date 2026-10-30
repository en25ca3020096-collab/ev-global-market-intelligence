@echo off
title Global EV Industry Intelligence Suite
color 0B
cls

echo ===============================================================================
echo                GLOBAL ELECTRIC VEHICLE (EV) INTELLIGENCE SUITE
echo ===============================================================================
echo.
echo  [INFO] Project Location: %~dp0
echo  [INFO] Data Source:      data\ev_market_dataset.csv (1,250 records)
echo  [INFO] Tableau Workbook: EV_Global_Market_Intelligence.twbx
echo  [INFO] Web App File:     index.html (GitHub Pages Ready)
echo.
echo ===============================================================================
echo                             SELECT AN ACTION TO RUN
echo ===============================================================================
echo.
echo   [1] Launch Interactive Web Dashboard in Default Browser
echo   [2] Launch Tableau Public with Workbook (.twbx)
echo   [3] Publish to GitHub Profile (Automated Script)
echo   [4] Open in VS Code (to 1-Click "Publish to GitHub")
echo   [5] Open Project Folder in Windows Explorer
echo   [6] Exit
echo.
echo ===============================================================================

set /p choice="Enter choice [1-6]: "

if "%choice%"=="1" goto launch_browser
if "%choice%"=="2" goto launch_tableau
if "%choice%"=="3" goto push_github
if "%choice%"=="4" goto open_vscode
if "%choice%"=="5" goto open_folder
if "%choice%"=="6" goto end

:launch_browser
echo.
echo [LAUNCHING] Opening Interactive Dashboard in your default web browser...
start "" "%~dp0index.html"
goto end

:launch_tableau
echo.
echo [LAUNCHING] Opening EV_Global_Market_Intelligence.twbx in Tableau...
if exist "C:\Program Files\Tableau\Tableau Public 2026.3\bin\tabpublic.exe" (
    start "" "C:\Program Files\Tableau\Tableau Public 2026.3\bin\tabpublic.exe" "%~dp0EV_Global_Market_Intelligence.twbx"
) else (
    start "" "%~dp0EV_Global_Market_Intelligence.twbx"
)
goto end

:push_github
echo.
echo [GITHUB] Launching GitHub Auto-Publisher...
powershell.exe -ExecutionPolicy Bypass -File "%~dp0scripts\push_to_github.ps1"
pause
goto end

:open_vscode
echo.
echo [VS CODE] Opening project in VS Code...
code "%~dp0"
goto end

:open_folder
start "" "%~dp0"
goto end

:end
echo.
echo Done. Press any key to exit.
pause >nul
