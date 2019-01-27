#!/bin/bash

mkdir -p samples/object_detector_app

git clone https://github.com/datitran/object_detector_app.git samples/object_detector_app

docker run -it --rm -p 8888:8888 \
    --device /dev/video0 \
    -e "DISPLAY" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $PWD/samples/object_detector_app:/opt/object_detector_app \
    kalemena/opencv:latest /bin/bash -c "cd /opt/object_detector_app; python3 object_detection_app.py"