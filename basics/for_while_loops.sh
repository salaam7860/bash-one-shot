#!/bin/bash

# FOR AND WHILE LOOPS 
<< task
$1 is name anything
$2 is a range 
$3 is ending range.
task

for (( i=$2; i<=$3; i++ ));
do 
    echo "$1_$i"
done

num=0

while [[ $num -le 18 ]]; do
   
    ((num += 3))  #((num = num + 3))
done

echo "The value is $num"

even=0

while (( even <= num )); do
    if  (( even % 2 == 0 )); then
        echo "$even"
    fi
    ((even += 1))
done
