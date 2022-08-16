HRMDock
==========

Bash project to manage code dependencies using Dockerfiles.


## Getting started
1. Clone repository
```
git clone https://github.com/yoojinoh/hrmdock.git
```
2. Make sure Docker is installed, or else `sudo snap install docker` Add user to docker group
```
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot
docker run hello-world
```

3. Start by sourcing the bash script. It's convenient to have it in your .bashrc.
Importing will give you access to helper function to build images, run containers or update your ubuntu machine.

The workflow is as follows:

    cd $CODE_DIR                  # where your code lives
    git clone whatever_code.git
    hrmdock_run_new_container
    ls                            # lists the $CODE_DIR
    sudo pip install library      # install anything you want
    python train.py               # run your things

hrmdock_run_new_container will give you access to a container in user space where you are sudoer. By default it runs a 16.04 custom image based on nvidia-docker, which should give you accelerated Cuda access on the workstation.

We can add anything you want to the default Dockerfile (only commit to branches that I can review though), or you can reference to your own Dockerfile in hrmdock_utils.sh.

Install a new machine or virtual machine:

	hrmdock_update_this_machine

This function creates a bash script from the Dockerfile.
