# APK analyzer

Batch analysis of APK files with Dare, IC3 and PRIMO.


## Requirements

The script ```install.sh``` will install all the requirements:

- [Dare](http://siis.cse.psu.edu/dare): the Dare tool retargets Android
  applications in .dex or .apk format to traditional .class files;
- [IC3](http://siis.cse.psu.edu/ic3/): inter-Component Communication Analysis
  for Android;
- [PRIMO](http://siis.cse.psu.edu/primo/): a tool for static Intent resolution
  and probabilistic value inference.


## Usage

~~~~shell
$ parallel -j 5 ./analyze_apk.sh ::: ~/sample_APK/*.apk

$ ls -l result/
total 548
-rw-r--r-- 1 cedric cedric  9375 Apr 27 08:28 a2dp.Vol_107.json
-rw-r--r-- 1 cedric cedric  3983 Apr 27 08:29 air.br.com.bitlabs.FLVPlayer_1007003.json
-rw-r--r-- 1 cedric cedric 13389 Apr 27 08:29 air.com.bitrhymes.bingo_1011000.json
-rw-r--r-- 1 cedric cedric  1523 Apr 27 08:28 air.MSPMobile_1003000.json
-rw-r--r-- 1 cedric cedric  2153 Apr 27 08:28 Android.mussyu_301.json
-rw-r--r-- 1 cedric cedric 11449 Apr 27 08:29 atticlab.bodyscanner_37.json
-rw-r--r-- 1 cedric cedric  7423 Apr 27 08:29 au.gov.nsw.transport.speedadviser_3.json
-rw-r--r-- 1 cedric cedric  7102 Apr 27 08:29 caldwell.ben.bites_4.json
-rw-r--r-- 1 cedric cedric  8046 Apr 27 08:29 cameraviewer.app.agasio_4.json
-rw-r--r-- 1 cedric cedric  7727 Apr 27 08:29 campyre.android_7.json
-rw-r--r-- 1 cedric cedric  4254 Apr 27 08:29 cenix.android.vbr_15.json
-rw-r--r-- 1 cedric cedric 10398 Apr 27 08:30 ch.smalltech.ledflashlight.free_150.json
-rw-r--r-- 1 cedric cedric 12512 Apr 27 08:30 com.aceviral.angrygranrun_16.json
-rw-r--r-- 1 cedric cedric  8533 Apr 27 08:30 com.acr.tubevideodownloader_7.json
-rw-r--r-- 1 cedric cedric  9607 Apr 27 08:30 com.adobe.reader_73784.json
-rw-r--r-- 1 cedric cedric 22626 Apr 27 08:30 com.agilesoftresource_126.json
~~~~


## License information

[Luxembourg Institute of Science and Technology](http://list.lu/) (LIST).
