<#	
	.NOTES
	===========================================================================
	 Created with:  		PowerShell Studio 2019 5.6.156
	 Created by:			Justin Baker
	 Filename:			Globals.ps1
	 Website:				https://github.com/kaband/Mame-Screensaver
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
	$config = Get-Content $inifile
	$cfgattributes = @("mamepath", "rompath", "romlistpath", "configpath", "snapshotpath", "nvrampath", "arguments", "runtime", "volume")
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
	
	Return $cfg
}

# This function made possible by adam the automator - https://www.adamtheautomator.com/powershell-start-process/
function Invoke-Process
{
	<#
		.VERSION 1.4
		.GUID b787dc5d-8d11-45e9-aeef-5cf3a1f690de
		.AUTHOR Adam Bertram
		.COMPANYNAME Adam the Automator, LLC
		.TAGS Processes
	#>
	[CmdletBinding(SupportsShouldProcess)]
	param
	(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$FilePath,
		[Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$ArgumentList
	)
	
	$ErrorActionPreference = 'Stop'
	
	try
	{
		$stdOutTempFile = "$env:TEMP\$((New-Guid).Guid)"
		$stdErrTempFile = "$env:TEMP\$((New-Guid).Guid)"
		
		$startProcessParams = @{
			FilePath			   = $FilePath
			ArgumentList		   = $ArgumentList
			RedirectStandardError  = $stdErrTempFile
			RedirectStandardOutput = $stdOutTempFile
			Wait				   = $true;
			PassThru			   = $true;
			NoNewWindow		       = $true;
		}
		if ($PSCmdlet.ShouldProcess("Process [$($FilePath)]", "Run with args: [$($ArgumentList)]"))
		{
			$cmd = Start-Process @startProcessParams
			$cmdOutput = Get-Content -Path $stdOutTempFile -Raw
			$cmdError = Get-Content -Path $stdErrTempFile -Raw
			if ($cmd.ExitCode -ne 0)
			{
				if ($cmdError)
				{
					throw $cmdError.Trim()
				}
				if ($cmdOutput)
				{
					throw $cmdOutput.Trim()
				}
			}
			else
			{
				if ([string]::IsNullOrEmpty($cmdOutput) -eq $false)
				{
					Write-Output -InputObject $cmdOutput
				}
			}
		}
	}
	catch
	{
		$PSCmdlet.ThrowTerminatingError($_)
	}
	finally
	{
		Remove-Item -Path $stdOutTempFile, $stdErrTempFile -Force -ErrorAction Ignore
	}
}

[string]$mydir = Get-MyDir
[string]$mamepath = $null
[string]$rompath = $null
[string]$romlistpath = $null
[string]$configpath = $null
[string]$snapshotpath = $null
[string]$nvrampath = $null
[int]$runtime = 120
[int]$volume = 0
[string]$sspath = "c:\Windows\System32\mame_scr.scr"
[int]$sstimeout = 600

if (Test-Path "c:\Windows\System32\mame_scr.ini")
{
	[string]$inifile = "c:\Windows\System32\mame_scr.ini"
}
elseif (Test-Path "$mydir\mame_scr.ini")
{
	[string]$inifile = "$mydir\mame_scr.ini"
}
else
{
	[string]$inifile = "c:\Windows\System32\mame_scr.ini"
}