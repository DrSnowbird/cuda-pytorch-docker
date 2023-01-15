#!/bin/bash
  
SUDO=`which sudo`

TRUSTED_HOST=${1:-nvidia.github.io}
if [ $# -lt 1 ]; then
    echo -e ">>>> WARN: Missing remote TRUSTED HOST DNS name, e.g., nvidia.github.io"
    echo -e ">>>> default: remote TRUSTED HOST DNS=${TRUSTED_HOST}"
    #exit 1
fi

## pre-requsite:
## if encountering SSL Certificate not trusted issue(s), then add remote DNS name to 'apt's trusted list'
## doing the following
echo
echo
echo -e "###################################################"
echo -e "#### -- SSL Certificate Not trusted Issue(s)-- ####"
echo -e "###################################################"
echo "If encountering SSL Certificate not trusted issue(s), then add remote DNS name to 'apt's trusted list'"
echo "${SUDO} vi /etc/apt/apt.conf.d/99allow_remote_host"
echo -e "Add the lines below into the the unauth file and save"
echo ""
echo -e "APT { Get { AllowUnauthenticated "1"; }; }; "
echo -e "Acquire::https::nvidia.github.io::Verify-Peer "false"; "
echo 
echo

APT_CONF_FILE_TRUST_HOST=/etc/apt/apt.conf.d/99allow_remote_host
# (test) APT_CONF_FILE_TRUST_HOST=~/tmp/99allow_remote_host
rm -f $(basename ${APT_CONF_FILE_TRUST_HOST})

############################################################
#### ---- Ubuntu apt update's trust configuration: ---- ####
############################################################
###
function setup_apt_conf_trust_cert() {
    
#Acquire::https::nvidia.github.io::Verify-Peer "false";
# /etc/apt/apt.conf.d/99allow_remote_host
cat << EOF >> $(basename ${APT_CONF_FILE_TRUST_HOST})
APT { Get { AllowUnauthenticated "1"; }; };
Acquire::https::${TRUSTED_HOST}::Verify-Peer "false";
EOF
    #${SUDO} cp $(basename ${APT_CONF_FILE_TRUST_HOST}) /etc/apt/apt.conf.d/99allow_remote_host
    ${SUDO} cp $(basename ${APT_CONF_FILE_TRUST_HOST}) ${APT_CONF_FILE_TRUST_HOST}
    ${SUDO} ls -al $(dirname ${APT_CONF_FILE_TRUST_HOST})
    ${SUDO} cat ${APT_CONF_FILE_TRUST_HOST}
}
setup_apt_conf_trust_cert

#${SUDO} apt-get update -y

