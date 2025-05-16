# Install Git for Windows

Write-Host "Checking if Git is already installed..." -ForegroundColor Cyan
$git = Get-Command git -ErrorAction SilentlyContinue
if ($git) {
    $gitVersion = git --version
    Write-Host "Git is already installed: $gitVersion" -ForegroundColor Green
    exit 0
}

Write-Host "Git is not installed. Installing Git for Windows using winget..." -ForegroundColor Yellow
try {
    winget install -e --id Git.Git -h
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Git for Windows installed successfully." -ForegroundColor Green
    } else {
        Write-Host "Git installation may have failed. Please check the output above." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "An error occurred during installation: $_" -ForegroundColor Red
    exit 1
}