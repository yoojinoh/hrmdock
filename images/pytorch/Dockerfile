FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
MAINTAINER Jim Mainprice <jim.mainprice@ipvs.uni-stuttgart.de>

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         wget \
         software-properties-common \
         apt-transport-https \
         apt-utils \
         libjpeg-dev \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*


RUN curl -o ~/miniconda.sh -O \
     https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install numpy pyyaml scipy ipython mkl mkl-include && \
     /opt/conda/bin/conda install -c pytorch magma-cuda90 && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH
# This must be done before pip so that requirements.txt is available
WORKDIR /opt/pytorch
COPY . .

# RUN git submodule update --init
# RUN TORCH_CUDA_ARCH_LIST="3.5 5.2 6.0 6.1 7.0+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
#     CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
#     pip install -v .

# WORKDIR /tmp
# RUN git clone https://github.com/pytorch/vision.git && cd vision && pip install -v .

########################
# Basics
########################

RUN add-apt-repository main && \
 add-apt-repository universe && \
 add-apt-repository restricted && \
 add-apt-repository multiverse

RUN apt-get update && apt-get install -y --no-install-recommends \
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

# python-vcstool \
# python-vcstools \

###############################################################################
# PYTHON MODULES
###############################################################################

RUN conda install \
    pyopenssl \
    numpy \
    scipy \
    pyopenssl \
    colorama \
    matplotlib \
    ndg-httpsclient \
    pyasn1 \
    scikit-learn \
    virtualenv \
    appdirs \
    h5py \
    keras \
    ipython \
    graphviz 

# RUN conda install -c pchrapka zmq
RUN conda install -c conda-forge ipdb
RUN conda install -c gomss-nowcast schedule 

# RUN pip install --upgrade pip
# RUN pip install pyopenssl
# RUN pip install pydot==1.0.28 # TODO why is this not working???
# RUN pip install pyparsing==2.0.1
# RUN pip install --upgrade six --target="/usr/lib/python2.7/dist-packages"
# RUN pip install appdirs
# RUN pip install --upgrade protobuf

#########################################
# for convenience, to map workspace in it
#########################################

WORKDIR /workspace
RUN chmod -R a+w /workspace
RUN mkdir /ssh
RUN mkdir /hrmdock

########################
# start ssh agent
########################
RUN eval `ssh-agent -s`
