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
function encode {
	#
	# Quickly encode video with `hevc_nvenc`
	#
	[CmdletBinding()]
    param(
        [string]$inputVideo = "",
        [int]$qp = 25,
		[string]$outputVideo = ""
    )

    if ([string]::IsNullOrWhiteSpace($outputVideo)) {
        $outputVideo = "output.${qp}.mp4"
    }
	
	Write-Host "Encode [hevc_nvenc/${qp} ${inputVideo} -> ${outputVideo}]"
	Write-Host ""

    if ([string]::IsNullOrWhiteSpace($inputVideo)) {
		Write-Host "ERROR: Input video not provided"
		Write-Host ""
		Write-Host "Help:"
		Write-Host "$ encode <input file> <quality level (15-40)> <output file>"
		Write-Host "$ encode input.mp4 25 output.mp4"
        return
    }

	Write-Host "Input:   ${inputVideo}"
	Write-Host "Quality: ${qp}"
	Write-Host "Output:  ${outputVideo}"
	Write-Host ""

    ffmpeg -i "${inputVideo}" -c:a copy -c:v hevc_nvenc -qp "${qp}" -preset p7 -multipass fullres "${outputVideo}"
}
