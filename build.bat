@echo off
setlocal enabledelayedexpansion

REM Default paths - modify these according to your installation
set "flexPath=C:\GnuWin32\bin\flex.exe"
set "bisonPath=C:\GnuWin32\bin\bison.exe"

REM Check if tools are in PATH
where flex.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set "flexPath=flex.exe"
    echo Found flex in PATH
) else (
    if not exist "!flexPath!" (
        echo Flex not found in PATH or specified location
        exit /b 1
    )
)

where bison.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set "bisonPath=bison.exe"
    echo Found bison in PATH
) else (
    if not exist "!bisonPath!" (
        echo Bison not found in PATH or specified location
        exit /b 1
    )
)

REM Check for VS compiler
where cl.exe >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Visual Studio compiler not found in PATH
    echo Please run this script from VS Developer Command Prompt
    exit /b 1
)

REM Create build directory if it doesn't exist
if not exist "build" mkdir build

REM Process .y files first with bison
pushd src
for %%F in (*.y) do (
    echo Processing Bison file: %%F
    "!bisonPath!" -v -g -d %%F -o "../build/%%~nF.tab.c"
    if !ERRORLEVEL! NEQ 0 (
        echo Error processing %%F
        popd
        exit /b 1
    )
    move /Y %%~nF.tab.h ..\build\ >nul
    if exist %%~nF.output move /Y %%~nF.output ..\build\ >nul
    if exist %%~nF.dot move /Y %%~nF.dot ..\build\ >nul
)

REM Process .l files with flex
for %%F in (*.l) do (
    echo Processing Flex file: %%F
    "!flexPath!" %%F
    if !ERRORLEVEL! NEQ 0 (
        echo Error processing %%F
        popd
        exit /b 1
    )
    move /Y lex.yy.c ..\build\ >nul
)
popd

REM Move to build directory for compilation
pushd build
for %%F in (*.tab.c) do (
    echo Compiling: %%~nF
    cl lex.yy.c %%F /Fe:%%~nF.exe
    if !ERRORLEVEL! NEQ 0 (
        echo Error compiling %%~nF
        popd
        exit /b 1
    )
)
popd

echo Build completed successfully
exit /b 0