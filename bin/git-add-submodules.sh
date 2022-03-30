#!/bin/bash -x


if [ $# -lt 1 ]; then
    echo -e ">>> ERROR: missing input arg: GIT URL"
    exit 1
fi

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

CURR_DIR=`pwd`
echo `pwd`

git checkout $branch
git status

GIT_URLS=$@
for git_url in $GIT_URLS; do
    echo -e ">> git_url: ${git_url}"
    echo -e ">> git_url: ${git_url}"
    git_dir=${git_url##*/}
    git_dir=${git_dir%%.*}
    [ ! -s ${git_dir} ] || git submodule add ${git_url}
    [ -s ${git_dir} ] && (
        cd ${git_dir}; 
        git fetch ;
        git submodule update --init --recursive ;
        git pull --recurse-submodules ;
        cd ${CURR_DIR} )
done


