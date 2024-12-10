#!/bin/bash
path=$(echo "$1" | sed 's@'"$HOME"/'@@')
echo -e "$path"
