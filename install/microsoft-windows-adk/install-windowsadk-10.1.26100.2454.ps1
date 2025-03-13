#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Install Microsoft Windows ADK 10.1.26100.2454 for Windows 11 24H2
.LINK
    https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install

.NOTES
    Windows 11, version 24H2 and all earlier supported versions of Windows 10 and 11
    Windows Server 2025, and Windows Server 2022
#>

# Install Windows ADK
winget install --id Microsoft.WindowsADK -e -v 10.1.26100.2454 --accept-source-agreements --accept-package-agreements --wait --override '/features OptionId.DeploymentTools OptionId.Documentation OptionId.ImagingAndConfigurationDesigner /quiet /ceip off /norestart'

# This is not published in the winget repository yet, so need to install manually
# Install Windows PE add-on
# winget install --id Microsoft.ADKPEAddon --version 10.1.26100.2454 --exact --accept-source-agreements --accept-package-agreements --wait --override '/features OptionId.WindowsPreinstallationEnvironment /quiet /ceip off /norestart'
$Url = 'https://go.microsoft.com/fwlink/?linkid=2289981'
Write-Host -ForegroundColor Green "[+] Downloading Windows PE add-on from $Url"
if ($host.name -match 'ConsoleHost') {
    Invoke-Expression "& curl.exe --insecure --location --output `"$env:TEMP\adkwinpesetup.exe`" --url `"$Url`""
}
else {
    #PowerShell ISE will display a NativeCommandError, so progress will not be displayed
    $Quiet = Invoke-Expression "& curl.exe --insecure --location --output `"$env:TEMP\adkwinpesetup.exe`" --url `"$Url`" 2>&1"
}
Write-Host -ForegroundColor Green '[+] Installing Windows PE add-on for the Windows ADK'
Start-Process -FilePath "$env:TEMP\adkwinpesetup.exe" -ArgumentList '/features', 'OptionId.WindowsPreinstallationEnvironment', '/quiet', '/ceip', 'off', '/norestart' -Wait

# Bugfix for MDT Windows PE x86 MMC snap-in error
if (-not (Test-Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs')) {
    New-Item -Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs' -ItemType Directory -Force
}