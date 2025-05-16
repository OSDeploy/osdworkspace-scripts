<#
.SYNOPSIS
    Ensures PowerShell 5.1 is configured correctly and ready for use.
.DESCRIPTION
    This script performs the following actions:
    1. Sets the machine-level execution policy to RemoteSigned. This allows running local scripts and signed remote scripts.
    2. Checks if the NuGet package provider is installed. If not, it installs NuGet. NuGet is required for installing PowerShell modules from the PowerShell Gallery.
    3. Trusts the default PowerShell Gallery (PSGallery) to allow module installation without prompts.
    4. Installs/updates the PackageManagement module to ensure the latest features and cmdlets for package management are available.
.NOTES
    Author: GitHub Copilot
    Date: May 16, 2025
    Requires: PowerShell Version 5.1 and administrator privileges to set execution policy and install package providers.

    To run this script:
    1. Open PowerShell as an Administrator.
    2. Navigate to the directory containing this script.
    3. Execute the script: .\"`Update PowerShell 5.ps1`"
#>
#Requires -Version 5.1

# Ensure PowerShell 5.1 is working well by configuring essential settings.

# Set the execution policy to RemoteSigned for the local machine.
# This allows running local scripts and signed remote scripts, enhancing security while maintaining usability.
# -Force suppresses confirmation prompts.
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force

# Check if the NuGet package provider is installed.
# NuGet is essential for interacting with PowerShell Gallery and managing modules.
if ($(Get-PackageProvider).Name -notcontains 'NuGet') {
    # Install the NuGet package provider if it's not found.
    # -Force suppresses confirmation prompts.
    Install-PackageProvider -Name NuGet -Force -Verbose
}

# Trust the PowerShell Gallery to allow seamless module installation.
# This prevents confirmation prompts when installing modules from PSGallery.
if ((Get-PSRepository -Name 'PSGallery').InstallationPolicy -ne 'Trusted') {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    Write-Host "PowerShell Gallery (PSGallery) has been set to Trusted."
} else {
    Write-Host "PowerShell Gallery (PSGallery) is already Trusted."
}

# Install or update the PackageManagement module.
# This module provides cmdlets for discovering, installing, and managing software packages.
Install-Module -Name PackageManagement -Force -Scope AllUsers -AllowClobber -SkipPublisherCheck -Verbose

Write-Host "PowerShell 5.1 environment check and configuration complete."