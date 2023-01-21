# NVIDIA CUDA + PyTorch Monthly build + Jupyter Notebooks in `Non-Root` Docker Container
* All the information below is mainly from nvidia.com except the additional shell scripts (and related documentation) that I created.
* The latest RTX 3090 GPU or higher is supported (RTX 3090 tested to work too) in this Docker Container.
* Notes: 
    * This Container image is relatively huge! `Make sure you have large memory, CPU, and GPU to run`. Also, this Container is not for low-end GPU and CPU to use to run Deep Learning models.

# Why (atop NVIDIA Container image):
    ```
    If [ you are looking for such common requirements in 
        AI/ML/DL CUDA (latest) + PyTorch (latest) base Container ]:
       Then [ this one may be for you ]
    ```
* (`New`) Support for building Container behind `Corporate SSL Proxy` using `Dockerfile-proxy-SSL` file (see instructions below). 
    * As many corporates' AI/ML scientists often encounter the challenges of building Containers behind corporate's security environments seeing the build failures of Containers due to SSL certificates not `trusted`. In short, your corporate is essentially doing Man-in-the-middle SSL manipulations for corproate security protections). This release will automate the setup of using your corporate's SSL certificates to allow the success of building the Container without the issue of 'SSL certificates not trusted' errors.
* A base Container with `no root access` (except using `sudo ...` and you can remove it using `sudo apt-get remove sudo` to protect your Container).
* As most AI/ML/DL scientisits know that the first big hurdle of applying the technologies is to set up a `ML/DL Python environments (versions compatibles among all software libs, GPU support, CUDA, PyTorch, H/W GPU Cards/versions etc.).
* The goal of this project (Deep Learning Container) is to provide `ready-to-use Docker Container` for your ML/DL Python experiments to save tons of your time and frustrations dealing with those `versions, comptabilities, GPU cards not supported, etc.`
* And, the default Jupyter Notebooks app is automatically setup ready to use.

# Libs (based upon NVIDIA Web page)
* Ubuntu 20.04 including Python 3.8 environment
* NVIDIA CUDA 11.6.0+
* cuBLAS 11.8.1.74+
* NVIDIA cuDNN 8.3.2.44+
* NVIDIA NCCL 2.11.4+ (optimized for NVLink™)

# Build
* Simply,
    ```
    make build
    ```

# Build Container behind `Corporate SSL Proxy Network`
This new release automatically setup necessary files using your corporate's SSL Proxy's certificates (you will obatin and provide in ./certificates folder). 
1. Obtain your Corporate's SSL Proxy certificates (e.g., OpenKBS.crt or whatever yours - maybe multiple of them) into the folder `./certificates`.
2. Copy `Dockerfile-proxy-SSL` to overwrite default one, `Dockerfile`
3. Then, 
    ```
    make build
    ```
4. That's it! The automation will configure properly all the necessary files inside the Docker OS to allow the build without the build errors of 'SSL certificates not trusted'.


# Test
To test whether the GPU function can properly run inside the Container and make sure the Host's Nvidia driver being properly.
1. In the host computer, run command:
```
nvidia-smi
```
2. Run the container with the above command to make sure the Container also have the access to GPU functions:
```
./run.sh nvidia-smi
```

# Run
* Default run is to auto-detect Host's NVIDIA GPU, e.g., RTX 3090 or any and use all the CUDA units available.
    ```
    ./run.sh
    
    or
    ./run.sh -d   (detached)
    ./run.sh -d -r always (daemon + always-up)
    ```

## `(new!)` Jupyter Notebooks Server (Default App)
* You need access token from the log file depending up you use './run.sh' or 'make up'.
  * If you use './run.sh' to start, then the console screen will have a line containing 'token'. You just need to copy-and-paste to use it to login.
  * If you use 'make up' to start, then use the command below to find the 'token' and then copy it to login:
```
./log.sh
```

* Then, go to your Web Browser to access Jupyter Notebook:
    ```
    http://<Host-IP>:8888/tree
    or
    http://localhost:8888/tree
    ```

# References
* [NVIDIA NGC Pytorch Container Guide/README](https://ngc.nvidia.com/catalog/containers/nvidia:pytorch)

# Releases Information (from NVIDIA web site)
* [PyTorch NVIDIA Release 22.12](https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel-22-12.html#rel-22-12)


