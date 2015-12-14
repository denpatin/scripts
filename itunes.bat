REM Batch to start/stop iTunes with corresponding services^

set ITUNES_SERVICES=("iPod Service" "Bonjour Service" "Apple Mobile Device Service")

tasklist | find /I /N "iTunes.exe"

IF "%ERRORLEVEL%"=="0" (
  taskkill /IM "iTunes.exe"
  FOR %%G IN %ITUNES_SERVICES% DO (
    sc stop %%G
    sc config %%G start= disabled
  )
) ELSE (
  FOR %%G IN %ITUNES_SERVICES% DO (
    FOR /F "tokens=3 delims=: " %%H in ('sc query %%G ^| findstr "        STATE"') do (
      IF /I "%%H" NEQ "RUNNING" (
        sc config %%G start= demand
        sc start %%G
      )
    )
  )
  START "iTunes" /D "C:\Program Files\iTunes\" "iTunes.exe"
)
