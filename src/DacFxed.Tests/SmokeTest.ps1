﻿param([string]$newVersion)

$root = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
Write-Host "root: $($root)"

Start-Process -Wait -FilePath powershell.exe "$($root)\Deploy\Setup.ps1 TedBert"

Write-Host "started tedbert...."

Start-Process -Wait -FilePath powershell.exe "$($root)\..\DacFxed\DacFxed\UpdateModuleVersion.ps1 1.9.$($newVersion) $($root)\..\DacFxed\DacFxed\bin\Release $($root)\..\DacFxed\DacFxed\bin\Deploy\DacFxed\1.9.$($newVersion)"

Write-Host "done the version stuff"

cp -Path "$($root)\..\DacFxed\DacFxed\bin\Deploy\DacFxed\1.9.$($newVersion)" -Destination "$($env:USERPROFILE)\Documents\WindowsPowershell\Modules\DacFxed" -Verbose

Write-Host "done copying..."

Get-Module -ListAvailable

Start-Process -Wait -FilePath powershell.exe "$($root)\Deploy\Deploy.ps1 $($root)\..\TestDacPac\bin\Release\TestDacPac.dacpac abc -verbose"



Write-Host "all done???"