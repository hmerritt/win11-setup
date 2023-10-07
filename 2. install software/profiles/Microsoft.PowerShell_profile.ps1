# Powershell profile.
#
# Location: C:\Users\%USERNAME%\Documents\Powershell


### >>>>>>>>>  Set title to current directory  <<<<<<<<< ###
function Invoke-Starship-PreCommand {
  $host.UI.RawUI.WindowTitle = Split-Path -Path (Get-Location) -Leaf
}


### >>>>>>>>>              Plugins             <<<<<<<<< ###
Invoke-Expression (&starship init powershell)
Invoke-Expression (&scoop-search --hook)


### >>>>>>>>>              Aliases             <<<<<<<<< ###
Set-Alias which gcm
Set-Alias dl aria2c
Set-Alias yt yt-dlp


### >>>>>>>>>          Custom functions        <<<<<<<<< ###
#function dl {
#  aria2c @args
#}
