#!/bin/bash
xhost +local:
docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:$HOME \
    -v /home/clement/workspace/repos/kalemena/docker-opencv/src/:/src \
    -e DISPLAY=unix$DISPLAY \
    --user $UID:$GID \
    --privileged \
    kalemena/opencv:4.0.1 /bin/bash -c "export HOME=$HOME; USER=$USER; cd $HOME; /bin/bash"