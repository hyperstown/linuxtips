#!/bin/bash

FILE=~/.timeout_info_temp
if [ -f "$FILE" ]; then
    rm -rf ~/.timeout_info_temp
    xset q >> ~/.timeout_info_temp
    xset dpms 30 45 60
else 
    xset q >> ~/.timeout_info_temp
    xset dpms 30 45 60
fi

