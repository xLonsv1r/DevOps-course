​#!/bin/bash

read -n 1 input_symbol

echo -e "\n $input_symbol"

​case "$input_symbol" in
        ​[a-z]) echo "буква в нижнем регистре";;
        ​[A-Z]) echo "буква в верхнем регистре";;
        ​[0-9]) echo "Цифра";;
        ​*    ) echo "Знак пунктуации, пробел или что-то другое";;
​esac