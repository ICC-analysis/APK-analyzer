#! /bin/sh


APK_FILE=`realpath $1`
APK_NAME=`basename ${APK_FILE%.apk}`

DARE_OUTPUT_DIRECTORY=${APK_FILE%.apk}

IC3_OUTPUT_DIRECTORY=`realpath "./binary_proto"`
IC3_PROTO=`realpath "proto_file/ic3_data.proto"`

# Paths to dare and ic3
DARE_DIRECTORY="./dare"
IC3_DIRECTORY="./ic3"

ANDROID_JAR=`realpath $IC3_DIRECTORY/android.jar`


# Generation of the retargeted APK
$DARE_DIRECTORY/dare -d $DARE_OUTPUT_DIRECTORY $APK_FILE


# Generation of the binary proto file
if [ ! -d "$IC3_OUTPUT_DIRECTORY" ]; then
  mkdir $IC3_OUTPUT_DIRECTORY
fi
if [ ! -d $IC3_OUTPUT_DIRECTORY/$APK_NAME ]; then
  mkdir $IC3_OUTPUT_DIRECTORY/$APK_NAME
fi

java -jar $IC3_DIRECTORY/ic3-0.2.0-full.jar \
    -apkormanifest $APK_FILE \
    -input $DARE_OUTPUT_DIRECTORY/retargeted/$APK_NAME \
    -cp $ANDROID_JAR \
    -binary \
    -protobuf $IC3_OUTPUT_DIRECTORY/$APK_NAME
rm -Rf $DARE_OUTPUT_DIRECTORY


# Load the binary proto file
node builder.js  $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}`/*.dat $IC3_PROTO
rm  -Rf $IC3_OUTPUT_DIRECTORY/$APK_NAME



#primo.py --protodir ic3/ --stats stats.csv --dumpintentlinks links.blp
#make_plots_and_stats.py --input links.blp --out stats/
