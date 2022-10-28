#!/bin/bash

# Basic backup script for a target folder within the current dir.
# Appends the date and time to the chosen folder
# Announces when finished

echo ""
echo "PLEASE ONLY USE ON FOLDERS"
echo "Basic backup starting. Backups will announce when finished. Large backups may take some time."
echo "Backups may be cancelled with [ctrl + c]."
echo "Manual cleanup for the backup directory for a cancelled backup will be required"
echo "--------------------------------"
du -hd 1
echo "--------------------------------"
read -p "Enter target folder to backup without './': " TARGET
ZIP="${TARGET}-$(date +"%Y-%m-%d_%H-%M-%S")"
echo ""
echo "Starting backup..."
if [ ! -d "./backups" ]; then
  mkdir ./backups
  mv SubProcessOfRestore.sh ./backups
fi
cd $TARGET
zip -9r ${ZIP}.zip *
mv ${ZIP}.zip ../backups/
echo ""
echo "Backup finished and moved into ./backups"
read -p "Press [Enter] to close" bb && exit
