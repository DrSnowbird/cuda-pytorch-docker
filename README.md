# NVIDIA CUDA + PyTorch Monthly build + Jupyter Notebooks in `Non-Root` Docker Container
* All the information below is mainly from nvidia.com except the wrapper shell scripts (and related documentation) that I created.
* The latest RTX 3090 GPU or higher is supported (tested to work too) in this Docker Container.
* Warning: the Container image is relatively huge! `Make sure you have large memory, CPU, and GPU to run`. Also, this Container is not for low-end GPU and CPU to use to run Deep Learning models.

# Why (atop NVIDIA Container image):
* A base Container with `no root access` (except using `sudo ...` and you can remove it using `sudo apt-get remove sudo` to protect your Container).
* As most AI/ML/DL scientisits know that the first big hurdle of applying the technologies is to set up a `ML/DL Python environments (versions compatibles among all software libs (CUDA, PyTorch, H/W GPU Cards/versions etc.).
* The goal of this project (Deep Learning Container) is to provide `ready-to-use Docker Container` for your ML/DL Python experiments to save tons of your time and frustrations dealing with those `versions, comptabilities, GPU cards not supported, etc.`
* And, the default Jupyter Notebooks app is automatically setup ready to use.
    ```
    If [ you are looking for such common requirements in AI/ML/DL CUDA (latest) + PyTorch (latest) base Container ]:
       Then [ this one may be for you ]
    ```

# Libs (based upon NVIDIA Web page)
* Ubuntu 20.04 including Python 3.8 environment
* NVIDIA CUDA 11.6.0
* cuBLAS 11.8.1.74
* NVIDIA cuDNN 8.3.2.44
* NVIDIA NCCL 2.11.4 (optimized for NVLink™)

# Build
* Simply,
    ```
    make build
    ```

# Run
* Default run is to auto-detect Host's NVIDIA GPU, e.g., RTX 3090 or any and use all the CUDA units available.
    ```
    ./run.sh
    
    or
    ./run.sh -d   (detached)
    ./run.sh -d -r always (daemon + always-up)
    ```

## Jupyter Notebooks (Default App)
* Then, go to your Web Browser to access Jupyter Notebook with "ChangeMe!" as default password.
    ```
    http://<Host-IP>:8888/
    or
    http://localhost:8888/
    ```

# References
* [NVIDIA NGC Pytorch Container Guide/README](https://ngc.nvidia.com/catalog/containers/nvidia:pytorch)

# Releases
* [PyTorch NVIDIA Release 22.01](https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel_22-01.html#rel_21-01)
* Note: the latest NVIDIA v 22-03 is having some issues when running my Pytorch/Lightening Transformer NLP experiments, hence the 'v 22-01' is the recommended stable release currrently. The following is a partial contents from the above NVIDIA link.
    ```
    PyTorch Release 22.01
    The NVIDIA container image for PyTorch, release 22.01, is available on NGC.
    
    Contents of the PyTorch container
    This container image contains the complete source of the version of PyTorch in /opt/pytorch. It is pre-built and installed in Conda default environment (/opt/conda/lib/python3.8/site-packages/torch/) in the container image.
    
    The container also includes the following:
    Ubuntu 20.04 including Python 3.8 environment
    NVIDIA CUDA 11.6.0
    cuBLAS 11.8.1.74
    NVIDIA cuDNN 8.3.2.44
    NVIDIA NCCL 2.11.4 (optimized for NVLink™)
    RAPIDS 21.12 (For x86, only these libraries are included: cudf, xgboost, rmm, cuml, and cugraph.)
    rdma-core 36.0
    NVIDIA HPC-X 2.10
    OpenMPI 4.1.2rc4+
    OpenUCX 1.12.0
    GDRCopy 2.3
    TensorRT 8.2.2
    Torch-TensorRT 1.1.0a0
    SHARP 2.5
    APEX
    Nsight Compute 2022.1.0.0
    Nsight Systems 2021.3.2.4
    TensorBoard 2.8.0
    DALI 1.9
    MAGMA 2.5.2
    Jupyter and JupyterLab:
    Jupyter Client 6.0.0
    Jupyter Core 4.6.1
    Jupyter Notebook 6.0.3
    JupyterLab 2.3.2
    JupyterLab Server 1.0.6
    Jupyter-TensorBoard
    ```

# Known Issues
Known Issues
The version of OpenUCX included with PyTorch container image version 21.11 has known issues with RAPIDS UCX-Py. When using Dask with this container version, pass protocol="tcp" to LocalCUDACluster(), not protocol="ucx", to work around these issues. Additionally, LocalCUDACluster UCX-specific configurations must remain unspecified; they are: enable_tcp_over_ucx, enable_nvlink, enable_infiniband, enable_rdmacm and ucx_net_devices.
ARM
Passing external CUDA Streams to PyTorch via `torch.cuda.streams.ExternalStream(stream_v)` might fail and is being debugged.
```
