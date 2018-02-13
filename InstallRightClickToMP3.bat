:: --------------------------------------------------------
::	This script creates a right-click context menu entry
::	to execute LAME WAV-MP3 encoding on WAV files
::
::	strider@striderwhite.com
:: --------------------------------------------------------

::cfg -- this sets the working directory back to where the script was run
::otherwise, running as admin sets working dir to system32
::https://www.codeproject.com/Tips/119828/Running-a-bat-file-as-administrator-Correcting-cur
@setlocal enableextensions
@cd /d "%~dp0"

::change this if you wish to install elsewhere
set installPath=%programfiles%\RightClickToMp3\

::xcopy LAME.exe and supporting files into new directory %programfiles%/RightClickToMp3/
::flags: ignore errors, verify files, supress confirms
xcopy "%cd%\lame.exe" "%installPath%" /c /v /y /q
xcopy "%cd%\lame_enc.dll" "%installPath%" /c /v /y /q
xcopy "%cd%\mp3ico.ico" "%installPath%" /c /v /y /q


::add command for files
::reg add "HKCR\.WAV\shell\"
reg add "HKCR\*\shell\RightClickToMp3" /ve /d "Convert to MP3"
reg add "HKCR\*\shell\RightClickToMp3" /v Icon /t REG_EXPAND_SZ /d "%installPath%mp3ico.ico"
::reg add "HKCR\.WAV\shell\RightClickToMp3\command" 
reg add "HKCR\*\shell\RightClickToMp3\command" /ve /d "cmd.exe /K %installPath%lame.exe \"%%1\" \"%%1\" --preset insane" /f
::reg add "HKCR\.wav\shell\RightClickToMp3\command" /ve /d "cmd.exe /K %installPath%lame.exe \"%%1\" \"%%1\".wav --preset insane" /f

::add reg key for icon

pause

::reg add "HKCR\*\shell\FindHandle\command" /ve /d "cmd.exe /K %handlePath% \"%%1\" /f


:: this resulting reg key works
:: cmd.exe /K C:\"Program Files"\RightClickToMp3\lame.exe "%1" "%1".wav --preset insane