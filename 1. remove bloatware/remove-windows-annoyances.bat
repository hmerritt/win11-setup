

echo Uninstalling OneDrive

taskkill /f /im OneDrive.exe
%windir%\SysWOW64\OneDriveSetup.exe /uninstall
rmdir "%UserProfile%\OneDrive" "%ProgramData%\Microsoft OneDrive" "%LocalAppData%\Microsoft\OneDrive" "C:\OneDriveTemp" /S /Q
reg delete "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
reg delete "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f




echo Disabling Windows Defender

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t "REG_DWORD" /d "1" /f




echo Disable Cortana and Web Search

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f




echo Disable Xbox Bar

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t "REG_DWORD" /d "0" /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t "REG_DWORD" /d "0" /f




echo Disable 3D Objects
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f