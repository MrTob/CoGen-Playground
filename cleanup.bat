@echo off
REM Set the build folder path
set buildPath=build

REM Check if build folder exists
if not exist "%buildPath%" (
    echo Build folder does not exist.
    exit /b 0
)

REM Set file extensions to delete
set fileExtensions=.c .obj .dot .output .h .exe .tab.c .tab.h .yy.c

REM Loop through the file extensions and delete the files
for %%F in (%fileExtensions%) do (
    del /F /Q "%buildPath%\*%%F"
)

REM Display a message when the files have been deleted
echo All generated files have been deleted from the %buildPath% folder.

REM Optionally remove the build folder itself if empty
rd /q "%buildPath%" 2>nul
if errorlevel 1 (
    echo Build folder contains other files and was not removed.
) else (
    echo Empty build folder was removed.
)