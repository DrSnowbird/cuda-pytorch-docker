#!/bin/bash -x
  
############################################
#### ---- PIP trust configuration: ---- ####
############################################
#### ref: https://pip.pypa.io/en/stable/topics/configuration/
#### ref: https://stackoverflow.com/questions/25981703/pip-install-fails-with-connection-error-ssl-certificate-verify-failed-certi
####
function setup_pip_conf_trust_cert() {
# ---- PIP config file/location: ----
# (global): /etc/pip.conf
# (user/docker): $HOME/.config/pip/pip.conf
# (venv): $VIRTUAL_ENV/pip.conf
# -- SSL issue:
# https://pypi.ngc.nvidia.com/tensorflow-estimator/
#
if [ ! -s $HOME/.config/pip ]; then
     mkdir -p $HOME/.config/pip
fi

#[global]
#trusted-host = 

cat << EOF >> $HOME/.config/pip/pip.conf
               developer.download.nvidia.com
               pypi.ngc.nvidia.com
               files.pythonhosted.org
EOF
}
setup_pip_conf_trust_cert

echo -e ">>>>>>>>> $HOME/.config/pip/pip.conf"
cat $HOME/.config/pip/pip.conf

#curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#python3 ./get-pip.py

