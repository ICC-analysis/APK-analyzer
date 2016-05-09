#! /usr/bin/env bash

# Download IC3 jar file with the android.jar file.
mkdir ic3
wget https://github.com/siis/ic3/releases/download/v0.2.0/ic3-0.2.0-bin.tgz
tar -xzvf ic3-0.2.0-bin.tgz -C ic3 --strip-components=1
rm ic3-0.2.0-bin.tgz

# Download Dare
mkdir dare
wget https://github.com/dare-android/platform_dalvik/releases/download/dare-1.1.0/dare-1.1.0-linux.tgz
tar -xzvf dare-1.1.0-linux.tgz -C dare --strip-components=1
rm dare-1.1.0-linux.tgz
cd dare
sudo apt-get install ia32-libs
./dex-preopt --bootstrap
cd ..

# Download and install Primo
git submodule init
git submodule update
cd primo
touch __init__.py
sudo python setup.py build
cd ..

touch protobuf_json/__init__.py

# Python dependencies for proto2json.py
sudo pip install -r requirements.txt
