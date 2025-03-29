#!/bin/bash

create_directory() {
    mkdir demo
}

if [ -e "demo/" ]; then
    echo "Directory is already exist"
    exit 1
else
    create_directory
    echo "Sucessfully Created"
fi

