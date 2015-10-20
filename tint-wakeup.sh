#!/bin/bash

while [ 1 ];
do 
#  tint;
  curl --connect-timeout 10 --max-time 10 http://tint.cloversites.com/api/create_random_gradient >/dev/null 2>&1
  sleep 60;
done
