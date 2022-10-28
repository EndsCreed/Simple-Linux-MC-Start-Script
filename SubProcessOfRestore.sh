#!/bin/bash

# Basic backup restore script. the contents of the zip will be restored up one directory and directly into the specified folder.
# eg:
# backup.zip is located in '/files/backups' and contains: file1, file2, file3
# if the entered folder name is 'MyFolder' then it will be restored to '/files/MyFolder'.
# MyFolder will contain: file1, file2, file3

echo "Please enter the zip you wish to restore and the resulting folder's name [eg: folder.zip FolderName]"
echo "Available zips are listed below"
echo "-----------------------------"
ls -hC *.zip
echo "-----------------------------"
read -p "Enter zip and final name: " ZIP FolderName
echo ""
if [ -d "../$FolderName" ]; then
  read -p "Folder already exists! (1)Replace or (2)Merge?: " CHOICE
  if [ "$CHOICE" -eq 1 ]; then
    echo "Replacing"
    rm -r ../$FolderName && unzip -od ../$FolderName $ZIP
  else
    echo "Merging"
    unzip -od ../$FolderName $ZIP
  fi
else
  echo "Creating '$FolderName' one directory up"
  unzip -od ../$FolderName $ZIP
fi
echo "Restoration Completed"
read -p "Press [Enter] to close" a && exit
