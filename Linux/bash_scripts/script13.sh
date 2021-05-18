#!/bin/bash
read -t 5 -p "You have 5 seconds. Your input: " user_input
if [ -z "$user_input" ]
then
    echo -e "\n5 seconds are over"
else
    echo "$user_input"
fi