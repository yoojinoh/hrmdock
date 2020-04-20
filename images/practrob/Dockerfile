# [SSH IGNORE]
FROM ubuntu:18.04
MAINTAINER Jim Mainprice <mainprice@gmail.com>
# [/SSH IGNORE]

# this is only to speed up
# the make installUbuntuAll would do the same in the test shell...

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get --yes update
RUN apt-get --yes install \
    apt-utils git sudo g++ make gnupg gdb cmake \
    x11-apps mesa-utils \
    nano emacs terminator lsb-release gnuplot

##########################################################
# pre-install debian packages (literal output of make printUbuntuAll)
RUN apt-get --yes install \
    g++ gnuplot libjsoncpp-dev libx11-dev \
    liblapack-dev libf2c2-dev libeigen3-dev \
    libann-dev liblapack-dev libf2c2-dev \
    libfcl-dev libassimp-dev libglew-dev freeglut3-dev libqhull-dev \
    libglew-dev freeglut3-dev \
    libassimp-dev libglew-dev freeglut3-dev \
    libx11-dev libglfw3-dev libglew-dev freeglut3-dev graphviz-dev \
    libglew-dev freeglut3-dev \
    libglew-dev freeglut3-dev liblapack-dev libf2c2-dev \
    libglew-dev freeglut3-dev liblapack-dev libf2c2-dev libopencv-dev \
    pybind11-dev python3-dev python3 python3-numpy python3-pip python3-distutils

##########################################################
RUN apt-get install -y python3-pip
RUN sudo -H pip3 install --no-cache-dir --upgrade \
    numpy  \
    jupyter  \
    matplotlib  \
    opencv-python

##########################################################
# Install Physx 3.4 (literally from https://github.com/MarcToussaint/rai-maintenance/blob/master/help/localSourceInstalls.md#physx)
RUN \
    mkdir -p $HOME/git && \
    cd $HOME/git && \
    git clone https://github.com/NVIDIAGameWorks/PhysX.git && \
    cd PhysX && \
    git checkout 3.4 && \
    cd PhysX_3.4/Source/compiler/linux64 && \
    make release && \
    mkdir -p $HOME/opt/physx3.4/lib && \
    mkdir -p $HOME/opt/physx3.4/include/physx && \
    cd $HOME/git/PhysX && \
    cp PhysX_3.4/Bin/linux64/* $HOME/opt/physx3.4/lib && \
    cp PhysX_3.4/Lib/linux64/* $HOME/opt/physx3.4/lib && \
    cp PxShared/bin/linux64/* $HOME/opt/physx3.4/lib && \
    cp -R PhysX_3.4/Include/* $HOME/opt/physx3.4/include/physx && \
    cp -R PxShared/include/* $HOME/opt/physx3.4/include/physx && \
    rm -Rf $HOME/git/PhysX
    ENV LD_LIBRARY_PATH = "${LD_LIBRARY_PATH}:$HOME/opt/physx3.4/lib"


##########################################################
# This is then mounted by the user to a shared folder

RUN mkdir -p /workspace

#[SSH IGNORE]
##########################################################
# setup repo
# make -j1 installUbuntuAll  && \
RUN cd /workspace  && \
	git clone https://github.com/MarcToussaint/robotics-course.git  && \
	cd robotics-course  && \
	git submodule init  && \
	git submodule update  && \
	mkdir build  && \
	cd build  && \
	cmake ..  && \
	make -j $(command nproc)

WORKDIR /workspace
#[/SSH IGNORE]