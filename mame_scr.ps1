<#	
	.NOTES
	===========================================================================
	 Created with:  		PowerShell Studio 2019 5.6.156
	 Created by:			Justin Baker
	 Filename:			mame_scr.ps1
	 Website:				https://github.com/kaband/Mame-Screensaver
	===========================================================================
#>

Function Get-MyDir
{
<#
	.SYNOPSIS
		Get-MyDir returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
		Credit: From Sapien Tools Powershell Studio
#>
	[OutputType([string])]
	param ()
	if ($null -ne $hostinvocation)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

[string]$mydir = Get-MyDir
[psobject]$config = Get-Content -path "$mydir\mame_scr.ini"
[array]$cfgattributes = @("mamepath","rompath","romlistpath","configpath","snapshotpath","nvrampath","arguments","runtime","volume")
$cfg = @{ }
$cmdargs = @()

foreach ($line in $config)
{
	foreach ($attribute in $cfgattributes)
	{
		$regex = "^\s{0,}($attribute)\s{0,}=\s{0,}(.*)\s{0,}"
		if ($line -match $regex)
		{
			switch ($Matches[1])
			{
				"mamepath" {
					$cfg.mamepath = $Matches[2]
				}
				"rompath" {
					$cfg.rompath = $Matches[2]
				}
				"romlistpath" {
					$cfg.romlistpath = $Matches[2]
				}
				"configpath" {
					$cfg.configpath = $Matches[2]
				}
				"snapshotpath" {
					$cfg.snapshotpath = $Matches[2]
				}
				"nvrampath" {
					$cfg.nvrampath = $Matches[2]
				}
				"arguments" {
					$cfg.arguments = $Matches[2]
				}
				"runtime" {
					$cfg.runtime = $Matches[2]
				}
				"volume" {
					$cfg.volume = $Matches[2]
				}
			}
			break
		}
	}
}

if ($cfg.rompath)
{
	$cmdargs += " -rompath $($cfg.rompath)"
}

if ($cfg.configpath)
{
	$cmdargs += " -cfg_directory $($cfg.configpath)"
}

if ($cfg.snapshotpath)
{
	$cmdargs += " -snapshot_directory $($cfg.snapshotpath)"
}

if ($cfg.nvrampath)
{
	$cmdargs += " -nvram_directory $($cfg.nvrampath)"
}

if ($cfg.runtime)
{
	$cmdargs += " -str $($cfg.runtime)"
}

if ($cfg.volume)
{
	$cmdargs += " -volume $($cfg.volume)"
}

if ($cfg.arguments)
{
	$cmdargs += " $($cfg.arguments)"
}

[int]$running = 1
[psobject]$romlist = Get-Content $cfg.romlistpath
[int]$count = $romlist.count
[int]$exittime = $cfg.runtime - 1
[int]$i = 0

# Get rid of old .out file if present
Remove-Item -Path $env:TEMP\mame_scr.out -Force -ErrorAction SilentlyContinue
Remove-Item -Path $env:TEMP\mame_scr.err -Force -ErrorAction SilentlyContinue

do
{
	$rnd = get-random -minimum 0 -maximum ($romlist.count - 1)
	Write-Output "$($cfg.mamepath) $($romlist[$rnd]) $cmdargs"
	
	try
	{
		Start-Process -FilePath $cfg.mamepath -ArgumentList "$($romlist[$rnd]) $cmdargs" -RedirectStandardOutput $env:TEMP\mame_scr.out -RedirectStandardError $env:TEMP\mame_scr.err -Wait -ErrorAction Stop -WindowStyle Minimized
		$output = Get-Content $env:TEMP\mame_scr.out
		$outputerr = Get-Content $env:TEMP\mame_scr.err
		
		if (($output -notmatch "\($exittime Seconds\)" -and $output -match "\(\d{1,3} Seconds\)") -or ($output -eq $null -and $outputerr -eq $null))
		{
			$running = 0
		}
		elseif ($outputerr -ne $null)
		{
			Write-Output "$($romlist[$rnd]) - Something is wrong w. this rom"
			Remove-Item -Path $env:TEMP\mame_scr.out -Force
			Remove-Item -Path $env:TEMP\mame_scr.err -Force
		}
		else
		{
			Remove-Item -Path $env:TEMP\mame_scr.out -Force
			Remove-Item -Path $env:TEMP\mame_scr.err -Force			
		}
	}
	catch
	{
		Write-Output "$($romlist[$rnd]) - Something is wrong w. this rom"
	}
	<#if ($i -ge 3)
	{
		$running = 0
	}
	$i++
	#>
}
while ($running -eq 1)