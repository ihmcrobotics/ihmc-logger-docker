#                    ##        .
#              ## ## ##       ==
#           ## ## ## ##      ===
#       /""""""""""""""""___/ ===
#  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
#       \______ L          __/
#        \    \        __/
#          \____\______/
#
#  -- DOCKERFILE --
#
# IHMC UoEC libAMERA LOGGER
FROM ubuntu:16.04 AS build
MAINTAINER Jesper Smith <jesper@halodi.com>

#ENV QNAP_QTS_KERNEL_SOURCE=https://downloads.sourceforge.net/project/qosgpl/QNAP%20NAS%20GPL%20Source/QTS%204.3.4/GPL_QTS-4.3.4-20180105_Kernel.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fqosgpl%2Ffiles%2FQNAP%2520NAS%2520GPL%2520Source%2FQTS%25204.3.4%2FGPL_QTS-4.3.4-20180105_Kernel.tar.gz%2Fdownload&ts=1518009223
ENV BLACKMAGIC_PACKAGE=Blackmagic_Desktop_Video_Linux_10.8.5.tar.gz
ENV BLACKMAGIC_VERSION=10.8.5a4
ENV KERNEL_VERSION=4.2.8
ENV QNAP_PPA=ppa:fcwu-tw/ppa


ADD ${BLACKMAGIC_PACKAGE} /root/



RUN DEBIAN_FRONTEND=noninteractive apt-get update -qqy 


# Get required base set of tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y software-properties-common

RUN DEBIAN_FRONTEND=noninteractive add-apt-repository -y ppa:fcwu-tw/ppa
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y

# Get required base set of tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	dkms linux-headers-generic libgl1-mesa-glx libgl1 libxml2 linux-headers-${KERNEL_VERSION}


RUN mkdir -p /lib/modules/${KERNEL_VERSION}/
RUN ln -s /root/${QNAP_QTS_KERNEL_PATH} /lib/modules/${KERNEL_VERSION}/build

RUN DEBIAN_FRONTEND=noninteractive dpkg -i /root/Blackmagic_Desktop_Video_Linux_${BLACKMAGIC_VERSION}/deb/amd64/desktopvideo_${BLACKMAGIC_VERSION}_amd64.deb

RUN dkms build -m blackmagic -v ${BLACKMAGIC_VERSION} -k ${KERNEL_VERSION}
RUN dkms install -m blackmagic -v ${BLACKMAGIC_VERSION} -k ${KERNEL_VERSION}

RUN dkms build -m blackmagic-io -v ${BLACKMAGIC_VERSION} -k ${KERNEL_VERSION}
RUN dkms install -m blackmagic-io -v ${BLACKMAGIC_VERSION} -k ${KERNEL_VERSION}


# Create final image
FROM ubuntu:16.04
ENV INITRD No
ENV LOGGER_VERSION=LOCAL
ENV BLACKMAGIC_VERSION=10.8.5a4
ENV KERNEL_VERSION=4.2.8

ENV HOST=192.168.0.194
ENV HOST_USER=admin
ENV HOST_PASSWORD=admin

COPY --from=build /lib/modules/${KERNEL_VERSION} /lib/modules/${KERNEL_VERSION}
COPY --from=build /root/Blackmagic_Desktop_Video_Linux_${BLACKMAGIC_VERSION}/deb/amd64/desktopvideo_${BLACKMAGIC_VERSION}_amd64.deb /root

# Get required base set of tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qqy && \
        apt-get install --no-install-recommends -y \
	libavformat-ffmpeg56 libavcodec-ffmpeg56 libswscale-ffmpeg3 libboost-thread1.58.0 openjdk-8-jre-headless module-init-tools openssh-client sshpass vim-tiny net-tools && \ 
        rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.ihmc /root/robotLogs
RUN dpkg --force-depends -i /root/desktopvideo_${BLACKMAGIC_VERSION}_amd64.deb
ADD ihmc-robot-data-logger-${LOGGER_VERSION}.tar /root/
RUN ln -s /root/ihmc-robot-data-logger-${LOGGER_VERSION} /root/ihmc-robot-data-logger




VOLUME ["/root/robotLogs"]

#CMD ["/bin/bash", "-c", "/root/ihmc-robot-data-logger/bin/ihmc-robot-data-logger -d /root/robotLogs"]

#RUN BlackMagicFirmwareUpdaterh
ADD startLogger.sh /root/
RUN chmod 777 /root/startLogger.sh

CMD ["/bin/bash", "/root/startLogger.sh"]
