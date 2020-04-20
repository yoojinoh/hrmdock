FROM ubuntu:18.04

RUN apt-get --yes update
RUN apt-get --yes install \
    git sudo g++ make gnupg \
    x11-apps mesa-utils \
    nano emacs terminator lsb-release gnuplot

# this is only to speed up
# the make installUbuntuAll would do the same in the test shell...

RUN apt-get --yes install \
     liblapack-dev libf2c2-dev libeigen3-dev \
     libx11-dev libglfw3-dev libglew-dev freeglut3-dev graphviz-dev \
     libjsoncpp-dev libassimp-dev libqhull-dev libann-dev \
     cmake \
     autoconf \
     libfcl-dev

RUN mkdir -p /workspace/git

##########################################################
# Install Physx 3.4

RUN cd /workspace/git  && \
	git clone https://github.com/NVIDIAGameWorks/PhysX.git  && \
	cd PhysX  && \
	git checkout 3.4  && \
	cd PhysX_3.4/Source/compiler/linux64  && \
	make release  && \
	mkdir -p /opt/physx3.4/lib  && \
	mkdir -p /opt/physx3.4/include/physx  && \
	cd /workspace/git/PhysX  && \
	cp PhysX_3.4/Bin/linux64/* /opt/physx3.4/lib  && \
	cp PhysX_3.4/Lib/linux64/* /opt/physx3.4/lib  && \
	cp PxShared/bin/linux64/* /opt/physx3.4/lib  && \
	cp -R PhysX_3.4/Include/* /opt/physx3.4/include/physx  && \
	cp -R PxShared/include/* /opt/physx3.4/include/physx  && \
	rm -rf /workspace/git/PhysX

ENV LD_LIBRARY_PATH = "${LD_LIBRARY_PATH}:/opt/physx3.4/lib"
##########################################################
# setup repo
# make -j1 installUbuntuAll  && \

RUN cd /workspace/git  && \
	git clone https://github.com/MarcToussaint/robotics-course.git  && \
	cd robotics-course  && \
	git submodule init  && \
	git submodule update  && \
	make -j1 installUbuntuAll  && \
	mkdir build  && \
	cd build  && \
	cmake ..  && \
	make -j $(command nproc)

WORKDIR /root