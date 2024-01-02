#!/bin/bash

#This script was made on Nobara which is Fedora based and some things may be different from Debian based distros. Most notibly, the java paths.

# Settings (You may change these)
NAME="" # This will be the name of the screen.

SCRIPT="" # This is the shell script you wish to run. Include the .sh extention.

TERMCMD="konsole -e" # You may need to change this depending on the terminal your distro uses.

# ***************DO NOT TOUCH BELOW HERE UNLESS YOU KNOW WHAT YOU'RE DOING***************

# Screens and set/create it if nessessary
check() {

  if echo $STY | grep -q "$NAME"; then
    echo 'In screen! Starting the server!'
    start_server

  elif screen -ls | grep -q "$NAME"; then # If screen list does NOT contain the NAME of the screen specified. Start it silently
    echo "Screen Detected. Starting in 5 seconds... Press [ctrl + c] to cancel"
    i=4
    while [ $i -ge 1 ]
    do
      sleep 1
      echo $i
      i=$((i-1))
    done

  else # Otherwise, if the screen does exist, give 10 seconds to cancel to continuation of the code (Which will start the server)
    echo "Starting Screen"
    screen -dmS $NAME ./StartForScripts.sh

  fi

}

# Start the server.
start_server() {

  echo "Starting $NAME"
  ./${SCRIPT}
}

main() { # The main method. Runs the check method, then starts the server.
  check
  start_server
  if -n $TERMCMD; then
    $TERMCMD screen -r -S $NAME
  fi
}

main # Despite being at the bottom, this is the first line to "run". It runs the above main method which then runs everything else.
