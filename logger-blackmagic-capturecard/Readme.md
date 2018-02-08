# Docker file for logger with cameras


## Downloading Blackmagic software

Because the blackmagic software cannot be downloaded without agreeing to the license, please download "Desktop Video 10.8.5" for Linux from [https://www.blackmagicdesign.com/support/family/capture-and-playback](https://www.blackmagicdesign.com/support/family/capture-and-playback) and place it in this folder.

Note: You do not need the SDK, just the plain Desktop Video product. The registration has a "Download only" link in the bottom left to bypass.

## Getting logger distribution

First, clone ihmc-open-robotics and run "gradle loggerDistTar" in ihmc-robot-data-logger. 

This will create a tarball in ihmc-robot-data-logger/build/distributions/ihmc-robot-data-logger-LOCAL.tar. Copy this tarball to the current directory.

## Creating docker file
