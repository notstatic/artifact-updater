@echo off
setlocal EnableDelayedExpansion

:: Set directories
set found=0

set artifact_page=artifact_page.html
set server_dir=D:\FiveM
set artifact_dir=%server_dir%\artifact
set temp_dir=%server_dir%\temp
set temp_file=%temp_dir%\temp_file.txt
set artifact_path=%temp_dir%\server.zip
set artifact_link=https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/
set pattern="./[0-9][0-9][0-9][0-9]-[a-z0-9]*\/server\.7z"

if not exist "%temp_dir%" mkdir "%temp_dir%"
curl -L %artifact_link% -o "%temp_dir%\%artifact_page%" || (
    echo Download failed. Please check the URL and internet connection.
    exit /b 1
)

if exist "%temp_dir%\%artifact_page%" (
    echo Checking for new artifact...
    set found=0

    for /f "delims=" %%a in ('type "%temp_dir%\%artifact_page%" ^| findstr /i /c:"is-active"') do (
        if !found! == 0 (
            echo %%a > "%temp_file%"
            set found=1
        )
    )

    if !found! == 1 (
        echo Found the correct element and created temporary file %temp_file%
    ) else (
        echo Unable to check the artifact version...
    )

    findstr /R "%pattern%" %temp_file% >nul
    if !errorlevel! equ 0 (
        echo Found:
        for /f "tokens=2 delims=./" %%a in ('type %temp_file% ^| findstr /R "%pattern%"') do (
            echo %%a
            set "artifact_link=%artifact_link%/%%a/server.zip"
        )
    )
    curl -L !artifact_link! -o "%artifact_path%" || (
        echo Download failed. Please check the URL and internet connection.
        exit /b 1
    )

    if exist %ARTIFACT_DIR% (
        echo Removing old artifact data
        rmdir /s /q %ARTIFACT_DIR%
    )
    
    mkdir "%ARTIFACT_DIR%"
    powershell -Command "Get-ChildItem -Path '%temp_dir%' -Filter server.zip | ForEach-Object { Expand-Archive -Path $_.FullName -DestinationPath '%ARTIFACT_DIR%' }"

    echo Cleaning temporary files
    del %temp_file%
    del "%temp_dir%\%artifact_page%""
    del %artifact_path%
    rmdir /s /q %temp_dir%
    :: add your start command below this echo
    echo Update complete, starting FiveM server...
    
) else (
    echo Unable to download artifacts site...
)

endlocal
