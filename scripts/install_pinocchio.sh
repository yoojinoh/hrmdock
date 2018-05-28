#!/bin/bash
NB_CPUS=20
PINOCCHIO_INSTALL=/usr/local/pinocchio/

# Install eigenpy
cd /tmp && \
    git clone --recursive https://github.com/stack-of-tasks/eigenpy && \
    cd eigenpy && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${PINOCCHIO_INSTALL} && \
    make install -j${NB_CPUS} 
export PATH=${PINOCCHIO_INSTALL}/bin:$PATH
export PKG_CONFIG_PATH=${PINOCCHIO_INSTALL}/lib/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=${PINOCCHIO_INSTALL}/lib:$LD_LIBRARY_PATH
export PYTHONPATH=${PINOCCHIO_INSTALL}/lib/python2.7/site-packages:$PYTHONPATH

# Install pinocchio
cd /tmp && \
    git clone --recursive https://github.com/stack-of-tasks/pinocchio && \
    cd pinocchio && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${PINOCCHIO_INSTALL} && \
    make install -j${NB_CPUS}

echo "export PATH=${PATH}:\$PATH" >> ${HOME}/.bashrc
echo "export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:\$PKG_CONFIG_PATH" >> ${HOME}/.bashrc
echo "export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:\$LD_LIBRARY_PATH" >> ${HOME}/.bashrc
echo "export PYTHONPATH=${PYTHONPATH}:\$PYTHONPATH" >> ${HOME}/.bashrc

# rm -rf /tmp/eigenpy
# rm -rf /tmp/pinocchio
