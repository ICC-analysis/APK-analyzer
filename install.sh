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
sudo apt-get install libc6-i386 lib32stdc++6
./dex-preopt --bootstrap
cd ..

# Download and install PRIMO
# git clone https://github.com/cedricbonhomme/primo.git
# cd primo/
# sudo python setup.py build
# sudo python setup.py install
# cd ..
# sudo rm -Rf primo/
#
# # Download Protobuf-JSON
# git submodule init
# git submodule update
# touch protobuf_json/__init__.py

# Python dependencies for proto2json.py
#sudo pip install -r requirements.txt
