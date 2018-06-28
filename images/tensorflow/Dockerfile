FROM hrm_cuda:latest

RUN apt-get update && \
    apt-get install -y \
    sudo \
    python3-pip \
    swig \
    python-testresources \
    xvfb
RUN pip install --upgrade pip
RUN pip3 install pyglet pyopengl
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
RUN pip3 install gym
RUN pip3 install baselines
RUN pip3 install tensorflow-gpu
RUN pip3 install -U numpy==1.11.0.

# COPY run_jupyter.sh /

# For CUDA profiling, TensorFlow requires CUPTI.
# ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

# TensorBoard
# EXPOSE 6006
# IPython
# EXPOSE 8888

# WORKDIR "/notebooks"

# CMD ["/run_jupyter.sh", "--allow-root"]


