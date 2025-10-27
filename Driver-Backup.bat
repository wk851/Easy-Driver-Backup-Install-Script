@echo off
:: BatchGotAdmin (Run as Admin code starts)
REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
:: BatchGotAdmin (Run as Admin code ends)
:: Your codes should start from the following line

cls
echo.
echo Start Driver Backup of System Drivers
echo.

setlocal enabledelayedexpansion

REM Define URLs and paths
set backup=C:\Users\%Username%\Desktop\DriverBackup\Install-all-drivers.bat

REM Ensure the temp folder exists
if not exist "C:\Users\%Username%\Desktop\DriverBackup" mkdir "C:\Users\%Username%\Desktop\DriverBackup"

REM Create the Bat file
echo Creating the Bat file...
(
    echo   pnputil /add-driver *.inf /install /subdirs
    echo
    echo   echo.
    echo   echo Finished.
    echo   echo.
    echo   echo Reboot after pressing button.
    echo   echo.
    echo  
    echo   shutdown /r /t 3 
) > "%backup%"


cd C:\Users\%Username%\Desktop

dism /online /export-driver /destination:"C:\Users\%Username%\Desktop\DriverBackup"


echo.
echo Finished.

