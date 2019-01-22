FROM ubuntu:18.04

MAINTAINER Kalemena

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena OpenCV" \
      org.label-schema.description="Kalemena OpenCV" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/docker-opencv" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# https://docs.opencv.org/3.4.1/d2/de6/tutorial_py_setup_in_ubuntu.html
# https://github.com/milq/milq/blob/master/scripts/bash/install-opencv.sh
RUN apt-get update -y; \
    apt-get upgrade -y; \
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential cmake tzdata unzip wget \
        qt5-default libvtk6-dev \
        zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libopenexr-dev libgdal-dev \
        libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev \
        libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev \
        libtbb-dev libeigen3-dev \
        python-dev python-tk python-numpy python3-pip python3-dev python3-tk python3-numpy \
        default-jdk \
        doxygen; \
    apt-get clean; \
 	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

RUN pip3 --no-cache-dir install wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib;

# libjasper-dev
# RUN git clone https://github.com/jasperproject/jasper-client.git jasper && \
#  		chmod +x jasper/jasper.py && \
# 		pip install --upgrade setuptools && \ 
# 		pip install -r jasper/client/requirements.txt

RUN wget https://github.com/opencv/opencv/archive/${VERSION}.zip; \
    unzip ${VERSION}.zip; \
    rm ${VERSION}.zip; \
    mv opencv-${VERSION} /opt/opencv; \
    cd /opt/opencv; \
    mkdir build; \
    cd build; \
    cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..; \
    make -j4; \
    make install; \
    ldconfig

# sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
# sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
# sudo apt -y install libatlas-base-dev
# sudo apt -y install libfaac-dev libmp3lame-dev
# sudo apt -y install libavresample-dev
# sudo apt -y install x264 v4l-utils
 
# # Optional dependencies
# sudo apt -y install libprotobuf-dev protobuf-compiler
# sudo apt -y install libgoogle-glog-dev libgflags-dev
# sudo apt -y install libgphoto2-dev libhdf5-dev doxygen
# sudo apt -y install python3-testresources

# # now install python libraries within this virtual environment
# pip install wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib

# add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
# apt -y update
# libjasper1 libtiff-dev
# apt-get install -y x264 gtk2-devel ffmpeg-devel gstreamer-plugins-base-devel jasper-devel;
# checkinstall pkg-config yasm libjpeg8-dev
# git gfortran software-properties-common
# cd /usr/include/linux
# sudo ln -s -f ../libv4l1-videodev.h videodev.h
# cd "$cwd"

# git clone https://github.com/opencv/opencv_contrib.git

# cmake -D CMAKE_BUILD_TYPE=RELEASE \
#             -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$cvVersion" \
#             -D INSTALL_C_EXAMPLES=ON \
#             -D INSTALL_PYTHON_EXAMPLES=ON \
#             -D WITH_TBB=ON \
#             -D WITH_V4L=ON \
#             -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python3.5/site-packages \
#         -D WITH_QT=ON \
#         -D WITH_OPENGL=ON \
#         -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
#         -D BUILD_EXAMPLES=ON ..

CMD [ "/bin/bash" ]