#!/bin/bash

for i in {1..254}; 
do
(ping -c 1 192.168.181.$i | grep "bytes from" &);
done
