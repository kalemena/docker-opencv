#!/bin/bash
export HOME=$HOME; 
export USER=$USER; 

cd $HOME;

jupyter lab --allow-root --notebook-dir=$HOME --ip='0.0.0.0' --port=8888 --no-browser