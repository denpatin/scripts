REM Batch to start/stop iTunes with corresponding services^

IF "%1" == "stop" (
  taskkill /IM iTunes.exe
  sc stop "iPod Service"
  sc stop "Bonjour Service"
  sc stop "Apple Mobile Device Service"
  sc config "iPod Service" start= disabled
  sc config "Bonjour Service" start= disabled
  sc config "Apple Mobile Device Service" start= disabled
  ECHO Successfully stopped all the iTunes related processes!
) ELSE (
  FOR /F "tokens=3 delims=: " %%H in ('sc query "iPod Service" ^| findstr "        STATE"') do (
    IF /I "%%H" NEQ "RUNNING" (
      sc config "iPod Service" start= demand
      sc start "iPod Service"
    )
  )
  FOR /F "tokens=3 delims=: " %%H in ('sc query "Bonjour Service" ^| findstr "        STATE"') do (
    IF /I "%%H" NEQ "RUNNING" (
      sc config "Bonjour Service" start= demand
      sc start "Bonjour Service"
    )
  )
  FOR /F "tokens=3 delims=: " %%H in ('sc query "Apple Mobile Device Service" ^| findstr "        STATE"') do (
    IF /I "%%H" NEQ "RUNNING" (
      sc config "Apple Mobile Device Service" start= demand
      sc start "Apple Mobile Device Service"
    )
  )
  START "iTunes" /D "C:\Program Files\iTunes\" "iTunes.exe"
)
