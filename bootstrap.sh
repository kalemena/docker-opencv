#!/bin/bash
export HOME=$HOME; 
export USER=$USER; 
jupyter lab --allow-root --notebook-dir=/notebooks --ip='0.0.0.0' --port=8888 --no-browser