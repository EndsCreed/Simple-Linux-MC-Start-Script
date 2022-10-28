#!/bin/bash

#This script was made on Nobara which is Fedora based and some things may be different from Debian based distros. Most notibly, the java paths.

# Settings (You may change these)
NAME="" # This will be the name of the screen.

JAR="" # This is the name of the server jar you want to launch. Do not include the .jar extension.

JAVA="" #This is the full name of the java version to be used for this server.
# BELOW ARE THE NAMES ON MY OWN PC. PLEASE CHECK YOURS FIRST AS THESE MAY NOT WORK
# Ubuntu/PopOS! ------------------
# java-1.17.0-openjdk-amd64 - For 1.18+
# java-1.16.0-openjdk-amd64 - For 1.13 - 1.17.x
# java-1.8.0-openjdk-amd64  - For 1.7 - 1.12.x
# Nobara -------------------------
# java-17-openjdk-17.0.4.1.1-1.fc36.x86_64/bin/java
# java-11-openjdk-11.0.16.1.1-1.fc36.x86_64/bin/java

VERSION="" # This needs to be changed in accordance with JAVA.
# 17.0.1 - For java-1.17.0-openjdk-amd64
# 16.0.2 - For java-1.16.0-openjdk-amd64
# 1.8.0  - For java-1.8.0-openjdk-amd64
# FEDORA
# 17.0.4.1 - For java-17-openjdk-17.0.4.1.1-1.fc36.x86_64/bin/java
# 11.0.16.1 - For java-11-openjdk-11.0.16.1.1-1.fc36.x86_64/bin/java

ALTCMD="alternatives --set java /usr/lib/jvm/$JAVA" # This is to configure the alternatives command. You may need to change the path to $JAVA

MEM="" # The amount of ram to be dedicated to the server.

ARGS="-Dterminal.jline=false -Dterminal.ansi=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
# The above args are Aikar's args by default.

PASS="" # OPTIONAL! This is your sudo password and is ONLY required if you want it to run completely automatically. if you're okay with typing in your pass manually, leave this empty.

# ***************DO NOT TOUCH BELOW HERE***************

# Check Java Version and Screens and set/create it if nessessary
check() {

  java -version 2>output.txt # Read java version

  if ! grep -q $VERSION output.txt; then # If output does NOT contain the JAVA specified, change it.
    echo "Setting to Java $VERSION"
    if -n $PASS; then
      echo "$PASS" | sudo -S $ALTCMD
    else
      sudo $ALTCMD
    fi
    sleep 1
  fi

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

 screen -S $NAME -X stuff "echo 'Starting ${NAME}...' && java -Xms$MEM -Xmx$MEM $ARGS -jar ${JAR}.jar nogui
"
}

main() { # The main method. Runs the check method, then starts the server.
  check
  start_server
  gnome-terminal -- screen -r -S $NAME # This may need to be changed depending on your terminal.
}

# Despite being at the bottom, this is the first line to run. It runs the above main method which then runs everything else.
main
