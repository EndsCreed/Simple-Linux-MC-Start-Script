#!/bin/bash

#This script was made on Nobara which is Fedora based and some things may be different from Debian based distros. Most notibly, the java paths.

# Settings (You may change these)
NAME="" # This will be the name of the screen.

SCRIPT="" # This is the shell script you wish to run. Include the .sh extention.

TERMCMD="gnome-terminal --" # You may need to change this depending on the terminal your distro uses.

# ***************DO NOT TOUCH BELOW HERE UNLESS YOU KNOW WHAT YOU'RE DOING***************

# Screens and set/create it if nessessary
check() {

  screen -ls > screen.txt # Read screen list

  if ! grep -q $NAME screen.txt; then # If screen list does NOT contain the NAME of the screen specified. Start it silently

    echo "Starting Screen"
    screen -dmS $NAME bash

  else # Otherwise, if the screen does exist, give 5 seconds to cancel to continuation of the code (Which will start the server)

    echo "Screen Detected. Starting in 5 seconds... Press [ctrl + c] to cancel"
    i=4
    while [ $i -ge 1 ]
    do
      sleep 1
      echo $i
      i=$((i-1))
    done
  fi
}

# Start the server.
start_server() {

 screen -S $NAME -X stuff "echo 'Starting ${NAME}...' && ./${SCRIPT}
"
}

main() { # The main method. Runs the check method, then starts the server.
  check
  start_server
  if -n $TERMCMD; then
    $TERMCMD screen -r -S $NAME
  fi
}

main # Despite being at the bottom, this is the first line to "run". It runs the above main method which then runs everything else.
