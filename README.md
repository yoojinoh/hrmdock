HRMDock
==========

Bash project to use docker images

Start by:

    source hrmdock_utils.sh

Importing will give you access to helper function to build images, and run containers. 

The workflow is as follows:

    cd $CODE_DIR                # where your code lives
    hrmdock_run_new_container
    cd /workspace               # where $CODE_DIR is now mounted 
    sudo pip install library    # install anything you want
    python train.py             # run your things

hrmdock_run_new_container will give you access to a container in user space where you are sudoer. By default it runs a 16.04 custom image based on nvidia-docker, which sould give you accelerated Cuda access on the workstation.

We can add anything you want to the default Dockerfile (ony commit to branches that I can review though), or you can reference to your own Dockerfile in hrmdock_utils.sh.
