REM Preparing the working environment for KLS

%SystemRoot%\explorer.exe "%UserProfile%\Desktop\KLS"
START "Oracle SQL Developer" /D "C:\sqldeveloper\" "sqldeveloper.exe"
START "WinSCP" /D "%ProgramFiles(x86)%\WinSCP\" "WinSCP.exe" KLS_DEV
START "PuTTY" /B /D "%UserProfile%\Desktop\" "putty.exe" -load kls_dev -m "%UserProfile%\kls.txt" -t
