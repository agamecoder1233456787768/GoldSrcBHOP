@echo off
REM --- Garry's Mod Auto-Jump HOLD Script Deployment ---
REM This script creates an AutoHotkey (.ahk) script to enable continuous 
REM jump spamming while you HOLD the spacebar.

echo #######################################################
echo # GMOD HOLD-TO-JUMP (NOT A TOGGLE) BIND SETUP #
echo #######################################################
echo.
echo This requires AutoHotkey to be installed (External Macro).
echo It will create a script that spams 'Jump' while you HOLD SPACE.
echo.
pause

REM Define the target folder (placing it in the GMod folder for easy access)
REM !!! IMPORTANT: VERIFY THIS PATH MATCHES YOUR STEAM INSTALLATION !!!
set "GMOD_DIR=C:\Program Files (x86)\Steam\steamapps\common\GarrysMod\garrysmod"
set "AHK_FILE=%GMOD_DIR%\hold_to_bhop.ahk"

echo.
echo The AutoHotkey script will be created at:
echo %AHK_FILE%
echo.

REM --- PATH CHECK AND ERROR HANDLING ---
if not exist "%GMOD_DIR%" (
    echo =======================================================
    echo [CRITICAL ERROR] The Garry's Mod folder was NOT found!
    echo =======================================================
    echo The script cannot proceed. Please edit this .bat file and CORRECT the 'GMOD_DIR' variable.
    pause
    exit /b 1
)

echo [SUCCESS] GMod folder found.

REM --- WRITE THE AUTOHOTKEY SCRIPT FILE (.ahk) ---
echo Writing AutoHotkey script to 'hold_to_bhop.ahk'...

(
    echo #NoEnv
    echo #Warn
    echo SendMode Input
    echo SetWorkingDir %%A_ScriptDir%%
    echo.
    echo // Target GMod executable (hl2.exe)
    echo #IfWinActive, ahk_exe hl2.exe 
    echo.
    echo // When Spacebar is pressed, start a loop
    echo *Space::
    echo Loop {
    echo     // Check if the Spacebar key is still physically being held down
    echo     GetKeyState, state, Space, P
    echo     if state = U // U means 'Up' or released. If released, break the loop.
    echo         break
    echo     // Send a Jump input
    echo     Send, {Space}
    echo     Sleep, 10 // Wait 10ms before sending the next jump (adjust this number if needed)
    echo }
    echo return
    echo.
    echo #IfWinActive
) > "%AHK_FILE%"

echo.
echo =======================================================
echo [COMPLETE] Script Deployment Complete.
echo =======================================================
echo.
echo 1. Launch Garry's Mod.
echo 2. DOUBLE-CLICK the file "%AHK_FILE%" to activate the script.
echo 3. The script will ONLY work while the GMod window is active.
echo 4. Press and HOLD the SPACEBAR to continuously jump.
echo.
pause
