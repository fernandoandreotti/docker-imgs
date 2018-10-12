#!/bin/sh

echo "Mounting docker image.."
USER_NAME=`basename $HOME`

#sudo xhost + local:docker       # xhost+
if ["$1" == "cpu" ]; then
    docker run -ti --rm --device /dev/dri \     # dri
        -e DISPLAY=unix$DISPLAY \               # outputing display
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \   # also enable X11 socket
        -v `pwd`:/data \                        # map current folder to /data
        andreotti/deeplearn:cpu                 # image name
# assuming GPU is the standard
else 
    nvidia-docker run -ti --rm \
     -e DISPLAY=$DISPLAY \
     -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
     -v `pwd`:/data \
     andreotti/deeplearn:gpu
fi




