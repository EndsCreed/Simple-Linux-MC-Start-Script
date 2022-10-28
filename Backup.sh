#!/bin/bash

# This script is designed to be ran with 2 other scripts.
# SubProcessOfBackup.sh and SubProcessOfRestore.sh
# This script runs those in screens depending on the option you pick

echo ""
echo "This is the screen based backup script orginally made of a private UbuntuVM server."
echo ""

joinScreen() {
  echo "Please type the full name or the number ID (Before the .) of the screen you wish to join"
  read -p "Name or ID: " NorI
  screen -rS $NorI
}

backup() { # Backup Method for handling transfer of the backup script to screen
  screen -ls > screen.txt

  if grep -q 'backup-of-' screen.txt; then
    echo "Backup screen has been found. Please review the below screen list and decide if you want to (1)Create a new screen or type the name or ID of the screen you wish to resume exactly"
    echo "--------------------------------"
    screen -ls
    echo "--------------------------------"
    read -p "[1]-New Screen [2]-Resume Screen: " NorR
      if [ "$NorR" -eq 1 ]; then
        echo "The new screen will be called 'backup-of-NAME'. Please enter what you would like the NAME to be"
        read -p "Name: " NAME
        screen -dmS backup-of-$NAME bash
        echo "Now joining the screen"
        sleep 3
        screen -S backup-of-$NAME -X stuff "./SubProcessOfBackup.sh
"
        screen -rS backup-of-$NAME
      else
        joinScreen
      fi
  else
    echo "The new screen will be called 'backup-of-NAME'. Please enter what you would like the NAME to be"
    read -p "Name: " NAME
    echo "Creating backup screen"
    screen -dmS backup-of-$NAME bash
    echo "Now joining the screen"
    sleep 3
    screen -S backup-of-$NAME -X stuff "./SubProcessOfBackup.sh
"
    screen -rS backup-of-$NAME
  fi
  rm screen.txt
}

restore() {
  screen -ls > screen.txt

  if grep -q 'restore-of-' screen.txt; then
    echo "Restore screen has been found. Please review the below screen list and decide if you want to (1)Create a new screen or type the name or ID of the screen you wish to resume exactly"
    echo "--------------------------------"
    screen -ls
    echo "--------------------------------"
    read -p "[1]-New Screen [Name/ID]-Resume Screen: " NorR
      if [ "$NorR" -eq 1 ]; then
        echo "The new screen will be called 'restore-of-NAME'. Please enter what you would like the NAME to be"
        read -p "Name: " NAME
        screen -dmS restore-of-$NAME bash
        echo "Now joining the screen"
        sleep 3
        screen -S restore-of-$NAME -X stuff "cd ./backups && ./SubProcessOfRestore.sh
"
        screen -rS restore-of-$NAME
      else
        joinScreen
      fi
  else
    echo "The new screen will be called 'restore-of-NAME'. Please enter what you would like the NAME to be"
    read -p "Name: " NAME
    echo "Creating restore screen"
    screen -dmS restore-of-$NAME bash
    echo "Now joining the screen"
    sleep 3
    screen -S restore-of-$NAME -X stuff "cd ./backups && ./SubProcessOfRestore.sh
"
    screen -rS restore-of-$NAME
  fi
  rm ../screen.txt
}

main() {
  echo ""
  echo "Would you like to run a (1)backup of a folder or (2)restore a zip from ./backups?"
  read -p "[1]-Backup [2]-Restore: " BorR
  if [ "$BorR" -eq 1 ]; then # Backup Method
    backup
  else # Restore method
    restore
  fi
}

main
