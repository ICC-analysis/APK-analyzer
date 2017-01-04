#! /bin/sh

# This script extracts information from an Android application (APK file).
# The output is a binary file with Inter-Component Communication
# (components, intents, intents filters, permissions, etc.).
#
#  $ ./apk2icc.sh ~/sample-APK/application.apk

APK_FILE=`realpath $1`
APK_NAME=`basename ${APK_FILE%.apk}`

TEMP_DIRECTORY=`realpath "./tmp"`
DARE_OUTPUT_DIRECTORY=$TEMP_DIRECTORY"/dare/"$APK_NAME
IC3_OUTPUT_DIRECTORY="./result"

# Paths to dare and ic3 binaries
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
    -protobuf $IC3_OUTPUT_DIRECTORY/$APK_NAME \
    -binary
rm -Rf $DARE_OUTPUT_DIRECTORY sootOutput $TEMP_DIRECTORY
