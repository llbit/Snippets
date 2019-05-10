#!/bin/bash

# Installs bash scripts to user bin directory.

set -u

if [ ! -d "$HOME/bin" ]; then
  mkdir "$HOME/bin"
fi

ln -s $PWD/bash/setjava $HOME/bin
ln -s $PWD/bash/addjava $HOME/bin
