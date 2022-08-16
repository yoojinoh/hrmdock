# [SSH IGNORE]

# FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
FROM ros:melodic-ros-base-bionic
MAINTAINER Yoojin Oh <ohyn@is.mpg.de>

########################################################
# Install basic download tools
########################################################
RUN apt update && \
    apt install -y \
        sudo \
        curl # command line tool for transferring data with URL syntax \
        wget # command line tool for retrieving files using HTTP, HTTPS, FTP and FTPS \
        apt-utils # some less used command line utilities related to APT \
        git \
        gpg-agent \
        software-properties-common

# Upgrade installed packages
RUN apt update && apt upgrade -y && apt clean

# install python 3.7.10 (or newer)
RUN apt update && \
    apt install --no-install-recommends -y build-essential software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt install --no-install-recommends -y python3.7 python3.7-dev python3.7-distutils && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Register the version in alternatives (and set higher priority to 3.7)
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2

# Upgrade pip to latest version
RUN curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py --force-reinstall && \
    rm get-pip.py

##########################################################
# Clean the apt cache to always have up to date packages #
##########################################################
RUN apt clean

########################################################
# Favoring non interactive installation
########################################################
ENV DEBIAN_FRONTEND=noninteractive

#########################################
# for convenience, to map workspace in it
#########################################
RUN mkdir /workspace
RUN mkdir /ssh

####################################################
# INSTALL PACKAGES

# Huge mess.. some may not even be needed
####################################################
RUN apt -y update &&  apt install -y bash-completion     `# Allow bash completion`\
                       alien               `# File conversions`\
               apt-file            `# Is a software package that indexes`\
                                    `# the contents of packages in your`\
                                    `# available repositories and allows you`\
                                    `# to search for a particular file among`\
                                    `# all available packages.`\
               autofs              `# Used to automount external device (usb, HD, ...)`\
               bc                  `# "JrBc", A calculator that can be used from the command-line`\
               imagemagick         `# Image manipulation (convert)`\
               f2c                 `# Fortran to C/C++ translator`\
               libf2c2-dev         `# To be used with f2c (fortran 2 c/c++)`\
               man                 `# on-line manual pager`\
               libcairo2-dev       `# 2D Graphics package`\
               patch               `# Apply a diff file to an original`\
               picocom             `# minimal dumb-terminal emulation program`\
               rpm                 `#  Tools to create and apply deltarpms`\
               scons               `# replacement for make, depends on python... ????`\
               screen              `# terminal multiplexer with VT100/ANSI terminal emulation`\
               shellcheck          `# lint tool for shell scripts`\
               swig                `# Generate scripting interfaces to C/C++ code`\
               xmlto               `# XML-to-any converter`\
               htop

# Development tools
RUN apt install -y less                `# Similar to "more", installed by default?`\
                    ccache              `# Optimize the cache during build.`\
                    gdb                 `# code debugger`\
                    iputils-ping        `# Tools to test the reachability of network hosts`\
                    cmake-curses-gui    `# ccmake`\
                    ssh                 `# ssh client+server`\
                    openssh-server      `# ssh server`\
                    sshpass             `# Non-interactive ssh password authentication`\
                    ssh-askpass-gnome   `# Add this to log sshagent at start`\
                    emacs               `# Basic text editor`

# Code dependencies ?
RUN apt install -y asciidoc                 `# "Highly configurable text format for writing documentation"`\
               libffi-dev               `# Code binder developped by Haskell`\
               libgirepository1.0-dev   `# Inspect GObject.`\
               libpango1.0-dev          `# Police rendering`\
               m4                       `# a macro processing language`\
               mesa-utils               `# Miscellaneous Mesa GL utilities`


# Code dependencies 
RUN apt install -y autoconf               `# Used to build SNOPT from source`\
            cmake                  `# C++, Python Project builder`\
            lsb-release            `# Linux Standard Base version reporting utility `\
            libconfig++-dev        `# pkgconfig`\
            binutils               `# GNU assembler, linker and binary utilities`\
            build-essential        `# Build tools (gcc, g++, ...)`\
            gfortran               `# Fortran compiler`\
            doxygen                `# Main documentation writting used`\
            freeglut3              `# OpenGL Utility Toolkit`\
            freeglut3-dev          `# OpenGL Utility Toolkit`
    
# ####################################################
# #                INSTALL PYTHON3.7
# ####################################################
# RUN apt-add-repository -y ppa:deadsnakes/ppa
# RUN apt install -y python3.7 \
#             python3.7-venv         `# virtual env`\
#             python3.7-dev          `# python stuff `\
#             python3-pip            `# pip `\
#             python-empy            `# python stuff `


###############################################################################
# PYTHON MODULES
# pip first has to be installed with apt
###############################################################################
RUN sudo -H pip3 install --no-cache-dir --upgrade pip
RUN sudo -H pip3 install --upgrade pip 
RUN sudo -H pip3 install --no-cache-dir  --upgrade \
    catkin_pkg \
    rospkg \ 
    matplotlib `# Plotting library` \
    seaborn \
    ndg-httpsclient \
    numpy  \
    jupyter \
    opencv-python \
    scipy \
    sklearn \
    scikit-learn \
    h5py \
    seaborn \
    Pillow \
    treep `# MPI-IS code project manager` \
    pybind11 \
    pybullet \
    pyquaternion

RUN sudo -H pip3 install --no-cache-dir tensorflow==2.9 

# Auto complete treep
RUN sudo activate-global-python-argcomplete

####################################################
#              robotics-course related 
####################################################
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
    pybind11-dev  \
    libbullet-dev \
    graphviz \
    ros-melodic-camera-info-manager \
    ros-melodic-ros-controllers \
    ros-melodic-gazebo-ros \
    ros-melodic-robot-state-publisher \
    ros-melodic-rviz



#[SSH IGNORE]

#[/SSH IGNORE]

#[SSH IGNORE]
############################################
# creating a user for continuous integration
############################################
RUN useradd -p $(openssl passwd -1 bamboo) bamboo
RUN usermod -aG sudo bamboo
RUN usermod -u 111 bamboo
#[/SSH IGNORE]

############################
# remove unrequired packages
############################
RUN apt -y update && apt -y upgrade 
RUN apt -y autoremove
#[SSH UPDATE]

########################
# start ssh agent
########################
RUN eval `ssh-agent -s`

RUN mkdir /hrmdock

##########################################################
# Clean the apt cache to always have up to date packages #
##########################################################
RUN apt clean
