FROM nvcr.io/nvidia/pytorch:24.01-py3
#FROM nvcr.io/nvidia/pytorch:22.12-py3

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

ENV DEBIAN_FRONTEND noninteractive

###################################
#### ---- Install dependencies ----
###################################
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    graphviz \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    software-properties-common \
    pkg-config \
    unzip \
    sudo \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

###################################
#### ---- user: developer ---- ####
###################################
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}
ENV USER=${USER:-developer}
ENV HOME=/home/${USER}

## -- setup NodeJS user profile
RUN groupadd ${USER} && useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} && \
    ## -- Ubuntu -- \
    usermod -aG sudo ${USER} && \
    ## -- Centos -- \
    #usermod -aG wheel ${USER} && \
    echo "${USER} ALL=NOPASSWD:ALL" | tee -a /etc/sudoers && \
    echo "USER =======> ${USER}" && ls -al ${HOME}

###################################
#### ----   PIP modules: ----  ####
###################################
#### ---- pip3 Package installation ---- ####
USER ${USER}
WORKDIR ${HOME}

COPY --chown=${USER}:${USER} requirements.txt ./
ENV PATH="$HOME/.local/bin:$PATH"
RUN python3 -m pip --no-cache-dir install --upgrade pip && \
    python3 -m pip --no-cache-dir install --upgrade setuptools tensorflow && \
    python3 -m pip --no-cache-dir install -r requirements.txt

##################################
#### ---- Jupyter        ---- ####
##################################
#RUN sudo python3 -m ipykernel.kernelspec

#RUN sudo apt install -y dirmngr gnupg apt-transport-https ca-certificates software-properties-common && \
#RUN sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'  && \
# ----------------------------------------------------------------------------
# Timezone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# ref: https://dev.to/grigorkh/fix-tzdata-hangs-during-docker-image-build-4o9m
# ----------------------------------------------------------------------------
ENV TZ=${TZ:-Etc/UTC}
#ENV TZ=Etc/UTC
RUN sudo apt update && \
    sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ | sudo tee -a /etc/timezone && \
    sudo apt install -y --no-install-recommends python3-ipykernel

##################################
#### ---- Set up Jupyter ---- ####
##################################
# Set up our notebook config.
ENV JUPYTER_CONF_DIR=$HOME/.jupyter

COPY --chown=${USER}:${USER} ./scripts/jupyter_notebook_config.py ${JUPYTER_CONF_DIR}/
COPY --chown=${USER}:${USER} ./scripts/jupyter_server_config.py ${JUPYTER_CONF_DIR}/
COPY --chown=${USER}:${USER} ./sample-notebooks $HOME/sample-notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
ADD --chown=${USER}:${USER} ./scripts $HOME/scripts
COPY --chown=${USER}:${USER} ./docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=${USER}:${USER} ./scripts/run-jupyter.sh /run-jupyter.sh
COPY --chown=${USER}:${USER} ./scripts/run-jupyter-server.sh /run-jupyter-server.sh

RUN sudo chmod +x $HOME/scripts/*.sh /run-jupyter*.sh

# Expose Ports for TensorBoard (6006), Ipython (8888)
EXPOSE 6006
EXPOSE 8888

VOLUME $HOME/notebooks

########################################
#### ---- Set up NVIDIA-Docker ---- ####
########################################
## ref: https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(Native-GPU-Support)#usage
ENV TOKENIZERS_PARALLELISM=false
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,video,utility

#/usr/lib/x86_64-linux-gnu/libnvinfer.so -> libnvinfer.so.8.5.1
#/usr/lib/x86_64-linux-gnu/libnvinfer.so.8 -> libnvinfer.so.8.5.1
#/usr/lib/x86_64-linux-gnu/libnvinfer.so.8.5.1
#/usr/lib/x86_64-linux-gnu/libnvinfer_builder_resource.so.8.5.1
#/usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so -> libnvinfer_plugin.so.8
#/usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.8 -> libnvinfer_plugin.so.8.5.1.7
#/usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.8.5.1.7
RUN sudo ln -s /usr/lib/x86_64-linux-gnu/libnvinfer.so /usr/lib/x86_64-linux-gnu/libnvinfer.so.7 && \
    sudo ln -s /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so /usr/lib/x86_64-linux-gnu/libnvinfer_plugin.so.7 && \
    ls -al /usr/lib/x86_64-linux-gnu/libnvinfer*

## fixed error: in container: sudo: setrlimit(RLIMIT_CORE): Operation not permitted
RUN echo "Set disable_coredump false" | sudo tee -a /etc/sudo.conf

############################################
#### ---- CA-Certifcates variable: ---- ####
############################################
ENV REQUESTS_CA_BUNDLE=${REQUESTS_CA_BUNDLE:-/etc/ssl/certs/ca-certificates.crt}

#########################################
##### ---- Docker Entrypoint : ---- #####
#########################################
ENTRYPOINT ["/docker-entrypoint.sh"]

##################################
#### ---- start user env ---- ####
##################################
USER ${USER}
WORKDIR "$HOME"

#CMD ["/run-jupyter.sh", "notebooks", "--allow-root", "--port=8888", "--ip=0.0.0.0", "--no-browser"]
CMD ["/run-jupyter.sh", "--allow-root"]
#CMD ["/run-jupyter-server.sh", "--allow-root"]

