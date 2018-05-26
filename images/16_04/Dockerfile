# [SSH IGNORE]

FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},display
MAINTAINER Jim Mainprice <jim.mainprice@ipvs.uni-stuttgart.de>

###################################################################################
# This Dockerfile is also used to generate the official image install ssh 
# script. (see desktop_update folder in amd-clmc/official_images)
# The [SSH IGNORE*]  [/SSH IGNORE*] ; [SSH ONLY*] [/SSH ONLY*] tags are here to indicate
# what will go in the official ssh install script and what will not
###################################################################################

# [/SSH IGNORE]

###############################################################################
# We add all other repositories.
###############################################################################
RUN apt-get update && \
    apt-get install -y \
    curl \
    wget \
    git \
    software-properties-common \
    apt-transport-https

RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
    wget http://packages.ros.org/ros.key -O - | apt-key add -


###################
# required for ldap
###################
#[SSH ONLY]
#apt-get install -y \
#    nfs-kernel-server \
#    portmap \
#    gnome-session-fallback \
#    autofs 
#[/SSH ONLY]

###########################################
# required for cvmfs mount, used for matlab
###########################################
#[SSH ONLY]
# cd /tmp && wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb && dpkg -i cvmfs-release-latest_all.deb
# apt-get update && apt-get install -y cvmfs
#[/SSH ONLY]

# Install sublimetext
RUN wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - && \
    echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list && \
    apt-get update && \
    apt-get install -y sublime-text

RUN apt-get install -y \
    python-pip \
    python-catkin-tools \
    python-rosdep \
    python-rosinstall \
    python-rospkg \
    python-wstool 


RUN apt-get install -y \
    ros-kinetic-desktop-full \
    ros-kinetic-audio-common \
    ros-kinetic-catkin \
    ros-kinetic-cmake-modules \
    ros-kinetic-control-toolbox \
    ros-kinetic-driver-common \
    ros-kinetic-ecto \
    ros-kinetic-gazebo-ros-control \
    ros-kinetic-gazebo-ros-pkgs \
    ros-kinetic-joint-state-publisher \
    ros-kinetic-joy \
    ros-kinetic-kdl-parser \
    ros-kinetic-moveit \
    ros-kinetic-moveit-core \
    ros-kinetic-octomap \
    ros-kinetic-octomap-msgs \
    ros-kinetic-octomap-rviz-plugins \
    ros-kinetic-ompl \
    ros-kinetic-openni-* \
    ros-kinetic-pcl-conversions \
    ros-kinetic-qt-build \
    ros-kinetic-realtime-tools \
    ros-kinetic-robot-state-publisher \
    ros-kinetic-ros-control \
    ros-kinetic-ros-controllers \
    ros-kinetic-tf-conversions \
    ros-kinetic-tf-conversions \
    ros-kinetic-turtlebot-* \
    ros-kinetic-robot-self-filter \
    ros-kinetic-xacro  

# TODO
# ros-kinetic-fcl \ NOT ON KINETIC
# ros-kinetic-keyboard \ NOT ON KINETIC

RUN rosdep init && rosdep update

RUN apt-get install -y \
    emacs \
    synaptic \
    apt-file \
    alien \
    asciidoc \
    autoconf \
    autofs \
    awesome \
    bash-completion \
    bc \
    binutils \
    build-essential \
    ccache \
    cmake \
    cmake \
    cmake-curses-gui \
    curl \
    curl \
    doxygen \
    f2c \
    freeglut3 \
    freeglut3-dev \
    gdb \
    gfortran \
    git-svn \
    imagemagick \
    iputils-ping \
    less \
    libace-dev \
    libblas-dev \
    libc6-dev \
    libcairo2-dev \
    libconfig++8-dev \
    libdbus-1-dev \
    libedit-dev \
    libedit-dev \
    libeigen3-dev \
    libeinspline-dev \
    libeinspline-dev \
    libevent-dev \
    libf2c2-dev \
    libffi-dev \
    libgflags-dev \
    libgflags2v5 \
    libgirepository1.0-dev \
    libglew1.6-dev \
    libgoogle-glog-dev \
    libhdf5-dev \
    liblapack-dev \
    liblua5.1-0-dev \
    libncurses5-dev \
    libpango1.0-dev \
    libslicot-dbg \
    libslicot-dev \
    libslicot0 \
    libssl-dev \
    libstartup-notification0-dev \
    libx11-xcb-dev \
    libxcb-cursor-dev \
    libxcb-icccm4-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-render-util0-dev \
    libxcb-shape0-dev \
    libxcb-util0-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libxcb-xtest0-dev \
    libxcb1-dev \
    libxdg-basedir-dev \
    libxinerama-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libxmu-dev \
    lsb-release \
    luarocks \
    m4 \
    man \
    mesa-utils \
    net-tools \
    ntp \
    ntpdate \
    openssh-server \
    patch \
    picocom \
    python-dev \
    python-netifaces \
    python-pip \
    python-vcstool \
    python-vcstools \
    python-wstool \
    rpm \
    scons \
    screen \
    shellcheck \
    ssh \
    sshpass \
    sudo \
    swig \
    tcsh \
    vim \
    vim \
    wget \
    xmlto \
    xutils-dev \
    protobuf-compiler \
    protobuf-c-compiler 

