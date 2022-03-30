# NVIDIA CUDA + PyTorch Monthly build + Jupyter in Docker Container
* All the information below mainly from nvidia.com except the wrapper shell scripts (and related documentations) that I created.
* Latest RTX 3090 GPU is supported (tested to work too) in this Docker Container.
* Warning: the Container image is relative huge! Make sure you have have large Memory, CPU, and GPU to run. Alos, this Container is not for low end GPU and CPU to use to run Deep Learning models.

# Build
```
make build
```

# Run
* Default run is to auto-detect Host's NVIDIA GPU, e.g., RTX 3090 or any and use all the CUDA.
```
./run.sh

or
./run.sh -d   (detached)
```

Then, go to your Web Browser to access Jupyter Notebook with "ChangeMe!" as default password.
```
http://localhost:8888/
```

# References
* [NVIDIA NGC Pytorch Container Guide/README](https://ngc.nvidia.com/catalog/containers/nvidia:pytorch)

# Releases
* [PyTorch NVIDIA Release 21.09](https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel_21-09.html#rel_21-09)
```
PyTorch Release 21.09
The NVIDIA container image for PyTorch, release 21.09, is available on NGC.

Contents of the PyTorch container
This container image contains the complete source of the version of PyTorch in /opt/pytorch. It is pre-built and installed in Conda default environment (/opt/conda/lib/python3.8/site-packages/torch/) in the container image.

The container also includes the following:
Ubuntu 20.04 including Python 3.8 environment
NVIDIA CUDA 11.4.2
cuBLAS 11.6.1.51
NVIDIA cuDNN 8.2.4.15
NVIDIA NCCL 2.11.4
APEX
rdma-core 36.0
OpenMPI 4.1.2a1
OpenUCX 1.11.1rc
GDRCopy 2.3
NVIDIA HPC-X 2.9
Nsight Compute 2021.2.2.0
Nsight Systems 2021.3.1.57
TensorRT 8.0.3
TensorBoard 2.6.0
DALI 1.5
MAGMA 2.5.2
DLProf 1.5.0
Jupyter and JupyterLab:
Jupyter Client 6.0.0
Jupyter Core 4.6.1
Jupyter Notebook 6.0.3
JupyterLab 2.3.1
JupyterLab Server 1.0.6
Jupyter-TensorBoard
```

# Driver Requirements
Release 21.09 is based on NVIDIA CUDA 11.4.2, which requires NVIDIA Driver release 470 or later. However, if you are running on Data Center GPUs (formerly Tesla), for example, T4, you may use NVIDIA driver release 418.40 (or later R418), 440.33 (or later R440), 450.51 (or later R450), or 460.27 (or later R460). The CUDA driver's compatibility package only supports particular drivers. For a complete list of supported drivers, see the CUDA Application Compatibility topic. For more information, see CUDA Compatibility and Upgrades and NVIDIA CUDA and Drivers Support.

# GPU Requirements
Release 21.09 supports CUDA compute capability 6.0 and higher. This corresponds to GPUs in the Pascal, Volta, Turing, and NVIDIA Ampere GPU architecture families. Specifically, for a list of GPUs that this compute capability corresponds to, see CUDA GPUs. For additional support details, see Deep Learning Frameworks Support Matrix.

# Key Features and Enhancements
This PyTorch release includes the following key features and enhancements.
PyTorch container image version 21.09 is based on 1.10.0a0+3fd9dcf

# Known Issues
1. You might see the warning below and, if you necessary, please fix in your Container to meet your needs.
```
tensorflow 2.6.0 requires numpy~=1.19.2, but you have numpy 1.21.2 which is incompatible
```
