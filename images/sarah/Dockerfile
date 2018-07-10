FROM hrm_cuda:latest

# Install conda
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN apt-get update && \
  apt-get install -y octave liboctave-dev
RUN octave --eval "pkg install -forge -verbose io"
RUN octave --eval "pkg install -forge -verbose statistics"

RUN wget --quiet --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo "c59b3dd3cad550ac7596e0d599b91e75d88826db132e4146030ef471bb434e9a *Miniconda3-4.2.12-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash /Miniconda3-4.2.12-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.2.12-Linux-x86_64.sh && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh

RUN conda install -y python=2.7
RUN pip install --upgrade pip
RUN pip install \
  six \
  h5py \
  numpy==1.11 \
  scipy==0.18 \
  oct2py==3.9.2 \
  ipython==5.0 \
  tensorflow==1.1.0
RUN pip install keras==2.1.3 
