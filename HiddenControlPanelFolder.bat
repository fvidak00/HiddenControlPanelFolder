cls
@ECHO OFF
title Folder Locker

rem Don't change this variable
set justDoNot="Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"

rem folderName is well, a name of a hidden folder, can use different one, of course. So just switch "Source" with anything. Don't overkill it
set folderName=Source

rem Location of desired folder, preferably not on System disk
set folderLocation=D:\User

rem Location of a folder which should open when fake password is inputed, for security purposes ;)
set fakeFolderLocation=Documents\User

rem truePassword should open desired, hidden folder while fakePassword should open fake, dummy one for above mentioned security reasons :)
set truePassword=truePassword
set fakePassword=fakePassword

cd %folderLocation%

if EXIST %justDoNot% goto UNLOCK
if NOT EXIST %folderName% goto MDLOCKER

:CONFIRM
echo Want to lock the folder (Y/N) or open it (O)?
set/p "cho=>"
if %cho%==Y goto LOCK
if %cho%==y goto LOCK
if %cho%==n goto END
if %cho%==N goto END
if %cho%==O goto OPEN
if %cho%==o goto OPEN
echo Invalid choice.
timeout /t 1
goto CONFIRM

:LOCK
ren %folderName% %justDoNot%
attrib +h +s %justDoNot%
echo Folder locked
timeout /t 1
goto END

:UNLOCK
rem The one who wrote this should know what do do now (input password). For others "Yeah?" tells nothing
echo Yeah?
set/p "pass=>"
rem Desired password(s)
if %pass%==%fakePassword% goto OPENFAKE
if NOT %pass%==%truePassword% goto FAIL
attrib -h -s %justDoNot%
ren %justDoNot% %folderName%
echo Folder Unlocked successfully
timeout /t 1
cd %folderName%
explorer .
goto END

:FAIL
echo Invalid
timeout /t 1
goto END

:OPEN
cd %folderName%
explorer .
goto END

:MDLOCKER
md %folderName%
goto END

:OPENFAKE
echo Folder Unlocked successfully
timeout /t 1
cd %fakeFolderLocation%
explorer .
goto END

:END