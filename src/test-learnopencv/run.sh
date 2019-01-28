
#!/bin/bash

mkdir -p samples/learnopencv

git clone https://github.com/spmallick/learnopencv.git samples/learnopencv

docker run -it --rm -p 8888:8888 \
    --device /dev/video0 \
    -e "DISPLAY" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v $PWD/samples/learnopencv:/notebooks \
    kalemena/opencv:latest
