#!/bin/bash
# Usage:
# ./convert.sh file-name
#
# Try to convert `file-name' to a more compressed format.
#
# Output:
# The converted file name (or the original if more conversion was not possible)
#
# Dependencies:
# file(1)           Standard on POSIX systems
# cwebp(1)          https://developers.google.com/speed/webp/docs/precompiled
# ffmpeg(1)         Available on most Linux distrubution (https://ffmpeg.org/)
#
# Authors:
# Aman Chauhan, Amish Naidu, Ayaskant Panigrahi

# The MIME-type of the input file.
type=$(file --brief --mime-type "$1")

# The base name of the input file excluding the extension.
base=${1%.*}

# Variables for modularity
IMAGE_CONVERTER=cwebp
IMAGE_ARGS="-q 80 -o"

VIDEO_CONVERTER="ffmpeg -i"
VIDEO_ARGS="-n -c:v libx265 -preset medium -crf 28 -c:a aac -strict -2"

# This will be output to STDOUT. This is the new converted file.
# This could be used to interface to a server, so the server could send this as the response instead of the original URI
newfile=""

# Branch on the MIME-type
# Check if it's image
if [[ $type == image/* ]]
then
    # Convert the image to the webp format.
    # Redirect STDOUT and STDERR to /dev/null and thus silence the invokation
    if $IMAGE_CONVERTER "$1" $IMAGE_ARGS "$base.webp" &>/dev/null
    then
        newfile="$base.webp"
    else
        newfile="$1"
    fi
elif [[ $type == video/* ]]
then
    # Convert the video to an mp4 format with video encoded as HEVC and audio encoded as aac.
    # Redirect STDOUT and STDERR to /dev/null and thus silence the invocation
    if $VIDEO_CONVERTER "$1" $VIDEO_ARGS "${base}-conv.mp4" &>/dev/null
    then
        newfile="${base}-conv.mp4"
    else
        newfile="$1"
    fi
else
    newfile="$1"
fi

echo "$newfile"
