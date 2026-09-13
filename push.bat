@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "PYTHONIOENCODING=utf-8"
set "PYTHONUTF8=1"

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
    for /f "usebackq delims=" %%t in ("%~dp0releases\github_token.txt") do set "GH_TOKEN=%%t"
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
    set "MSG=auto release"
    if exist "%~dp0msg.txt" (
        for /f "usebackq delims=" %%l in ("%~dp0msg.txt") do if not defined MSG set "MSG=%%l"
    )
    if not defined MSG (
        set "MSG=auto release %date:~0,10% %time:~0,5%"
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
