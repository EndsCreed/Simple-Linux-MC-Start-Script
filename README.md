# Simple-Linux-MC-Start-Script
This is a simple shell/bash based Linux start script. This was made for my own use but I've uploaded it for anyone else to use as well. 
It includes:
- A Start script
- A Backup Script
- A Restore Script

## Disclaimer
I am not that experienced with bash/shell. I know enough to make it do what I want it to do but that's about it. If it breaks or you want to chnage some lines to cut down on the line count or make it more efficient, feel free.

## Dependencies
Bash
- All of these scripts start with `#!/bin/bash` and run using bash and is required for them to work out of the box. Feel free to change them to /bin/sh if you want or to whatever else you may use. It shouldn't be hard to change this.

Java
- This is pretty obvious as you'll need it for Minecraft as well but my script also directly accesses your java installation. Make sure you have it installed!

Screen
- These scripts make heavy use of screens. This is to allow everything to be SSH friendly and allow you to easily pop in and out of the consoles/scripts without having to worry about them closing out and cancelling. Mosy distros should allow you to easily install screen with your package manager. Eg: `sudo apt install screen` or `sudo dnf install screen`.

Zip
- Pretty much every distro comes with zip, but if yours doesn't, it is required for the backup and restore scripts.

## Configuration
The `Start.sh` script needs to be configured before use. All of the configureable aspects can be found at the top of the file.

#### NAME
This will be the alphanumeric name of the screen. This is different from the ID. It can be used to search and connect to the screen.
Eg.
- `NAME="My-Vanilla-World"`
- `NAME="All-The-Fabic"`

![image](https://user-images.githubusercontent.com/63371815/198675818-5bba4ddf-21b6-4540-a4c1-3d0334631a4a.png)

Above is an example of what you can expect to see in your screen listing if you set it to `NAME="All-The-Fabric`

#### JAR
This will be the name of the server jar itself. Do not include the .jar file extention here. Just the name.
Eg.
- `JAR="server"
- `JAR="forge-1.12.2-14.23.5.2854-universal"`

#### JAVA
This is the full path to your java installation. This can be found by running `sudo alternatives --config java`. This will spit back a list of currently installed java versions like below.

![image](https://user-images.githubusercontent.com/63371815/198677713-2aadf835-ab31-4af0-aac8-c35f30b5ed9b.png)

There is a catch however... If you simply extracted java into your own directory instead of installing it with a package manager, you will need to instead but that path.
Eg.
- `JAVA="/usr/lib/jvm/java-17-openjdk-17.0.4.1.1-1.fc36.x86_64/bin/java"`
- `JAVA="/CustomDir/java-1.8.0-openjdk-amd64/bin/java"`

#### MEM
This is the section to configure your RAM allocation. Depending on your use case, this number can change drastically. I wouldn't recommend setting this below `1.5G` or `1536M`. Mods or plugins will require this number to rise proportionally to the amount of plugins or mods. 
Eg.
- `MEM="1.5G"` // 1.5 Gigabytes of RAM
- `MEM="3G"` // 3 Gigabytes of RAM
- `MEM="6144M"` // 6144 Megabytes of RAM (6 Gigabytes)

#### ARGS
This section is the java arguements section. This can be left as is or it can be blank. If you have args that you want to use you can delete everything in this space and put your own. The default arguments that are pre-loaded into this variable are Aikar's args and are regarded as some of the best java arguements for server optimization at this time. I won't provide details on how to configure good args here as I don't really know how to make optimized java arguements. 
If you're loading a modpack, there is a chance that the modpack authors will provide to you a set of arguements. If they do, I would recommend using them. Especially if it's a very large and well know modpack such as a FeedTheBeast or AllTheFabric/Mods pack.
If you have any issues with these args, you may simply leave the quotes empty.
Eg.
- `ARGS=""`

#### TERMCMD
This is for the desired terminal command. This will open the terminal GUI into the the newly created screen upon server launch. This can be commented out if you have a different terminal, you may change this to match it. If you don't want a terminal to open at all, just change it to be empty. 
Eg.
- `TERMCMD="konsole -e"` // Uses the KDE terminal window.
- `TERMCMD=""` // Does not attempt to open a terminal window.

## Usage
All you do is drop the files into the servers root folder. From there you can run them and they should all work AFTER CONFIGURED. (See Configuration)
After running this scripts you can close out your terminal window or log out of SSH and they should continue to run on your machine. To get back into them (attach), simply open your terminal again either through the terminal GUI or any other means and run `screen -rS NAME`. In the event someone is attached to them or you want to allow multiple people to attach to them, replace `r` with `x`. Please keep in mind the it is CASE-SENSITIVE. 
If you cannot remember the name you configured for your screen, run `screen -ls` to view a list of all screens that are currently running. This works for both the server start script and the backup/restore scripts. 
To close a screen you can either attach to the screen and type `exit` or you can run `screen -S NAME -X exit`. Both will terminate the screen and stop any running process that is taking place on that screen.
Upon doing your first backup it will make a backup folder in your servers root folder and move `SubProcessOfRestore.sh` into it. These subprocesses can be ran on their own but they are meant to be ran by the `Backup.sh` file. The `Backup.sh` file is responsible for managing the backups and restores and also runs them through screens for conveinience. Running a backup or restore should be easy as it will guide you through the process in the terminal. Zipping and Unzipping are done in verbose mode so you can watch it happen instead of wondering if it has frozen or not. 

That's all! Hope you enjoy it!
