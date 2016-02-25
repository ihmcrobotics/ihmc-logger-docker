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
# IHMC UoE NON CAMERA LOGGER
FROM ubuntu:14.04
MAINTAINER Doug Stephen <dstephen@ihmc.us>

ENV INITRD No
ENV IHMC_LOGGER_IP=localhost

# RUN ln -sf /usr/share/zoneinfo/America/Chicago localtime
RUN ln -sf /usr/share/zoneinfo/Europe/London localtime
RUN locale-gen en_US.UTF-8

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qqy \
	&& DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Get required base set of tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	wget curl apt-utils nano openjdk-7-jre-headless apparmor-utils build-essential

RUN mkdir -p /root/.ihmc /root/robotLogs

COPY ./IHMCLogger*.tar /root

RUN tar -xf /root/IHMCLogger*.tar -C /root

VOLUME ["/root/robotLogs"]

CMD ["/bin/bash", "-c", "~/IHMCLogger/bin/IHMCLogger", "-n"]
# CMD ["-c", "/root/IHMCLogger/bin/IHMCLogger", "-n"]