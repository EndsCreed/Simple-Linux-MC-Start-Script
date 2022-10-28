# Simple-Linux-MC-Start-Script
This is a simple shell/bash based Linux start script. This was made for my own use but I've uploaded it for anyone else to use as well. 
It includes:
- A Start script
- A Backup Script
- A Restore Script

# Disclaimer
I am not that experienced with bash/shell. I know enough to make it do what I want it to do but that's about it. If it breaks or you want to chnage some lines to cut down on the line count or make it more efficient, feel free.

# Dependencies
Bash
- All of these scripts start with `#!/bin/bash` and run using bash and is required for them to work out of the box. Feel free to change them to /bin/sh if you want or to whatever else you may use. It shouldn't be hard to change this.

Screen
- These scripts make heavy use of screens. This is to allow everything to be SSH friendly and allow you to easily pop in and out of the consoles/scripts without having to worry about them closing out and cancelling. Mosy distros should allow you to easily install screen with your package manager. Eg: `sudo apt install screen` or `sudo dnf install screen`.

Zip
- Pretty much every distro comes with zip, but if yours doesn't, it is required for the backup and restore scripts.

# Usage
All you do is drop the files into the servers root folder. From there you can run them and they should all work. 
Upon doing your first backup it will make a backup folder in your servers root folder and move `SubProcessOfRestore.sh` into it. These subprocesses can ba ran on their own but they are meant to be ran by the `Backup.sh` file. The `Backup.sh` file is responsible for managing the backups and restores and also runs them through screens for conveinience. 
