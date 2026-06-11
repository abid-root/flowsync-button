$ErrorActionPreference = "Stop"

$zipName = "buttonverse-lab-complete-site.zip"
$siteFolder = "buttonverse-lab"

if (!(Test-Path ".\$zipName")) {
  throw "Put $zipName in this folder first, then run again."
}

if (Test-Path ".\$siteFolder") {
  $backup = "$siteFolder-backup-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
  Rename-Item ".\$siteFolder" ".\$backup"
  Write-Host "Existing Buttonverse folder backed up as: $backup"
}

Expand-Archive ".\$zipName" "." -Force

Write-Host ""
Write-Host "DONE: Separate Buttonverse Lab site created."
Write-Host "Open: .\$siteFolder\index.html"
Write-Host ""
Write-Host "Pages:"
Write-Host "- .\$siteFolder\index.html"
Write-Host "- .\$siteFolder\library.html"
Write-Host "- .\$siteFolder\source-guide.html"
