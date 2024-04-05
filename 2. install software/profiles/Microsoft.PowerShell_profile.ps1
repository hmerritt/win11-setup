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
Set-Alias ff encode
Set-Alias yt yt-dlp


### >>>>>>>>>          Custom functions        <<<<<<<<< ###

#
# Start a DLNA video stream server in the current directory.
#
function vstream {
	if (-not (Get-Command -Name "dms" -ErrorAction SilentlyContinue)) {
		Write-Host "dms not found. Installing..."
		go get github.com/anacrolix/dms
		go install github.com/anacrolix/dms
	}
	dms -noTranscode $args
}

#
# Quickly encode video with `hevc_nvenc`
#
function encode {
	[CmdletBinding()]
    param(
				[string]$inputVideo = "",
				[int]$qp = 25,
				[string]$volume = "1.0",
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

    ffmpeg -i "${inputVideo}" -c:a aac -b:a 320k -c:v hevc_nvenc -filter:a "volume=${volume}" -qp "${qp}" -preset p7 -multipass fullres -pix_fmt yuv420p "${outputVideo}"
}

#
# Quickly encode (either video or audio) to WAV
#
function towav {
	[CmdletBinding()]
    param(
			[string]$inputFile = "",
			[string]$outputFile = ""
    )

	if ([string]::IsNullOrWhiteSpace($outputFile)) {
		$outputFile = "audio.wav"
	}

	$outputFile = $outputFile + ".wav"
	$outputFile = $outputFile -replace '.wav.wav','.wav'
	
	Write-Host "To WAV [${inputFile} -> ${outputFile}]"
	Write-Host ""

	if ([string]::IsNullOrWhiteSpace($inputFile)) {
		Write-Host "ERROR: Input video not provided"
		Write-Host ""
		Write-Host "Help:"
		Write-Host "$ towav <input file> <output file>"
		Write-Host "$ towav input.mp4 output.wav"
		return
	}

	ffmpeg -i "${inputFile}" "${outputFile}"
}

#
# Download from YT straight into WAV
#
function ytwav {
	[CmdletBinding()]
    param(
			[string]$ytLink = "",
			[string]$outputFile = ""
    )

	if ([string]::IsNullOrWhiteSpace($outputFile)) {
		$ytVideoTitle = yt --no-warnings --get-title "${ytLink}"
		$outputFile = "${ytVideoTitle}.wav"
	}

	$ytFile = "_video.tmp"
	$outputFile = $outputFile + ".wav"
	$outputFile = $outputFile -replace '.wav.wav','.wav'
	
	Write-Host "YouTube to WAV [${ytLink} -> ${outputFile}]"
	Write-Host ""

	if ([string]::IsNullOrWhiteSpace($ytLink)) {
		Write-Host "ERROR: Input video not provided"
		Write-Host ""
		Write-Host "Help:"
		Write-Host "$ ytwav <yt link> <output file>"
		Write-Host "$ ytwav https://youtu.be/E12QZbWtjgY output.mp4"
		return
	}

	yt "${ytLink}" -o "${ytFile}"

	# Get exact filename of downloaded file (YT will add an unknown extension: mp3, webm, etc...)
	$downloadedFile = Get-ChildItem -Path . -Filter "${ytFile}.*" | Select-Object -ExpandProperty Name
	if ([string]::IsNullOrWhiteSpace($ytLink)) {
		Write-Host "ERROR: Can't find the downloaded file"
		Write-Host ""
		Write-Host "Help:"
		Write-Host "$ ytwav <yt link> <output file>"
		Write-Host "$ ytwav https://youtu.be/E12QZbWtjgY output.mp4"
		return
	}

	towav "${downloadedFile}" "${outputFile}"

	Remove-Item -Path "${downloadedFile}" -Force -Confirm:$false
}

#
# Download from YT straight into FLAC (16bit + amplify)
#
function ytflac {
	[CmdletBinding()]
    param(
			[string]$ytLink = "",
			[string]$outputFile = ""
    )

	if ([string]::IsNullOrWhiteSpace($outputFile)) {
		$ytVideoTitle = yt --no-warnings --get-title "${ytLink}"
		$outputFile = "${ytVideoTitle}.flac"
	}

	$ytFile = "_video.tmp.wav"
	$outputFile = $outputFile + ".flac"
	$outputFile = $outputFile -replace '.flac.flac','.flac'

	Write-Host "YouTube to FLAC (16bit + amplify) [${ytLink} -> ${outputFile}]"
	Write-Host ""
	
	$_ = ytwav "${ytLink}" "${ytFile}"

	ffmpeg -i "${ytFile}" -acodec flac -sample_fmt s16 -compression_level 12 -af "volume=volume=2dB:precision=fixed:eval=frame,acompressor=threshold=-3dB:ratio=4:attack=50:release=200" "${outputFile}"

	Remove-Item -Path "${ytFile}" -Force -Confirm:$false
}

