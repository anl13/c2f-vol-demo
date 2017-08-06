# Implementation of c2f-vol-demo

## Introduction 

This document is written by AnLiang, THU. For original project, refer to [c2f-vol-demo][0]

## environment
Ubuntu 16.04 (4.8.0-36-generic)
python2.7.12 
CUDA-8.0 (Driver version 375.26, GPU GeForce 1080) 

## libraries

1. MATLAB
I have installed MATLAB2016a at `/usr/local/MATLAB/R2016a` 

2. cudnn 
I have installed it under `/usr/local/cuda-8.0`

3. hdf5
```shell
sudo apt-get install libhdf5-dev libhdf5-serial-dev hdf5-tools
sudo apt-get install python-h5py python-hdf5storage (maybe optional)
```

4. Torch7
Follow the installation guide [torch install][1] 
Theoratically, luajit and luarocks are installed by Torch installation file.
Attention: when install Torch7, do not `sudo`. 

6. hdf5 for lua 
Torch7 install most libraries for lua.
However, `hdf5` for `lua` is not installed. 
(1) First way, need to use `luarocks install hdf5` to install it. Before that, `gcc_plugin.h` should be installed, using `sudo apt-get install gcc-5-plugin-dev` for I use ubuntu 16.04 with gcc5.4.0 .
Error still ocurr. Because: installed luarocks2.2 on my own, which may conflict with luarocks installed by Torch7. So, just remove luarocks you installed. 
Then, 
```shell
luarocks install hdf5 
```
(2) Second way, git clone `torch-hdf5`, and build it. 
```shell 
git clone https://github.com/deepmind/torch-hdf5.git
cd torch-hdf5; mkdir build; cd build
cmake ..
make 
sudo make install
```
However, error still ocurrs when `require 'hdf5'` in lua interface. 
```
require 'hdf5'
stdin:1: module 'hdf5' not found:
    no field package.preload['hdf5']
    no file '/home/al17/.luarocks/share/lua/5.1/hdf5.lua'
    no file '/home/al17/.luarocks/share/lua/5.1/hdf5/init.lua'
    no file '/home/al17/torch/install/share/lua/5.1/hdf5.lua'
    no file '/home/al17/torch/install/share/lua/5.1/hdf5/init.lua'
    no file './hdf5.lua'
    no file '/home/al17/torch/install/share/luajit-2.1.0-beta1/hdf5.lua'
    no file '/usr/local/share/lua/5.1/hdf5.lua'
    no file '/usr/local/share/lua/5.1/hdf5/init.lua'
    no file '/home/al17/torch/install/lib/hdf5.so'
    no file '/home/al17/.luarocks/lib/lua/5.1/hdf5.so'
    no file '/home/al17/torch/install/lib/lua/5.1/hdf5.so'
    no file '/home/al17/torch/install/lib/hdf5.so'
    no file './hdf5.so'
    no file '/usr/local/lib/lua/5.1/hdf5.so'
    no file '/usr/local/lib/lua/5.1/loadall.so'
stack traceback:
    [C]: in function 'require'
    stdin:1: in main chunk
    [C]: ?

```

5. lua
## build
No need. 

## run
Refer to github README.

### dataset 
SURREAL (which contain HUMAN3.6M) 


[0]: "https://github.com/geopavlakos/c2f-vol-demo" 'c2f-vol-demo' 
[1]: "torch.ch/docs/getting-started.html#_ 'torch installation' 

