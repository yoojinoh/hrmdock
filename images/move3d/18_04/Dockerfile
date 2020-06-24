# [SSH IGNORE]

# FROM ubuntu:18.04
FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
MAINTAINER Jim Mainprice <mainprice@gmail.com>

################################################################################
# This Dockerfile is also used to generate the official image install ssh 
# script. (see desktop_update folder in amd-clmc/official_images)
# The [SSH IGNORE*]  [/SSH IGNORE*] ;
# [SSH ONLY*] [/SSH ONLY*] tags are here to indicate
# what will go in the official ssh install script and what will not
################################################################################

# [/SSH IGNORE]

################################################################################
# We add all other repositories.
################################################################################

RUN apt-get update && \
    apt-get -y install curl wget
RUN apt-get update && apt-get install -y software-properties-common

########################################################
# Favoring non interactive installation
########################################################
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get --yes update
RUN apt-get --yes install \
    apt-utils git sudo g++ make gnupg gdb cmake \
    x11-apps mesa-utils \
    nano emacs terminator lsb-release gnuplot

RUN echo "-----------------------------------------"
RUN echo " INSTALL DEPENDENCIES"
RUN echo "-----------------------------------------"

RUN apt-get --yes install \
    cmake \
    cmake-curses-gui \
    autoconf \
    libtool \
    build-essential \
    libxml2-dev \
    doxygen \
    qt4-dev-tools \
    libxpm-dev \
    libgbm1 \
    libgbm-dev \
    libgsl0-dev \
    libglpk-dev \
    libgts-dev \
    freeglut3 \
    freeglut3-dev \
    libeigen3-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-thread-dev

# [SSH IGNORE]

RUN export MOVE3D_INSTALL_DIR=/workspace/move3d/install

##########################################################
# This is then mounted by the user to a shared folder

RUN mkdir -p /workspace

##########################################################
# INSTALL MOVE3D
# RUN mkdir -p /move3d && \
#     cd /move3d && \
#     git clone https://github.com/jmainpri/move3d-launch.git  && \
#     cd move3d-launch && \
#     bash install-ubuntu.sh install-ssh no_sysdep

WORKDIR /workspace
# [/SSH IGNORE]