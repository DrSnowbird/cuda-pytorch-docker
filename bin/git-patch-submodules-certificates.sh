#!/bin/bash -x

#ref: http://openmetric.org/til/programming/git-pull-with-submodule/

branch=`git branch|grep "\*" | awk '{print $2}'`

if [ "$branch" == "" ]; then
    echo "**** ERROR: can find branch name to continue! Abort!"
    #exit 1
fi

#SCRIPT=`realpath -s $0`
SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH/..

echo `pwd`

git checkout $branch
git status

CERTIFICATES_DIR=./certificates
GIT_URLS=$@
for git_url in $GIT_URLS; do
    echo -e ">> git_url: ${git_url}"
    git_dir=${git_url##*/}
    git_dir=${git_dir%%.*}
    if [ -s ${git_dir}/dummy* ]; then
        rm -f ${git_dir}/dummy*
    fi
    [ -s ${CERTIFICATES_DIR} ] && [ -s ${git_dir} ] && [( cp -r $(realpath ${CERTIFICATES_DIR}) ${git_dir}/ ;
        ls -al ${git_dir}/$(basename ${CERTIFICATES_DIR}) )
done

