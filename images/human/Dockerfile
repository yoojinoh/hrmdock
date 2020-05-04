#[SSH IGNORE]

# FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04
FROM ubuntu:18.04
MAINTAINER Jim Mainprice <jim.mainprice@gmail.com>

#[/SSH IGNORE]

###################################################################################
# This Dockerfile is also used to generate the official image install ssh 
# script. (see desktop_update folder in amd-clmc/official_images)
# The [SSH IGNORE*]  [/SSH IGNORE*] ; [SSH ONLY*] [/SSH ONLY*] tags are here to indicate
# what will go in the official ssh install script and what will not
###################################################################################

##########################################################
# Clean the apt cache to always have up to date packages #
##########################################################
RUN apt-get clean

###############################################################################
# We add all other repositories.
###############################################################################

########################################################
# Install basic download tools
########################################################
RUN apt-get update
RUN apt-get -y install curl # command line tool for transferring data with URL syntax
RUN apt-get -y install wget # command line tool for retrieving files using HTTP, HTTPS, FTP and FTPS
RUN apt-get -y install apt-utils # some less used command line utilities related to APT


########################################################
# Favoring non interactive installation
########################################################
ENV DEBIAN_FRONTEND=noninteractive


####################################################
# Install Git and Git Large File Storage: git-lfs
# (use here for installation of CUDA, for example)
####################################################
RUN apt-get -y install git # some less used command line utilities related to APT

####################################################
#             ROS INSTALLATION
#
# under ubuntu 16.04 the following changes are made:
# the following packages don't exist in ros kinetic:
# -driver-common 
# -keyboard
####################################################

# enable kernel sources
# this is necessary for the ros package librealsense in 16.04
RUN apt-get install -y sudo              # Provide the sudo rights, required for the enable_kernel_sources.sh script file below
RUN wget -O enable_kernel_sources.sh http://bit.ly/en_krnl_src
RUN bash ./enable_kernel_sources.sh
RUN apt-get update && apt-get install -y software-properties-common

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -

# install ros
RUN apt-get -y update && \
    apt-get install -y \
    ros-melodic-desktop-full

# Install the ros packages
RUN apt-get install -y \
    python-rosdep \
    python-catkin-tools \
    ros-melodic-moveit \
    ros-melodic-moveit-core \
    ros-melodic-octomap \
    ros-melodic-octomap-msgs \
    ros-melodic-octomap-rviz-plugins 

RUN rosdep init

#[SSH IGNORE]
#########################################
# for convenience, to map workspace in it
#########################################
RUN mkdir /workspace
RUN mkdir /ssh
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
RUN apt-get -y update && apt-get -y upgrade 
RUN apt-get -y autoremove
#[SSH UPDATE]
RUN apt-get -y update && apt-get -y upgrade  
#[/SSH UPDATE]

########################
# start ssh agent
########################
RUN eval `ssh-agent -s`

#[SSH IGNORE]
#########################################
# for convenience, to map workspace in it
#########################################
# RUN mkdir /workspace    # already there
# RUN mkdir /ssh          # already there
RUN mkdir /hrmdock

##########################################################
# Clean the apt cache to always have up to date packages #
##########################################################
RUN apt-get clean
