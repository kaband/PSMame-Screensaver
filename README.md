# Mame-Screensaver
This is a screensaver which uses MAME to run roms in an attract mode fashion selecting roms at random, playing for a given time then moving on to the next rom.
 
**Prerequisites**  
* .NET Framework 4.5.2 (or higher) - https://www.microsoft.com/en-us/download/details.aspx?id=42643  
* Powershell 5.0/5.1 - https://www.microsoft.com/en-us/download/details.aspx?id=54616 (part of Windows Management Framework)
* MAME - https://www.mamedev.org/  
* Windows OS - Windows 10, 8, or 7 should work fine as long as .net 4.5.2 and powershell 5.0/5.1 from Windows Management Framework is installed 

**Installation**
* Download the zip file with the binaries inside.  
  * mame_scr_scr - Screensaver file  
  * mamesscfg.exe - Configuration utility for screensaver  
  * mame_scr.ini - Configuration itself
* Extract zip to directory of your choosing
* Copy mame_scr.scr and mame_scr.ini to the c:\windows\system32 directory

**Configuration**  
* Run the mamesscfg.exe file to launch the configuration utility - this will put your configuration settings into the .ini file
  * Should be launched as administrator in order to edit mame_scr.ini file copied into c:\windows\system32
* Settings
  * Mame Path - Path to mame executable.  Should include executable name.  ex. c:\mame\mame64.exe  
  * Rom Path - Path to directory that contains rom files used by Mame.  
  * Rom Path list - Path to file that contains a list of rom names.  Should include file name. ex. c:\mame\romlist.txt  
    * The utility has a button to generate the list
    * Gives you the ability to filter out certain roms by editing the list.  For example instead of using the generate list button from the mamesscfg.exe utility, Romlister could be used instead to make a curated list - https://www.waste.org/~winkles/ROMLister/
