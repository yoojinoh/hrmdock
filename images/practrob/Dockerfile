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

RUN apt-get --yes install \
  gdal-data i965-va-driver \
  ibverbs-providers javascript-common libaacs0 \
  libaec0 libarmadillo8 libarpack2 libavcodec-dev libavcodec57 libavformat-dev \
  libavformat57 libavresample-dev libavresample3 libavutil-dev libavutil55 \
  libbdplus0 libbluray2 libcharls1 libchromaprint1 libcrystalhd3 libdap25 \
  libdapclient6v5 libdc1394-22 libdc1394-22-dev libepsilon1 libexif-dev \
  libexif-doc libexif12 libfabric1 libfreexl1 libfyba0 libgdal20 libgdcm2-dev \
  libgdcm2.8 libgeos-3.6.2 libgeos-c1v5 libgeotiff2 libgl2ps1.4 libgme0 \
  libgphoto2-6 libgphoto2-dev libgphoto2-l10n libgphoto2-port12 libgsm1 \
  libhdf4-0-alt libhdf5-100 libhdf5-openmpi-100 libhwloc-plugins libhwloc5 \
  libibverbs1 libilmbase-dev libilmbase12 libjbig-dev libjpeg-dev \
  libjpeg-turbo8-dev libjpeg8-dev libjs-jquery libjson-c3 libkmlbase1 \
  libkmldom1 libkmlengine1 liblept5 liblzma-dev libmp3lame0 libmpg123-0 \
  libmysqlclient20 libnetcdf-c++4 libnetcdf13 libnl-3-200 libnl-route-3-200 \
  libnspr4 libnss3 libnuma1 libodbc1 libogdi3.2 libogg0 libopencv-calib3d-dev \
  libopencv-calib3d3.2 libopencv-contrib-dev libopencv-contrib3.2 \
  libopencv-core-dev libopencv-core3.2 libopencv-features2d-dev \
  libopencv-features2d3.2 libopencv-flann-dev libopencv-flann3.2 \
  libopencv-highgui-dev libopencv-highgui3.2 libopencv-imgcodecs-dev \
  libopencv-imgcodecs3.2 libopencv-imgproc-dev libopencv-imgproc3.2 \
  libopencv-ml-dev libopencv-ml3.2 libopencv-objdetect-dev \
  libopencv-objdetect3.2 libopencv-photo-dev libopencv-photo3.2 \
  libopencv-shape-dev libopencv-shape3.2 libopencv-stitching-dev \
  libopencv-stitching3.2 libopencv-superres-dev libopencv-superres3.2 \
  libopencv-ts-dev libopencv-video-dev libopencv-video3.2 \
  libopencv-videoio-dev libopencv-videoio3.2 libopencv-videostab-dev \
  libopencv-videostab3.2 libopencv-viz-dev libopencv-viz3.2 libopencv3.2-java \
  libopencv3.2-jni libopenexr-dev libopenexr22 libopenjp2-7 libopenmpi2 \
  libopenmpt0 libopus0 libpng-dev libpng-tools libpoppler73 libpq5 libproj12 \
  libpsm-infinipath1 libpython2.7 libraw1394-11 libraw1394-dev \
  libraw1394-tools librdmacm1 libshine3 libsnappy1v5 libsocket++1 libsoxr0 \
  libspatialite7 libspeex1 libssh-gcrypt-4 libsuperlu5 libswresample-dev \
  libswresample2 libswscale-dev libswscale4 libsz2 libtbb-dev libtbb2 \
  libtcl8.6 libtesseract4 libtheora0 libtiff-dev libtiff5-dev libtiffxx5 \
  libtk8.6 libtwolame0 liburiparser1 libusb-1.0-0 libva-drm2 libva-x11-2 \
  libva2 libvdpau1 libvorbis0a libvorbisenc2 libvorbisfile3 libvpx5 libvtk6.3 \
  libwavpack1 libwebpmux3 libx264-152 libx265-146 libxerces-c3.2 libxss1 \
  libxvidcore4 libzvbi-common libzvbi0 mesa-va-drivers mesa-vdpau-drivers \
  mysql-common ocl-icd-libopencl1 odbcinst odbcinst1debian2 opencv-data \
  openmpi-bin openmpi-common proj-bin proj-data tzdata va-driver-all \
  vdpau-driver-all zlib1g-dev pybind11-dev python3-numpy python3-distutils


##########################################################
RUN apt-get install -y python3-pip
RUN sudo -H pip3 install --no-cache-dir --upgrade \
    numpy  \
    jupyter  \
    matplotlib  \
    opencv-python

RUN mkdir -p /root/workspace

##########################################################
# Install Physx 3.4

RUN cd /root/workspace  && \
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

RUN cd /root/workspace  && \
	git clone https://github.com/MarcToussaint/robotics-course.git  && \
	cd robotics-course  && \
	git submodule init  && \
	git submodule update  && \
	mkdir build  && \
	cd build  && \
	cmake ..  && \
	make -j $(command nproc)

WORKDIR /root