#!/bin/bash

IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')

xhost + $IP

#DISPLAY=docker.for.mac.host.internal:0
#DISPLAY=host.docker.internal:0
DISPLAY=$IP:0

docker run -it --rm \
    -p 8888:8888 \
    -v $(`pwd`)/:/notebooks \
    -e DISPLAY=$DISPLAY \
    kalemena/opencv:4.0.1

# docker run -it --rm \
#     -p 8888:8888 \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -v $HOME:$HOME \
#     -v $(`pwd`)/:/notebooks \
#     -e DISPLAY=$DISPLAY \
#     --user $UID:$GID \
#     --privileged \
#     kalemena/opencv:4.0.1