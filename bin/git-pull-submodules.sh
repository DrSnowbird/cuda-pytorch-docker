#!/bin/bash 

#ref: http://openmetric.org/til/programming/git-pull-with-submodule/

branch=`git branch|grep "\*" | awk '{print $2}'`

if [ "$branch" == "" ]; then
    echo "**** ERROR: can find branch name to continue! Abort!"
    exit 1
fi

#SCRIPT=`realpath -s $0`
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH/..

echo `pwd`

git checkout $branch
git fetch
git submodule update --init --recursive
git pull --recurse-submodules

git status
