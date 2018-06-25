FROM ubuntu/hrm_16.04
# FROM tensorflow/tensorflow:latest-gpu
RUN apt-get update && \
    apt-get install -y \
    sudo \
    python3-pip \
    swig 

RUN pip3 install pyglet pyopengl
RUN pip3 install tensorflow-gpu

RUN pip3 install matplotlib
RUN pip3 install --upgrade \
    colorama \
    matplotlib \
    ndg-httpsclient \
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
    zmq \
    box2d

RUN pip3 install -U numpy==1.11.0.

# RUN wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# RUN echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
# RUN apt-get update && \
# 	apt-get install sublime-text

# COPY run_jupyter.sh /

# For CUDA profiling, TensorFlow requires CUPTI.
# ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

# TensorBoard
# EXPOSE 6006
# IPython
# EXPOSE 8888

# WORKDIR "/notebooks"

# CMD ["/run_jupyter.sh", "--allow-root"]

