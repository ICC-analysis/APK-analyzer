# APK analyzer

## Requirements

You will need to install:
- [dare](http://siis.cse.psu.edu/dare): the Dare tool retargets Android
  applications in .dex or .apk format to traditional .class files;
- [IC3](http://siis.cse.psu.edu/ic3/): inter-Component Communication Analysis
  for Android.

~~~~shell
$ mkdir ic3
$ wget https://github.com/siis/ic3/releases/download/v0.2.0/ic3-0.2.0.jar
$ git clone https://github.com/siis/ic3.git

$ wget https://github.com/dare-android/platform_dalvik/releases/download/dare-1.1.0/dare-1.1.0-linux.tgz
$ tar -xzvf dare-1.1.0-linux.tgz
~~~~

## Usage

~~~~shell
$ parallel -j 5 ./analyze_apk.sh ::: ~/sample_apk/*.apk
~~~~

## License information

[Luxembourg Institute of Science and Technology](http://list.lu/) (LIST).
