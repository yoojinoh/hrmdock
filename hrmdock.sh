# !/bin/bash
# Author: Jim Mainprice
# Please contact mainprice@gmail.com if bugs or errors are found
# in this script.
HRMDOCK_FILE=$(basename $BASH_SOURCE)
HRMDOCK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

# To run the last container
# docker ps -a --latest
# docker start -i ID_OF_YOUR_CONTAINER

hrmdock_print_config() {
    echo " - bash filename is : ${HRMDOCK_FILE}"
    echo " - script directory is in : ${HRMDOCK_DIR}"
    echo " - image name is : ${IMAGE_NAME}"
}

hrmdock_cd() {
    cd ${HRMDOCK_DIR}
}

hrmdock_load_config() {
    source ${HRMDOCK_DIR}/hrmdock.config
}

hrmdock_build_latest() {
    # This will build the latest image as described in the DockerFile
    hrmdock_load_config
    # CACHE=--no-cache=true
    echo "CACHE=${CACHE}"
    if docker build ${CACHE} -t ${IMAGE_NAME} \
        ${HRMDOCK_DIR}/${IMAGE_DIRECTORY}; then
        # Do nothing
        echo "Build ${IMAGE_NAME} Done !"
    :
    else
        echo "Error building image !"
    fi
}

hrmdock_update_this_machine() {
    # This function will create a bash script from the current
    # Dockerfile and update this machine. It supposes that the machine's 
    # version of the operating system agrees with the Dockerfile
    hrmdock_load_config
    cd ${HRMDOCK_DIR}
    UPDATE_SCRIPT=scripts/autogenerate_update_script.sh
    python scripts/generate_update_script.py \
        ${HRMDOCK_DIR}/${IMAGE_DIRECTORY}/Dockerfile ${UPDATE_SCRIPT}
    sudo bash ${UPDATE_SCRIPT}
    cd -      
}

hrmdock_run_tf_container() {
    # Run the basic tf gpu image
    OPTS=""
    if $TEMPORARY_CONTAINER ; then
        OPTS="--rm"
    fi
    echo ${OPTS}
    nvidia-docker run -it \
           ${OPTS} \
           -p 8888:8888 \
           tensorflow/tensorflow:latest-gpu
}


hrmdock_run_new_container() {
    # Run the image in a container at the location when the function is called.
    #
    # Should allow percistent containers by not copying the ssh keys.
    # SSH keys, we should find a way to unmount the .ssh volume
    # The ports are rerouted to get access to the proper tensor board things.
    hrmdock_load_config
    USER=$(whoami)
    ID=$(id -u ${USER})
    OPTS=""
    if $TEMPORARY_CONTAINER ; then
        OPTS="--rm"
    fi
    echo ${OPTS}
    docker run -it \
           ${OPTS} \
           --runtime=nvidia \
           -e DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v $(pwd):/workspace \
           -v ${HOME}/.ssh:/ssh \
           -p 0.0.0.0:6006:6006 \
           -p 8888:8888 \
	       -v ${HRMDOCK_DIR}:/hrmdock \
    	   ${IMAGE_NAME} \
               bash -c "cd /workspace \
                        && source /hrmdock/${HRMDOCK_FILE} \
                        && hrmdock_create_user ${USER} ${ID}"
}

hrmdock_run_container() {
    # Start and run a shell a container given as argument.
    # supposes that container has a user whoami and a directory workspace
    CONTAINTER_ID=$1
    echo "Starting container ${CONTAINTER_ID}"
    docker start ${CONTAINTER_ID}
    docker exec -it ${CONTAINTER_ID} bash -c "cd /workspace \
                                              && su $(whoami)"
}

hrmdock_run_latest_container() {
    # Calls run container on the latest created container.
    CONTAINTER_ID=$(docker ps -aq --latest | awk '{print $1}')
    hrmdock_run_container $CONTAINTER_ID
}

hrmdock_run_default_container() {
    # Calls run container on the default container.
    hrmdock_load_config
    hrmdock_run_container $DEFAULT_CONTAINER_ID
}

hrmdock_stop_default_container() {
    # Calls run container on the default container.
    hrmdock_load_config
    docker stop $DEFAULT_CONTAINER_ID
}

hrmdock_import_ssh_keys() {
    # Usefull to import ssh keys in the container.
    # This will be temporarily mounted to the container and copied to
    # the user home directory, if using ssh agent, it will be started.
    echo "check ssh keys"
    if [ ! -d "${HOME}/.ssh" ]; then
        echo "Adding ssh keys"
        # Symbolic link version, we have to figure out how
        # to unmount volumes...
        ln -s /ssh ${HOME}/.ssh
        # -------------------- Copy version -------------------
        # mkdir .ssh
        # cp -r /ssh/* ${HOME}/.ssh
        # rm ${HOME}/.ssh/ssh_auth_sock
        # chmod 600 .ssh/*
        # -----------------------------------------------------
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" ${HOME}/.ssh/ssh_auth_sock
        export SSH_AUTH_SOCK=${HOME}/.ssh/ssh_auth_sock
        ssh-add -l | grep "The agent has no identities" && ssh-add
    fi
}

hrmdock_create_user() {
    # Create a user in the Gest with the name and id passed
    # as argument. If these mach then files can be edited 
    # regardless by the host or the gest.
    # the created user has sudoers rights and we also import the ssh
    # keys of the host.
    hrmdock_load_config
    echo "Create user $1 with uid $2"
    # echo "$(id -u $1 &>/dev/null)"
    useradd -m -d /home/$1 $1
    usermod -u $2 $1
    usermod -aG sudo $1
    cd /home/$1
    echo "$1 ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$1

    if grep -Fxq .bashrc "/hrmdock/${HRMDOCK_FILE}" 
        then
            echo "source /hrmdock/${HRMDOCK_FILE}" >> .bashrc
            echo "export PATH=${PATH}" >> .bashrc
            echo "hrmdock_import_ssh_keys" >> .bashrc
        else
            echo "user already created !"
    fi
    cd /workspace
    su $1
}
