@echo off
:: =====================================================================
:: Google Play Store Insights — Local HTTP Server Startup Script
:: Created for Windows. Run this script to serve the dashboard locally
:: so that automatic CSV loading works correctly.
::
:: Requirements: Python 3 (comes with Windows from the Microsoft Store,
::               or install from https://www.python.org/downloads/)
::
:: Usage:
::   1. Double-click start-server.bat  (or run it from a terminal)
::   2. Open http://localhost:8080 in your browser
::   3. The dashboard will load googleplaystore.csv automatically
::   4. Press Ctrl+C in this window to stop the server
:: =====================================================================

setlocal

set PORT=8080

echo.
echo  Google Play Store Insights — App Market Analytics Dashboard
echo  -----------------------------------------------------------
echo  Starting local HTTP server on port %PORT%...
echo.

:: Try Python 3 first (preferred)
where python >nul 2>&1
if %errorlevel% == 0 (
    python --version 2>&1 | find "Python 3" >nul
    if %errorlevel% == 0 (
        echo  Python 3 found. Starting server with Python...
        echo  Open your browser and go to: http://localhost:%PORT%
        echo  Press Ctrl+C to stop.
        echo.
        python -m http.server %PORT%
        goto :done
    )
)

:: Try py launcher (common on Windows)
where py >nul 2>&1
if %errorlevel% == 0 (
    echo  Python launcher (py) found. Starting server...
    echo  Open your browser and go to: http://localhost:%PORT%
    echo  Press Ctrl+C to stop.
    echo.
    py -3 -m http.server %PORT%
    goto :done
)

:: Try python3 explicitly
where python3 >nul 2>&1
if %errorlevel% == 0 (
    echo  python3 found. Starting server...
    echo  Open your browser and go to: http://localhost:%PORT%
    echo  Press Ctrl+C to stop.
    echo.
    python3 -m http.server %PORT%
    goto :done
)

:: Python not found — show helpful error
echo.
echo  ERROR: Python 3 was not found on this system.
echo.
echo  To fix this, install Python 3 from one of these sources:
echo    - Microsoft Store: search for "Python 3" and install it
echo    - https://www.python.org/downloads/
echo.
echo  After installing Python, run this script again.
echo.
echo  Alternative: If you have Node.js installed, run:
echo    npx serve .
echo  and open http://localhost:3000
echo.
pause

:done
endlocal
