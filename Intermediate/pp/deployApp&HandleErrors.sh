#!/bin/bash


<< task
Deploy a django app
and handle the code for errors 
task

URL="https://github.com/salaam7860/django-notes.git"



code_clone() {
   echo "##################################################################"
   echo "######################~~DEPLOYMENT STARTED~~######################"
   echo "##################################################################"
    
    if [ -e 'django-notes/' ]; then
        echo "Directory Already exist."
    else
        echo "################ CLONING GIT REPO ######################"
        git clone $URL &> /dev/null
    fi
}

required_dep() {
    
    sudo apt update &> /dev/null
    if which nginx &> /dev/null && which docker &> /dev/null; then
        echo "Already installed"
    else
        echo "################ INSTALLING DOCKER & NGINX SERVER ######################"
        
        sudo apt install docker.io nginx -y &> /dev/null 
    fi
}

docker_privilleges() {
    if id -nG | grep -q docker; then
        echo "User is already in the docker group."
        
    else
        if ! sudo usermod -aG docker $USER; then
            echo "ERROR: Failed to add user"
            
        fi
        if ! sudo chown ${USER}:docker /var/run/docker.sock; then 
            echo "ERROR: Failed to change ownership."
            
        fi
    fi
    echo "User added to the Docker group. Please re-login or run 'newgrp docker' to apply changes."
}
docker_compose() {
    if which docker-compose &> /dev/null; then
        echo "Already Installed."
    else
        echo "################ INSTALLING DOCKER COMPOSE ######################"
        if command -v curl > /dev/null 2>&1; then
            sudo curl -SL https://github.com/docker/compose/releases/download/v2.34.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose &> /dev/null
            sudo chmod +x /usr/local/bin/docker-compose
            sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
        else
            sudo apt install curl &> /dev/null
            sudo curl -SL https://github.com/docker/compose/releases/download/v2.34.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose &> /dev/null
            sudo chmod +x /usr/local/bin/docker-compose
            sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
       fi

    fi
}

restart_dep() {
    sudo systemctl enable docker  &> /dev/null
    sudo systemctl enable nginx  &> /dev/null
}

deploy() {
   [ "$(pwd)" != "/home/$USER/django-notes/" ] && cd "/home/$USER/django-notes/"
   echo "################ BUILDING THE APPLICATION ######################"
   docker build -t notes-app . &> /dev/null
   echo "################ DEPLOYING THE APPLICATION ######################"
   docker-compose up -d &> /dev/null
   echo "##################################################################"
   echo "#######################~~DEPLOYMENT ENDED~~#######################"
   echo "##################################################################"

}


main() {

    
    if ! code_clone; then 
        echo "Already Exist."
        cd django-notes
    fi

    if ! required_dep; then
        echo "Check Dependencies."
        exit 1
    fi

    if ! docker_privilleges; then
        echo "Docker Privilleges has some issues."
        exit 1
    fi


    if ! docker_compose; then
        echo "Docker compose hasn't installed."
        exit 1
    fi
 
    if ! restart_dep; then
        echo "System Fault identified."
        exit 1
    fi

    if ! deploy; then
        echo "Build Failed."
        exit 1
    fi
    
}
main