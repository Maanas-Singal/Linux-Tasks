#!/bin/bash

# Source and destination paths
SOURCE_DIR="/path/to/source/folder"
DESTINATION_DIR="/path/to/destination/folder"

# Check if rsync is installed
if ! command -v rsync &>/dev/null; then
  echo "rsync is not installed. Please install it using your package manager."
  exit 1
fi

# Run rsync with the appropriate options
rsync -av --update --progress "$SOURCE_DIR/" "$DESTINATION_DIR/"

## -a: Archive mode. This option preserves file permissions, timestamps, and other attributes.
## -v: Verbose mode. It displays detailed information about the transfer.
## --update: This option tells rsync to skip files that are newer on the receiver (destination) side.
## --progress: Displays the progress of the transfer.
## The script will only transfer the files or parts of files that have been modified or added since the last synchronization. 
## This way, you can efficiently keep the destination folder up-to-date with the changes from the source folder.
