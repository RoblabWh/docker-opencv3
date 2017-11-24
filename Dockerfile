FROM ubuntu:16.04 
MAINTAINER roblabfhge <roblab2011@googlemail.com> 

ENV HOME /root 
ENV DEBIAN_FRONTEND noninteractive 

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN apt-get update && \
    apt-get install -y --force-yes build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
                    libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev \
                    python3-dev python3-tk python3-numpy libpcl1.7 libpcl-dev emacs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*
RUN mkdir ~/opencv
RUN cd ~/opencv && git clone https://github.com/Itseez/opencv_contrib.git && cd opencv_contrib && git checkout 3.3.1
RUN cd ~/opencv && git clone https://github.com/Itseez/opencv.git && cd opencv && git checkout 3.3.1
RUN cd ~/opencv/opencv && mkdir release && cd release && \
          cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
          -D INSTALL_C_EXAMPLES=ON \
          -D INSTALL_PYTHON_EXAMPLES=ON \
          -D BUILD_EXAMPLES=ON \
          -D WITH_OPENGL=ON \
          -D WITH_V4L=ON \
          -D WITH_XINE=ON \
          -D WITH_TBB=ON ..
RUN cd ~/opencv/opencv/release && make -j $(nproc) && make install



