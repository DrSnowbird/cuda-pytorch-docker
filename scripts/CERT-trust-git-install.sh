#!/bin/bash -x

SUDO=`which sudo`
  
############################################
#### ---- GIT trust configuration: ---- ####
############################################
#### ref: https://techoverflow.net/2022/02/08/how-to-skip-ssl-certificate-verification-during-git-clone/
#### ref: https://stackoverflow.com/questions/21181231/server-certificate-verification-failed-cafile-etc-ssl-certs-ca-certificates-c
####

echo
env |grep GIT_SSL_NO_VERIFY
echo 

GIT_SSL_NO_VERIFY=${GIT_TRUST_VERIFY:-false}
GIT_SSL_NO_VERIFY=$(echo "$GIT_SSL_NO_VERIFY" | tr '[:upper:]' '[:lower:]')
function setup_git_conf_trust_cert() {
    ${SUDO} apt install -y ca-certificates
    git config --global http.sslverify false
cat << EOF >> $HOME/.bashrc
export GIT_SSL_NO_VERIFY=true
EOF
}
if [ "${GIT_SSL_NO_VERIFY}" == "true" ]; then
    echo -e ""
    echo -e ">>>> GIT_SSL_NO_VERIFY=${GIT_SSL_NO_VERIFY}"
    echo -e ">>>>   WARN --> This will 'disable' GIT SSL VERIFY !"
    echo -e ""
    setup_git_conf_trust_cert
else
    echo -e ""
    echo -e ">>>> GIT_SSL_NO_VERIFY=${GIT_SSL_NO_VERIFY}"
    echo -e ">>>>   INFO --> This will 'enable (PIP default config)'  GIT SSL VERIFY !"
    echo -e ">>>>   (Do nothing)"
    echo -e ""
fi


