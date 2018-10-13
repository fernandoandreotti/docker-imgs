#!/bin/sh

type=$1
USER_NAME=`basename $HOME`

sudo xhost + local:docker       # xhost+
if [ $1 = "cpu" ]; then
    echo "Mounting docker CPU image.."
    docker run -ti --rm  \
        -e DISPLAY=unix$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v `pwd`:/data \
        andreotti/deeplearn:cpu
# assuming GPU is the standard
else
    echo "Mounting docker GPU image.."
    nvidia-docker run -ti --rm \
     -e DISPLAY=$DISPLAY \
     -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
     -v `pwd`:/data \
     andreotti/deeplearn:gpu
fi




