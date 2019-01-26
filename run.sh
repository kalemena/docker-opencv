#!/bin/bash
xhost +local:
DISPLAY=docker.for.linux.localhost:0
# docker run -it --rm \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -v $HOME:$HOME \
#     -v /home/clement/workspace/repos/kalemena/docker-opencv/src/:/notebooks \
#     -e DISPLAY=unix$DISPLAY \
#     --user $UID:$GID \
#     --privileged \
#     kalemena/opencv:4.0.1

docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:$HOME \
    -e DISPLAY=$DISPLAY \
    -e $HOME=$HOME \
    -e $USER=$USER \
    --user $UID:$GID \
    kalemena/opencv:latest /bin/bash
