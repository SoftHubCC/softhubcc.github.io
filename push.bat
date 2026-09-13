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

:: --- Check GitHub Token ---
set "GH_TOKEN="
if exist "%~dp0releases\github_token.txt" (
    set /p GH_TOKEN=<"%~dp0releases\github_token.txt"
)
if "%GH_TOKEN%"=="" (
    echo [ERROR] Token file not found at releases\github_token.txt
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

    :: --- Read commit message ---
    set "MSG="
    if exist "%~dp0msg.txt" (
        set /p MSG=<"%~dp0msg.txt"
    )
    if "%MSG%"=="" (
        set "MSG=auto release %date% %time%"
    )

    echo [COMMIT] %MSG%
    git add -A
    git commit -m "%MSG%"
    if errorlevel 1 (
        echo [ERROR] Commit failed.
        pause
        exit /b 1
    )
)

:: --- Push ---
echo [PUSH] origin main ...
git -c http.sslBackend=schannel ^
    -c http.schannelCheckRevoke=false ^
    -c "http.extraHeader=Authorization: Basic %GH_TOKEN%" ^
    push origin main
if errorlevel 1 (
    echo.
    echo [ERROR] Push failed. Check network or Token.
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
