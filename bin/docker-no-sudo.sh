#!/bin/bash -x

echo ">>> Add $USER to docker group to use docker command without sudo"

sudo groupadd docker
sudo usermod -aG docker $USER
sudo chown -R root:root /var/run/docker
sudo chown -R root:docker /var/run/docker.sock

sudo ls -al /var/run/docker /var/run/docker.sock

