git config --global user.email "you@example.com"
git config --global user.name "Your Name"
# if this is the first time using git, it will ask for your GitHub username and password

Write-Host "Checking if Git is installed..." -ForegroundColor Cyan
$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    Write-Host "Git is not installed. Please install Git before running this script." -ForegroundColor Red
    exit 1
}

# Check if user.email is set
$currentEmail = git config --global user.email
if ([string]::IsNullOrWhiteSpace($currentEmail)) {
    $userEmail = Read-Host "Enter your Git email address"
    git config --global user.email "$userEmail"
    Write-Host "Set git user.email to $userEmail" -ForegroundColor Green
} else {
    Write-Host "Current git user.email: $currentEmail" -ForegroundColor Yellow
    $changeEmail = Read-Host "Do you want to change it? (y/n)"
    if ($changeEmail -eq 'y') {
        $userEmail = Read-Host "Enter your new Git email address"
        git config --global user.email "$userEmail"
        Write-Host "Updated git user.email to $userEmail" -ForegroundColor Green
    }
}

# Check if user.name is set
$currentName = git config --global user.name
if ([string]::IsNullOrWhiteSpace($currentName)) {
    $userName = Read-Host "Enter your Git user name"
    git config --global user.name "$userName"
    Write-Host "Set git user.name to $userName" -ForegroundColor Green
} else {
    Write-Host "Current git user.name: $currentName" -ForegroundColor Yellow
    $changeName = Read-Host "Do you want to change it? (y/n)"
    if ($changeName -eq 'y') {
        $userName = Read-Host "Enter your new Git user name"
        git config --global user.name "$userName"
        Write-Host "Updated git user.name to $userName" -ForegroundColor Green
    }
}

# Show final identity
$finalEmail = git config --global user.email
$finalName = git config --global user.name
Write-Host "\nYour global Git identity is now:" -ForegroundColor Cyan
Write-Host "  Name : $finalName" -ForegroundColor White
Write-Host "  Email: $finalEmail" -ForegroundColor White