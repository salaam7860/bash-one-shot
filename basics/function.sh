#!/bin/bash

function is_even() {
    read -p "Enter a number: " num
    if (( num % 2 == 0 )); then
        echo "$num is an even number."
    else    
        echo "$num is an odd number."
    fi
}

is_even


# Individual Arguments ($1, $2, $3, etc.)

greet() {
  echo "Hello, $1! You are $2 years old."
}


greet "john" 23 


# All Arguments as a List ($@)

print_args() {
  for arg in "$@"; do
    echo "$arg"
  done
}

print_args "apple" "banana" "cherry" # Output: apple
                                             # banana
                                             # cherry


# All Arguments as a Single String ($*)

print_args_string() {
  echo "$*"
}

print_args_string "apple" "banana" "cherry" # Output: apple banana cherry

# Number of Arguments ($#)

count_args() {
  echo "Number of arguments: $#"
}

count_args "apple" "banana" "cherry" # Output: Number of arguments: 3