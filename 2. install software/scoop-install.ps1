
echo "Installing Scoop"


Set-ExecutionPolicy RemoteSigned -scope CurrentUser
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

refreshenv

scoop install git
scoop bucket add extras
scoop bucket add nonportable
scoop bucket add hmerritt https://github.com/hmerritt/scoop-bucket
