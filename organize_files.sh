#!/usr/bin/env bash
# Cross-platform file organizer script
# Works on Linux (bash) and Windows (PowerShell with Git Bash/WSL)

# Detect OS and set paths accordingly
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]] || [[ -n "$WINDIR" ]]; then
    # Windows
    DESKTOP="$USERPROFILE/Desktop"
    DOWNLOADS="$USERPROFILE/Downloads"
else
    # Linux/Unix
    DESKTOP="$HOME/Desktop"
    DOWNLOADS="$HOME/Downloads"
fi

# Define target folders on Desktop
VIDEO_FOLDER="$DESKTOP/Video"
AUDIO_FOLDER="$DESKTOP/Audio"
ISO_FOLDER="$DESKTOP/ISOs"
DOCS_FOLDER="$DESKTOP/Docs"
OTHER_FOLDER="$DESKTOP/Other"

# Create folders if they don't exist
echo "Checking and creating necessary folders on Desktop..."
mkdir -p "$VIDEO_FOLDER" "$AUDIO_FOLDER" "$ISO_FOLDER" "$DOCS_FOLDER" "$OTHER_FOLDER"

# File extension arrays
VIDEO_EXTS=("mp4" "avi" "mkv" "mov" "wmv" "flv" "webm" "m4v" "mpg" "mpeg" "3gp" "ogv")
AUDIO_EXTS=("mp3" "wav" "flac" "aac" "ogg" "wma" "m4a" "opus" "aiff" "ape")
ISO_EXTS=("iso" "img" "dmg" "vhd" "vmdk")
DOCS_EXTS=("pdf" "doc" "docx" "txt" "odt" "rtf" "xls" "xlsx" "ppt" "pptx" "csv" "ods" "odp")

# Function to get file extension
get_extension() {
    filename="$1"
    echo "${filename##*.}" | tr '[:upper:]' '[:lower:]'
}

# Function to check if extension is in array
contains() {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ "$element" == "$seeking" ]]; then
            in=0
            break
        fi
    done
    return $in
}

# Counter for moved files
moved_count=0

echo "Organizing files from Downloads folder..."
echo "----------------------------------------"

# Process all files in Downloads
for file in "$DOWNLOADS"/*; do
    # Skip if no files found or if it's a directory
    if [[ ! -f "$file" ]]; then
        continue
    fi
    
    filename=$(basename "$file")
    ext=$(get_extension "$filename")
    
    # Determine destination folder
    if contains VIDEO_EXTS "$ext"; then
        dest="$VIDEO_FOLDER"
        type="Video"
    elif contains AUDIO_EXTS "$ext"; then
        dest="$AUDIO_FOLDER"
        type="Audio"
    elif contains ISO_EXTS "$ext"; then
        dest="$ISO_FOLDER"
        type="ISO"
    elif contains DOCS_EXTS "$ext"; then
        dest="$DOCS_FOLDER"
        type="Document"
    else
        dest="$OTHER_FOLDER"
        type="Other"
    fi
    
    # Move file
    if mv "$file" "$dest/"; then
        echo "Moved: $filename → $type"
        ((moved_count++))
    else
        echo "Error moving: $filename"
    fi
done

echo "----------------------------------------"
echo "Organization complete!"
echo "Total files moved: $moved_count"
echo ""
echo "Folders created/verified on Desktop:"
echo "  - Video"
echo "  - Audio"
echo "  - ISOs"
echo "  - Docs"
echo "  - Other"
