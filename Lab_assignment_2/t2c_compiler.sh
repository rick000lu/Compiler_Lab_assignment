#! /bin/bash

#generate t2c
make

#transfer t file to c file
if [ $# -ne 0 ]; 
then
        ./t2c $1
else
        echo "Please insert t file"
fi

#compile c file
c_file_name="${1/.t/.c}"
exe_file_name="${1%.t}"
gcc -o $exe_file_name $c_file_name

#run executable
./$exe_file_name
