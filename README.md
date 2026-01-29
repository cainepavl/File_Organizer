# File_Organizer_Script

A cross-platform script to automatically organize your Downloads folder into categorized folders on your Desktop.

## Table of Contents

- [Features](#features)
- [Supported File Types](#supported-file-types)
- [Installation & Usage](#installation-&-usage)
- [What it Does](#what-it-does)
- [Important Notes](#important-notes)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Automation](#automation)
- [License](#license)
- [Support](#support)

## Features

- **Automatic folder creation**: Creates Video, Audio, ISOs, Docs, and Other folders on your Desktop
- **Smart file categorization**: Recognizes common file types and sorts them appropriately
- **Cross-platform**: Works on both Linux (bash) and Windows (PowerShell)
- **Safe operation**: Only moves files, preserves folder structure in Downloads

## Supported File Types

### Video
`mp4`, `avi`, `mkv`, `mov`, `wmv`, `flv`, `webm`, `m4v`, `mpg`, `mpeg`, `3gp`, `ogv`

### Audio
`mp3`, `wav`, `flac`, `aac`, `ogg`, `wma`, `m4a`, `opus`, `aiff`, `ape`

### ISOs
`iso`, `img`, `dmg`, `vhd`, `vmdk`

### Documents
`pdf`, `doc`, `docx`, `txt`, `odt`, `rtf`, `xls`, `xlsx`, `ppt`, `pptx`, `csv`, `ods`, `odp`

### Other
Any file type not listed above will be moved to the "Other" folder

## Installation & Usage

### Windows (PowerShell)

1. Save the PowerShell script as `organize_files.ps1`
2. Open PowerShell as Administrator (right-click PowerShell → Run as Administrator)
3. If needed, enable script execution:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
4. Navigate to the script location and run:
   ```powershell
   .\organize_files.ps1
   ```

### Linux (Bash)

1. Save the bash script as `organize_files.sh`
2. Make it executable:
   ```bash
   chmod +x organize_files.sh
   ```
3. Run the script:
   ```bash
   ./organize_files.sh
   ```

## What It Does

1. **Checks** for the presence of these folders on your Desktop:
   - Video
   - Audio
   - ISOs
   - Docs
   - Other

2. **Creates** any missing folders

3. **Scans** all files in your Downloads folder

4. **Moves** each file to the appropriate category folder based on its extension

5. **Reports** how many files were moved and where they went

## Important Notes

- **Folders in Downloads**: The script only processes files, not folders. Any subdirectories in Downloads will remain untouched.
- **File name conflicts**: If a file with the same name already exists in the destination folder, the script will overwrite it (use caution).
- **No undo**: Once files are moved, you'll need to move them back manually if needed.
- **Backup recommended**: Consider backing up important files before running the script for the first time.

## Customization

You can easily customize the script to:
- Add more file extensions to existing categories
- Create new categories
- Change destination folders
- Modify the source folder (currently Downloads)

Simply edit the extension arrays in the script file.

## Troubleshooting

### Windows: "Cannot run scripts"
If you get an execution policy error, run:
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Linux: "Permission denied"
Make sure the script is executable:
```bash
chmod +x organize_files.sh
```

### Files not moving
- Check that you have write permissions for both Downloads and Desktop
- Ensure no files are currently open or in use
- Verify the paths exist on your system

## Automation (Optional)

### Windows Task Scheduler
Create a scheduled task to run the PowerShell script automatically at login or on a schedule.

### Linux Cron
Add to your crontab to run periodically:
```bash
# Run every day at 6 PM
0 18 * * * /path/to/organize_files.sh
```

## License

Free to use and modify as needed.

## Support

If you encounter issues:
1. Check that your Downloads and Desktop folders are in standard locations
2. Verify you have proper file permissions
3. Review the console output for specific error messages
