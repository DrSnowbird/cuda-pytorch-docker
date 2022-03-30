#!/bin/bash

echo "------ environment vars ------"
env | grep -i virtual
env | grep -i venv

PYTHON_MAIN=${PYTHON_MAIN:-~/app}
echo "PYTHON_MAIN=${PYTHON_MAIN}"

#########################################################################
#### ---- Customization for multiple virtual python environment ---- ####
####      (most recommended approach and simple to switch venv)      ####
#########################################################################
#source ~/.bashrc

PYTHON_VERSION=3
##PYTHON_VERSION=3.6
PYTHON_EXE=`which python${PYTHON_VERSION}`
VIRTUALENV_EXE=`which virtualenv`
VIRTUALENVWRAPPER_SHELL=`which virtualenvwrapper.sh`

#### ---- root directory for venv setups ---- ####
export WORKON_HOME=~/Envs
echo "WORKON_HOME=${WORKON_HOME}"
if [ ! -d $WORKON_HOME ]; then
    mkdir -p $WORKON_HOME
fi

export VIRTUALENVWRAPPER_PYTHON=${PYTHON_EXE}
export VIRTUALENVWRAPPER_VIRTUALENV=${VIRTUALENV_EXE}

#### ---- no need if already source ---- ####
source ${VIRTUALENVWRAPPER_SHELL}

################################################################################
#### ---- Pre-load PIP modules for multiple virtual python environment ---- ####
################################################################################
#### ---- virtualenv setup ---- ####

## ----------------------- ##
## -- virtualenvwrapper -- ##
## ----------------------- ##
PYENV_VIRTUAL_ENV=${PYENV_VIRTUAL_ENV:-/home/developer/.pyenv/versions/myvenv}

VENV_DIR=$(basename ${PYENV_VIRTUAL_ENV})
mkvirtualenv -p ${PYTHON_EXE} ${VENV_DIR}
workon ${VENV_DIR}
## PIP install requiremented packages
if  [ -s ${PYTHON_MAIN}/requirements.txt ]; then
    pip3 install -r ${PYTHON_MAIN}/requirements.txt
fi

