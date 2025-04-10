# Show all available versions
winget show --id Microsoft.DeploymentToolkit --versions

# Microsoft Deployment Toolkit
winget install --id Microsoft.DeploymentToolkit -v 6.3.8456.1000 -e --accept-source-agreements --accept-package-agreements

# Bugfix for MDT Windows PE x86 MMC snap-in error
if (-not (Test-Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs')) {
    New-Item -Path 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs' -ItemType Directory -Force
}