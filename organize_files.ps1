# PowerShell File Organizer Script
# Organizes Downloads folder into categorized folders on Desktop

# Set paths
$Desktop = [Environment]::GetFolderPath("Desktop")
$Downloads = [Environment]::GetFolderPath("UserProfile") + "\Downloads"

# Define target folders
$VideoFolder = Join-Path $Desktop "Video"
$AudioFolder = Join-Path $Desktop "Audio"
$ISOFolder = Join-Path $Desktop "ISOs"
$DocsFolder = Join-Path $Desktop "Docs"
$OtherFolder = Join-Path $Desktop "Other"

# Create folders if they don't exist
Write-Host "Checking and creating necessary folders on Desktop..." -ForegroundColor Cyan
@($VideoFolder, $AudioFolder, $ISOFolder, $DocsFolder, $OtherFolder) | ForEach-Object {
    if (-not (Test-Path $_)) {
        New-Item -ItemType Directory -Path $_ | Out-Null
    }
}

# File extension arrays
$VideoExts = @('mp4', 'avi', 'mkv', 'mov', 'wmv', 'flv', 'webm', 'm4v', 'mpg', 'mpeg', '3gp', 'ogv')
$AudioExts = @('mp3', 'wav', 'flac', 'aac', 'ogg', 'wma', 'm4a', 'opus', 'aiff', 'ape')
$ISOExts = @('iso', 'img', 'dmg', 'vhd', 'vmdk')
$DocsExts = @('pdf', 'doc', 'docx', 'txt', 'odt', 'rtf', 'xls', 'xlsx', 'ppt', 'pptx', 'csv', 'ods', 'odp')

# Counter for moved files
$movedCount = 0

Write-Host "Organizing files from Downloads folder..." -ForegroundColor Cyan
Write-Host "----------------------------------------" -ForegroundColor Gray

# Get all files in Downloads (not directories)
$files = Get-ChildItem -Path $Downloads -File

foreach ($file in $files) {
    $ext = $file.Extension.TrimStart('.').ToLower()
    
    # Determine destination folder
    if ($VideoExts -contains $ext) {
        $dest = $VideoFolder
        $type = "Video"
    }
    elseif ($AudioExts -contains $ext) {
        $dest = $AudioFolder
        $type = "Audio"
    }
    elseif ($ISOExts -contains $ext) {
        $dest = $ISOFolder
        $type = "ISO"
    }
    elseif ($DocsExts -contains $ext) {
        $dest = $DocsFolder
        $type = "Document"
    }
    else {
        $dest = $OtherFolder
        $type = "Other"
    }
    
    # Move file
    try {
        Move-Item -Path $file.FullName -Destination $dest -Force
        Write-Host "Moved: $($file.Name) → $type" -ForegroundColor Green
        $movedCount++
    }
    catch {
        Write-Host "Error moving: $($file.Name) - $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "Organization complete!" -ForegroundColor Green
Write-Host "Total files moved: $movedCount" -ForegroundColor Yellow
Write-Host ""
Write-Host "Folders created/verified on Desktop:" -ForegroundColor Cyan
Write-Host "  - Video" -ForegroundColor White
Write-Host "  - Audio" -ForegroundColor White
Write-Host "  - ISOs" -ForegroundColor White
Write-Host "  - Docs" -ForegroundColor White
Write-Host "  - Other" -ForegroundColor White