# TODO
# git-lfs \  # NOT FOUND ON XENIAL # Replaced with libgflags2
# libdart5-dev \ # NOT FOUND ON XENIAL
# libgflags2 \ # NOT FOUND ON XENIAL # Replaced with libgflags2v5
# emacs-snapshot \ # NOT FOUND ON XENIAL
# libwxgtk2.8-dbg \ # NOT FOUND ON XENIAL
# libwxgtk2.8-dev \ # NOT FOUND ON XENIAL

#######
# JAVA
#######
# for some reason, that does not seem to work in docker ...
# not a big deal, for the moment necessary mostly for crashplan
######## commented: commands below broken. We should find a new way to install java
#RUN add-apt-repository ppa:webupd8team/java
#RUN apt-get -y -q update
#RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
#RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
#RUN apt-get -y -q install oracle-java8-installer
#RUN update-java-alternatives -s java-8-oracle

####
# apparently bazel should be installed after java
####
# RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list && \
#     curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -
# RUN apt-get update && apt-get install -y bazel 

##################################
# cuda and gpu related libraries 
##################################

# not here because would not work from docker
# visit : scrips in <path>/amd-clmc/official_image/desktop_update/gpu
# for installation instructions


###############################################################################
# lua and awesome behaviors
###############################################################################
#RUN apt-get update && apt-get build-dep -y awesome && \
#[SSH IGNORE]
#    rm -rf /var/lib/apt/lists/*
#[/SSH IGNORE]
#RUN luarocks install lgi


###############################################################################
# required for the use of snopt 
###############################################################################
# RUN wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz -P /tmp/ && \
#     tar -xf /tmp/autoconf-2.69.tar.gz -C /tmp/ && \
#     rm /tmp/autoconf-2.69.tar.gz && \
#     cd /tmp/autoconf-2.69 && \
#     ./configure && \
#     make -C /tmp/autoconf-2.69 && \
#     make install -C /tmp/autoconf-2.69

###############################################################################
# git-lfs
###############################################################################
# RUN git lfs install --skip-smudge && \
#     git config --global credential.helper cache && \
#     git config --global credential.helper 'cache --timeout=3600'

###############################################################################
# PINOCCHIO
###############################################################################
RUN cd /tmp && \
    git clone --recursive https://github.com/stack-of-tasks/eigenpy && \
    cd eigenpy && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr/local/pinocchio/ && \
    make install && rm -rf /tmp/eigenpy
RUN export PATH=/usr/local/pinocchio/bin:$PATH
RUN export PKG_CONFIG_PATH=/usr/local/pinocchio/lib/pkgconfig:$PKG_CONFIG_PATH
RUN export LD_LIBRARY_PATH=/usr/local/pinocchio/lib:$LD_LIBRARY_PATH
RUN export PYTHONPATH=/usr/local/pinocchio/lib/python2.7/site-packages:$PYTHONPATH
RUN cd /tmp && \
    git clone --recursive https://github.com/stack-of-tasks/pinocchio && \
    cd pinocchio && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/usr/local/pinocchio/ && \
    make install && rm -rf /tmp/pinocchio

###############################################################################
# PYTHON MODULES
###############################################################################

RUN pip install --upgrade pip
RUN pip install pyopenssl
RUN pip install --upgrade \
    colorama \
    matplotlib \
    ndg-httpsclient \
    numpy \
    pyasn1 \
    schedule \
    scipy \
    sklearn \
    virtualenv \
    appdirs \
    h5py \
    keras \
    ipython \
    ipdb \
    graphviz \
    zmq
RUN pip install pydot==1.0.28
RUN pip install pyparsing==2.0.1
RUN pip install --upgrade six --target="/usr/lib/python2.7/dist-packages"
RUN pip install appdirs
RUN pip install --upgrade protobuf

#[SSH IGNORE]
#########################################
# for convenience, to map workspace in it
#########################################
RUN mkdir /workspace
RUN mkdir /ssh
RUN mkdir /hrmdock
#[/SSH IGNORE]

########################
# start ssh agent
########################
RUN eval `ssh-agent -s`
