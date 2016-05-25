#!/bin/bash

#git submodule update --init --recursive

function fatal_error() {
    echo "Something went wrong, aborting"
    exit 1
}

function install_package() {
    if [[ $USER_INSTALL ]]; then
        python3 setup.py develop --user || fatal_error
    else
        sudo python3 setup.py develop || fatal_error
    fi
}

if [[ $1 == '--user' ]]; then
    USER_INSTALL=true
    echo "Installing without root"
fi

FOLDERS="aw-core aw-client aw-server aw-watcher-afk aw-watcher-x11"
for FOLDER in $FOLDERS; do
    cd $FOLDER
    install_package
    cd ..
done
