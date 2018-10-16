#!/bin/sh

USER_NAME=`basename $HOME`

sudo xhost + local:docker       # xhost+ slightly unsafe
# assuming GPU is the standard
if [ -z "$1" ] || [ "$1" -ne "cpu" ]; then
   echo "Mounting docker GPU image.."
   nvidia-docker run -ti --rm \
     -e DISPLAY=$DISPLAY \
     -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
     -v `pwd`:/data \
     andreotti/deeplearn:gpu
else 
    echo "Mounting docker CPU image.."
    docker run -ti --rm --device /dev/dri \     # dri
        -e DISPLAY=unix$DISPLAY \               # outputing display
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \   # also enable X11 socket
        -v `pwd`:/data \                        # map current folder to /data
        andreotti/deeplearn:cpu                 # image name    
fi
