echo off
REM --- Garry's Mod CFG Installation Script (Fixing 'wait' command issue) ---
echo #######################################################
echo # GMOD CONFIGURATION INSTALLER (WAIT COMMAND FIX) #
echo #######################################################
echo.
echo Installing Auto-Jump Toggle Binds...
echo This script also enables 'sv_allow_wait_command' needed for jump spam.
echo.
pause

REM !!! IMPORTANT: VERIFY THIS PATH MATCHES YOUR STEAM INSTALLATION !!!
REM If your Steam is not in 'C:\Program Files (x86)\', you MUST edit this line.
set "GMOD_DIR=C:\Program Files (x86)\Steam\steamapps\common\GarrysMod\garrysmod"
set "CFG_DIR=%GMOD_DIR%\cfg"
set "CFG_FILE=%CFG_DIR%\autoexec.cfg"

echo Target CFG folder: %CFG_DIR%
echo.

REM --- PATH CHECK AND ERROR HANDLING ---
if not exist "%CFG_DIR%" (
    echo =======================================================
    echo [CRITICAL ERROR] The Garry's Mod CFG folder was NOT found!
    echo =======================================================
    echo The script cannot proceed. The path specified was:
    echo "%CFG_DIR%"
    echo.
    echo Please EDIT this .bat file and CORRECT the 'GMOD_DIR' variable to match your installation.
    echo.
    pause
    exit /b 1
)

echo [SUCCESS] Configuration folder found.

REM --- WRITE THE AUTOEXEC.CFG FILE CONTENT ---
echo Writing auto-jump toggle binds to autoexec.cfg...

(
    echo // --- GMOD AUTO-JUMP TOGGLE CFG (Installed by Batch Script) ---
    echo // Toggles continuous jumping. Press SPACE to start, press SPACE to stop.
    echo.
    
    // Crucial command: Enables the 'wait' command needed for this alias to loop
    echo sv_allow_wait_command 1
    echo.
    
    REM Define the ON state: start jump spam loop and set the toggle alias to OFF.
    echo alias autojump_on "+jump; wait; -jump; wait; autojump_on"
    
    REM Define the OFF state: stop jump spam and set the toggle alias to ON.
    echo alias autojump_off "alias autojump_toggle autojump_on; -jump; echo Auto-Jump OFF"
    
    REM Initialize the toggle state to OFF when the game starts.
    echo autojump_off
    echo.
    
    REM Bind the Spacebar to the toggle alias.
    echo bind "space" "autojump_toggle"
    echo.
    
    echo echo "--- GMOD AUTO-JUMP TOGGLE CONFIGURED: Bind 'space' to start/stop ---"
) > "%CFG_FILE%"

echo.
echo =======================================================
echo [INSTALLATION COMPLETE]
echo =======================================================
echo The 'autoexec.cfg' file has been successfully installed.
echo.
echo Launch Garry's Mod. **Tap SPACE** once to start jumping, **tap SPACE** again to stop.
pause
