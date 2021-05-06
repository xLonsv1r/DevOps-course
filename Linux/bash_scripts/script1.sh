#!/bin/bash

root_id=0
if [ $(id -u) == $root_id ]
   then 
	echo "You are root"
   	exit
fi
