# Mame-Screensaver
This is a screensaver which uses MAME to run roms in an attract mode fashion.  A rom is selected at random, mame executes the rom and plays it for set a runtime.  Once the runtime is reached, mame exits and repeat!  
Mame-Screensaver is written in Powershell and then compiled to an .exe (.scr) with a powershell wrapper.  It was written to run on my home mame cabinet.
 
**Prerequisites**  
* .NET Framework 4.5.2 (or higher) - https://www.microsoft.com/en-us/download/details.aspx?id=42643  
* Powershell 5.0/5.1 - https://www.microsoft.com/en-us/download/details.aspx?id=54616 (part of Windows Management Framework)
* MAME - https://www.mamedev.org/  
* Windows OS - Windows 10, 8, or 7 should work fine as long as .NET 4.5.2 and Powershell 5.0/5.1 from Windows Management Framework is installed.  
  * Windows 10 meets these requirements out of the box.

**Installation**
* Download the zip file with the binaries inside.  
  * mame_scr.scr - Screensaver file  
  * mamesscfg.exe - Configuration utility for screensaver  
  * mame_scr.ini - Configuration itself
* Extract zip to directory of your choosing
* Copy mame_scr.scr and mame_scr.ini to the c:\windows\system32 directory
* Run the mamesscfg.exe file to launch the configuration utility - this will put your configuration settings into the .ini file
  * Should be launched as administrator in order to edit mame_scr.ini file copied into c:\windows\system32
* Once configuration is set. Select Screensaver tab.
* Set Screensaver Timeout value and click [Setup Screensaver] button
* Done.  See details below to understand options.

**Usage**
 * When the screensaver is running, mame functions normally.  You can play the game that is running, but once the runtime value is reached it will exit the rom.
 * In order to exit the screensaver the key mapped for exiting a mame will need to be used.  Escape is the default key for exiting mame.
  
**Configuration Tab**  
 * Mame Path* - Path to mame executable.  Should include executable name.  ex. c:\mame\mame64.exe  
 * Rom Path* - Path to directory that contains rom files used by Mame.  ex. c:\mame\roms
 * RomPath List* - Path to file that contains a list of rom names.  Should include file name. ex. c:\mame\romlist.txt  
   * mamesscfg.exe includes a button to generate the list.  The list consists of the files from the roms directory with the extension removed (ex. thisgame.zip becomes thisgame).  If you are using a merged set, it will only capture the primary game.
   * I recommend using Romlister instead to generate your list of roms.  Export from romlister in csv format with only the name of the rom included. Use that file as your romlist source.  https://www.waste.org/~winkles/ROMLister/
 * Config Path - Location of the MAME config files. ex. c:\mame\cfg
 * Snapshot Path - Location of the MAME snapshots. ex. c:\mame\snapshots
 * NVRAM Path - Location of the MAME NVRAM files. ex. c:\mame\nvram
 * Run Time - Amount of time in seconds to run ROM.
 * Volume - Volume of running ROM.
 * Arguments - Any additional arguments you want to pass to mame executable.
 * Save button - Click this button once your configuration is set to save your settings.
 * Load Defaults button - Resets all settings to default, but will not take effect until it is saved. 
 * Load ini button - Will reload settings from .ini file
 
 \* = required

**Screensaver Tab**
 * Screensaver timeout - Amount of idle time in seconds before screensaver starts.
 * [Setup Screensaver] Button - Click this button once you are ready to enable the mame screensaver as the default.
   * Enables screensaver, sets mame screensaver as active screensaver and sets screensaver timeout value.
 * [Remove Screensaver] Button - Removes mame screensaver as default and sets blank screen as new default.
 * [Generate Rom List] Button - Creates txt file list of rom names.  List is based of off rom path and saved to the rom list path directory.

