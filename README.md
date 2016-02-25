# IHMC Logger Docker

Dockerfile repository for running the IHMC Logger distribution as a Docker container.

## Cameras vs. No Cameras

The IHMC Logger software can be synced up with video data. Currently, the docker distribution only supports a no-camera configuration. Adding camera support to the docker container is on the roadmap.

## Rebuilding the container

If you want to clone this repo and build your own container from the Dockerfile, then it currently requires you to clone https://github.com/ihmcrobotics/ihmc-open-robotics-software and build the Logger distribution included with the RobotDataCommunication project.

Clone the project, navigate to the `RobotDataCommunication` directory, and then run

    gradle loggerDistTar

This will output the tarball to `RobotDataCommunication/build/distributions`. Move the tarball to the same directory as the Dockerfile then run the build.
