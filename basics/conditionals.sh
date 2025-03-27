#!/bin/bash

<< disclaimer
This is just for infotainment purpose
disclaimer

read -p "Enter any name: " name 

if [[ $name == "xyz" ]];
then
    echo "Hello World"
elif [[ $1 -ge 100 ]];
then
    echo "Hello world guys"
else
    echo "do nothing"
fi 