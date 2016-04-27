# APK analyzer

## Requirements

You will need to install:
- [dare](http://siis.cse.psu.edu/dare): the Dare tool retargets Android
  applications in .dex or .apk format to traditional .class files;
- [IC3](http://siis.cse.psu.edu/ic3/): inter-Component Communication Analysis
  for Android.

~~~~shell
$ git clone https://git.list.lu/visual/APK-analyzer.git
$ cd APK-analyzer/

$ mkdir ic3
$ wget https://github.com/siis/ic3/releases/download/v0.2.0/ic3-0.2.0-bin.tgz
$ tar -xzvf ic3-0.2.0-bin.tgz -C ic3 --strip-components=1
$ rm ic3-0.2.0-bin.tgz

$ mkdir dare
$ wget https://github.com/dare-android/platform_dalvik/releases/download/dare-1.1.0/dare-1.1.0-linux.tgz
$ tar -xzvf dare-1.1.0-linux.tgz -C dare --strip-components=1
$ rm dare-1.1.0-linux.tgz
$ cd dare
$ sudo apt-get install ia32-libs
$ ./dex-preopt --bootstrap
~~~~

## Usage

~~~~shell
$ parallel -j 5 ./analyze_apk.sh ::: ~/APK-analyzer/sample_APK/*.apk
~~~~

## License information

[Luxembourg Institute of Science and Technology](http://list.lu/) (LIST).
