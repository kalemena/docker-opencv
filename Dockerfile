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
        python-dev python-tk python-numpy python3-dev python3-tk python3-numpy \
        default-jdk \
        doxygen; \
    apt-get clean; \
 	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

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

# RUN apt-get install -y gtk2-devel ffmpeg-devel gstreamer-plugins-base-devel jasper-devel;

CMD [ "/bin/bash" ]




















# sudo apt -y remove x264 libx264-dev
 
# ## Install dependencies
# sudo apt -y install build-essential checkinstall cmake pkg-config yasm
# sudo apt -y install git gfortran
# sudo apt -y install libjpeg8-dev libpng-dev
 
# sudo apt -y install software-properties-common
# sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
# sudo apt -y update
 
# sudo apt -y install libjasper1
# sudo apt -y install libtiff-dev
 
# sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
# sudo apt -y install libxine2-dev libv4l-dev
# cd /usr/include/linux
# sudo ln -s -f ../libv4l1-videodev.h videodev.h
# cd "$cwd"
 
# sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
# sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
# sudo apt -y install libatlas-base-dev
# sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
# sudo apt -y install libvorbis-dev libxvidcore-dev
# sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
# sudo apt -y install libavresample-dev
# sudo apt -y install x264 v4l-utils
 
# # Optional dependencies
# sudo apt -y install libprotobuf-dev protobuf-compiler
# sudo apt -y install libgoogle-glog-dev libgflags-dev
# sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

# sudo apt -y install python3-dev python3-pip
# sudo -H pip3 install -U pip numpy
# sudo apt -y install python3-testresources

# cd $cwd
# ############ For Python 3 ############
# # create virtual environment
# python3 -m venv OpenCV-"$cvVersion"-py3
# echo "# Virtual Environment Wrapper" >> ~/.bashrc
# echo "alias workoncv-$cvVersion=\"source $cwd/OpenCV-$cvVersion-py3/bin/activate\"" >> ~/.bashrc
# source "$cwd"/OpenCV-"$cvVersion"-py3/bin/activate
 
# # now install python libraries within this virtual environment
# pip install wheel numpy scipy matplotlib scikit-image scikit-learn ipython dlib
  
# # quit virtual environment
# deactivate

# git clone https://github.com/opencv/opencv.git
# cd opencv
# git checkout $cvVersion
# cd ..
 
# git clone https://github.com/opencv/opencv_contrib.git
# cd opencv_contrib
# git checkout $cvVersion
# cd ..

# cd opencv
# mkdir build
# cd build

