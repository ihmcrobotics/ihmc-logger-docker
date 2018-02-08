#!/bin/sh

host=10.0.5.0
user=admin
password=admin

sshpass -p "${password}" scp /lib/modules/`uname -r`/updates/dkms/blackmagic.ko /lib/modules/`uname -r`/updates/dkms/blackmagic-io.ko ${user}@${host}:/lib/modules/`uname -r`
sshpass -p "${password}" ssh ${user}@${host} depmod
sshpass -p "${password}" ssh ${user}@${host} modprobe blackmagic
sshpass -p "${password}" ssh ${user}@${host} modprobe blackmagic-io

mkdir /dev/blackmagic
mknod -m 666 /dev/blackmagic/io0 c 10 54
mknod -m 666 /dev/blackmagic/io1 c 10 53
mknod -m 666 /dev/blackmagic/io2 c 10 52
mknod -m 666 /dev/blackmagic/io3 c 10 51

/usr/lib/blackmagic/BlackmagicPreferencesStartup add /dev/blackmagic/io0
/usr/lib/blackmagic/BlackmagicPreferencesStartup add /dev/blackmagic/io1
/usr/lib/blackmagic/BlackmagicPreferencesStartup add /dev/blackmagic/io2
/usr/lib/blackmagic/BlackmagicPreferencesStartup add /dev/blackmagic/io3
