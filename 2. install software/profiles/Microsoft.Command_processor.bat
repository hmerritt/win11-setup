@echo off
::
:: CMD set profile.
::
:: 1. Regedit `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Command Processor`
:: 2. Add key `Autorun` with string value with the location of this file


:: >>>>>>>>>              Aliases             <<<<<<<<< ::
DOSKEY which=where $*
DOSKEY dl=aria2c $*
DOSKEY yt=yt-dlp $*
