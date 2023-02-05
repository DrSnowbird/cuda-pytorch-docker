#!/bin/bash -x

env|sort

source $HOME/venv/bin/activate

if [ -s $APP_HOME/requirements.txt ]; then
    python -m pip --no-cache-dir install --ignore-installed -U -r $APP_HOME/requirements.txt
fi
