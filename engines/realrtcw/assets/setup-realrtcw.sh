#!/bin/bash

if [ -f "last_error.txt" ]; then
    rm last_error.txt
fi

if [[ ! -z "${DEPPATH_9010}" ]]; then
    echo "Automatic path for rtcw found at $DEPPATH_9010"
    RTCW_PATH="$DEPPATH_9010"
else
    "$STEAM_ZENITY" --info --text="Browse to Return to Castle Wolfenstein installation" --title="Information"
    RTCW_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Return to Castle Wolfenstein installation" --directory)
fi

if [ -z "$RTCW_PATH" ]; then
    error_message="Path to RTCW not given."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi

if [ ! -d ./nosteam/"!copy the content of this folder into rtcw root directory" ]; then
    error_message="Game content not downloaded from ModDB and extracted to nosteam directory."
    if [[ -z "${LUX_ERRORS_SUPPORTED}" ]]; then
        "$STEAM_ZENITY" --error --title="Error" --text="$error_message"
    else
        echo "$error_message" > last_error.txt
    fi
    exit 10
fi

mv ./nosteam/"!copy the content of this folder into rtcw root directory"/Main/* ./nosteam/Main
ln -rsf "$RTCW_PATH/Main"/*.pk3 ./nosteam/Main
