@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo   SoftHubCC.github.io Auto Push
echo ========================================
echo.

:: --- Check git ---
git --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Git not found.
    pause
    exit /b 1
)

:: --- Check if there are changes ---
set "HAS_CHANGES=0"
for /f "delims=" %%f in ('git status --porcelain 2^>nul') do set "HAS_CHANGES=1"

if "%HAS_CHANGES%"=="0" (
    echo [INFO] Working tree clean, skip commit.
) else (
    echo [INFO] Changes detected, preparing commit...
    echo [COMMIT] auto release
    git add -A
    git commit -m "auto release %date% %time%"
    if errorlevel 1 (
        echo [ERROR] Commit failed.
        pause
        exit /b 1
    )
)

:: --- Push ---
echo [PUSH] origin main ...
git push origin main
if errorlevel 1 (
    echo.
    echo [ERROR] Push failed.
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Push Success!
echo   Preview: https://softhubcc.github.io
echo ========================================
echo.
pause
