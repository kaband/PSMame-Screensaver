<#	
	.NOTES
	===========================================================================
	 Created with:  		PowerShell Studio 2019 5.6.156
	 Created by:			Justin Baker
	 Filename:			Globals.ps1
	 Website:				https://github.com/kaband/PSMame-Screensaver
	===========================================================================
#>

#--------------------------------------------
# Declare Global Variables and Functions here
#--------------------------------------------

function Get-MyDir
{
<#
	.SYNOPSIS
		Get-ScriptDirectory returns the proper location of the script.

	.OUTPUTS
		System.String
	
	.NOTES
		Returns the correct path within a packaged executable.
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

function Get-ini
{
	param
	(
		[parameter(Mandatory = $true)]		
		[string]$inifile
	)
	$config = Get-Content $inifile
	$cfgattributes = @("mamepath", "rompath", "romlistpath", "configpath", "nvrampath", "arguments", "masterplaystlist", "destinationplaylist", "runtime", "volume","masterplaylist","destinationplaylist")
	$cfg = @{ }
	
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
					"masterplaylist" {
						$cfg.masterplaylist = $Matches[2]
					}
					"destinationplaylist" {
						$cfg.destinationplaylist = $Matches[2]
					}
				}
				break
			}
		}
	}
	
	Return $cfg
}

function Load-Defaults
{
	$textboxMamePath.Text = "c:\mame\mame64.exe"
	$textboxROMPath.Text = "c:\mame\roms"
	$textboxromlistpath.Text = "c:\mame\romlist.txt"
	$textboxConfigPath.Text = "c:\mame\cfg"
	$textboxnvrampath.Text = "c:\mame\nvram"
	$textboxMasterplaylist.Text = $null
	$textboxDestinationplaylist.Text = $null
	$textboxArguments.Text = $null
	$numericruntime.Value = 120
	$numericVolume.Value = -32
}

[string]$mydir = Get-MyDir
[string]$mamepath = $null
[string]$rompath = $null
[string]$romlistpath = $null
[string]$configpath = $null
[string]$nvrampath = $null
[string]$inifile = $null
[string]$masterplaylist = $null
[string]$destinationplaylist = $null
[int]$runtime = 120
[int]$volume = 0
[string]$sspath = "c:\Windows\System32\psmamess.scr"
[int]$sstimeout = 600

