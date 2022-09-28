#!/usr/bin/env bash

THIS_SCRIPT_DIR=$(dirname $(realpath $BASH_SOURCE))


bats -t ${THIS_SCRIPT_DIR}/stack.bats
