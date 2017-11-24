#!/bin/bash

#xhost + local:
QT_GRAPHICSSYSTEM="native" docker run --rm \
	--name opencv3 \
        --privileged \
   	-e DISPLAY=unix$DISPLAY \
	-e LOCAL_USER_ID=`id -u $USER` \
        --cap-add sys_ptrace \
	--device /dev/dri \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /etc/machine-id:/etc/machine-id \
	-v /home/$USER/stereo:/home \
	--network="host" \
	-it roblabfhge/opencv3 bash 


