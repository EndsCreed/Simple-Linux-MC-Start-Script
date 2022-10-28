#!/bin/bash

#This script was made on Nobara which is Fedora based and some things may be different from Debian based distros. Most notibly, the java paths.

# Settings (You may change these)
NAME="" # This will be the name of the screen.

JAR="" # This is the name of the server jar you want to launch. Include the .jar extension.

JAVA="" #This is the full path of the java version to be used for this server.

MEM="" # The amount of ram to be dedicated to the server. This will be min and max.

ARGS="-Dterminal.jline=false -Dterminal.ansi=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
# The above args are Aikar's args by default.

TERMCMD="gnome-terminal --" # You may need to change this depending on the terminal your distro uses.

# ***************DO NOT TOUCH BELOW HERE***************

# Check Java Version and Screens and set/create it if nessessary
check() {

  screen -ls > screen.txt # Read screen list

  if ! grep -q $NAME screen.txt; then # If screen list does NOT contain the NAME of the screen specified. Start it silently

    echo "Starting Screen"
    screen -dmS $NAME bash

  else # Otherwise, if the screen does exist, give 10 seconds to cancel to continuation of the code (Which will start the server)

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

 screen -S $NAME -X stuff "echo 'Starting ${NAME}...' && $JAVA -Xms$MEM -Xmx$MEM $ARGS -jar ${JAR} nogui
"
}

main() { # The main method. Runs the check method, then starts the server.
  check
  start_server
  if -n $TERMCMD; then
    $TERMCMD screen -r -S $NAME # This may need to be changed depending on your terminal.
  fi
}

# Despite being at the bottom, this is the first line to run. It runs the above main method which then runs everything else.
main
