@echo off
setlocal enabledelayedexpansion

REM Ensure bin and src\glfw directories exist
if not exist "bin" mkdir bin
if not exist "src\glfw" mkdir src\glfw

REM Check if GLFW is already downloaded (by checking for include dir)
if not exist "src\glfw\include" (
    echo Downloading GLFW...
    powershell -Command "Invoke-WebRequest -Uri 'https://github.com/glfw/glfw/releases/download/3.4/glfw-3.4.bin.WIN64.zip' -OutFile 'src\glfw\glfw-3.4.bin.WIN64.zip'"
    
    echo Extracting GLFW...
    powershell -Command "Expand-Archive -Path 'src\glfw\glfw-3.4.bin.WIN64.zip' -DestinationPath 'src\glfw\extracted' -Force"
    
    echo Moving GLFW files...
    xcopy /E /I /Y "src\glfw\extracted\glfw-3.4.bin.WIN64\include" "src\glfw\include"
    xcopy /E /I /Y "src\glfw\extracted\glfw-3.4.bin.WIN64\lib-mingw-w64" "src\glfw\lib-mingw-w64"
    
    echo Cleaning up GLFW zip and extracted folder...
    del "src\glfw\glfw-3.4.bin.WIN64.zip"
    rmdir /S /Q "src\glfw\extracted"
) else (
    echo GLFW already downloaded.
)

echo Compiling...
g++ -std=c++17 -o bin\App.exe src\Main.cpp src\src\glad.c -Isrc\include -Isrc\glfw\include -Lsrc\glfw\lib-mingw-w64 -lglfw3 -lgdi32 -lopengl32 -mwindows -mconsole

if %ERRORLEVEL% equ 0 (
    echo Build successful. App.exe created in bin\
) else (
    echo Build failed.
    exit /b %ERRORLEVEL%
)

endlocal
