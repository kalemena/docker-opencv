#!/bin/bash
xhost +local:
cd $HOME
docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:$HOME \
    -e DISPLAY=unix$DISPLAY \
    --user $UID:$GID \
    --privileged \
    kalemena/opencv:4.0.1 /bin/bash -c "export HOME=$HOME; USER=$USER; cd $HOME; /bin/bash"