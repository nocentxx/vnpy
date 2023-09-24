#!/usr/bin/env bash

python=$1
pypi_index=$2
shift 2


[[ -z $python ]] && python=python3

$python -m pip install --upgrade pip wheel #--index $pypi_index

# Get and build ta-lib
function install-ta-lib()
{
    # install numpy first
    #$python -m pip install numpy==1.23.1 #--index $pypi_index
    $python -m pip install numpy==1.23.1 #1.26.0

    pushd /tmp
    wget https://pip.vnpy.com/colletion/ta-lib-0.4.0-src.tar.gz
    tar -xf ta-lib-0.4.0-src.tar.gz
    cd ta-lib
    ./configure --prefix=/usr/local
    make -j1
    sudo make install
    popd

    #$python -m pip install ta-lib==0.4.24 --index $pypi_index
    $python -m pip install ta-lib==0.4.25
}
function ta-lib-exists()
{
    ta-lib-config --libs > /dev/null
}
ta-lib-exists || install-ta-lib

# Install Python Modules
#$python -m pip install -r requirements.txt --index $pypi_index
$python -m pip install -r requirements.txt

# Install local Chinese language environment
#locale-gen zh_CN.GB18030

# Install VeighNa
#$python -m pip install . --index $pypi_index
$python -m pip install .
