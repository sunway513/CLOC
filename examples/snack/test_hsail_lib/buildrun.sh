#!/bin/bash


export LD_LIBRARY_PATH=/opt/rocm/hsa/lib

# Compile accelerated functions
echo 
if [ -f test_hsail_lib.o ] ; then rm test_hsail_lib.o ; fi
echo "snackhsail.sh -v -c -hsaillib ../../mathdemo_hsaillib/mathdemo_hsaillib.hsail test_hsail_lib.cl "
snackhsail.sh -v -c -hsaillib ../../mathdemo_hsaillib/mathdemo_hsaillib.hsail test_hsail_lib.cl 

# Compile Main and link to accelerated functions in test_hsail_lib.o
echo 
if [ -f test_hsail_lib ] ; then rm test_hsail_lib ; fi

g++ -o test_hsail_lib test_hsail_lib.o test_hsail_lib.cpp -L/opt/rocm/hsa/lib -lhsa-runtime64 -lm

#  Execute
echo
echo ./test_hsail_lib
./test_hsail_lib
