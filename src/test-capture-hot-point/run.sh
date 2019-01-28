#!/bin/bash

docker run -it --rm -p 8888:8888 \
    --device /dev/video0 \
    -e "DISPLAY" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $PWD/src:/notebooks \
    kalemena/opencv:latest