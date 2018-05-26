HRMDock
==========

Bash project to manage code dependencies using Dockerfiles.

Start by:

    source hrmdock_utils.sh

It's good practice to have it your .bashrc

Importing will give you access to helper function to build images, run containers or update your ubuntu machine.

The workflow is as follows:

    cd $CODE_DIR                  # where your code lives
    git clone whatever_code.git
    hrmdock_run_new_container
    cd /workspace                 # where $CODE_DIR is mounted on the guest
    sudo pip install library      # install anything you want
    python train.py               # run your things

hrmdock_run_new_container will give you access to a container in user space where you are sudoer. By default it runs a 16.04 custom image based on nvidia-docker, which should give you accelerated Cuda access on the workstation.

We can add anything you want to the default Dockerfile (only commit to branches that I can review though), or you can reference to your own Dockerfile in hrmdock_utils.sh.

Install a new machine or virtual machine:

	hrm_update_this_machine
