# source: https://stackoverflow.com/questions/47092878/auto-configure-jupyter-password-from-command-line

import os
#from IPython.lib import passwd
from notebook.auth import passwd

## Allow password to be changed at login for the notebook server.
#
#  While loggin in with a token, the notebook server UI will give the opportunity
#  to the user to enter a new password at the same time that will replace the
#  token login mechanism.
#
#  This can be set to false to prevent changing password from the UI/API.
c.ServerApp.allow_password_change = True

# Set options for certfile, ip, password, and toggle off
# browser auto-opening
#c.ServerApp.certfile = u'/absolute/path/to/your/certificate/mycert.pem'
#c.ServerApp.keyfile = u'/absolute/path/to/your/certificate/mykey.key'
# Set ip to '*' to bind on all interfaces (ips) for the public server

c.ServerApp.ip = '*'
#c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = int(os.getenv('PORT', 8888))
c.ServerApp.open_browser = True
c.MultiKernelManager.default_kernel_name = 'python3'

# sets a password if PASSWORD is set in the environment
#if 'PASSWORD' in os.environ:
#  c.ServerApp.password = passwd(os.environ['PASSWORD'])
#  del os.environ['PASSWORD']

# sets a password if PASSWORD is set in the environment
if not 'PASSWORD' in os.environ or os.environ['PASSWORD'] is None:
    os.environ['PASSWORD']="ChangeMe!"
    
if 'PASSWORD' in os.environ:
    print("===>> Passowrd=" + os.environ['PASSWORD'])
    c.ServerApp.password = passwd(os.environ['PASSWORD'])
    print("Password file at " + os.environ['JUPYTER_CONF_DIR'] + "/jupyter_password.txt")
    fp = open(os.environ['JUPYTER_CONF_DIR']+"/jupyter_password.txt", "w")
    fp.write(os.environ['PASSWORD'])
    fp.close()
    #del os.environ['PASSWORD']


