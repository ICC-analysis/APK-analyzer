#! /bin/sh

# This script extracts information from an Android application (APK file).
# The output is a binary file with Inter-Component Communication
# (components, intents, intents filters, permissions, etc.).
#
#  $ ./apk2icc.sh ~/sample-APK/application.apk

ROOT_APPLICATION="./"
ROOT_OUTPUT="./result/"

# Paths to dare and ic3 binaries
DARE_DIRECTORY=$ROOT_APPLICATION"/dare"
IC3_DIRECTORY=$ROOT_APPLICATION"/ic3"
ANDROID_JAR=`readlink -f $IC3_DIRECTORY/android.jar`

# APK file to analyze
APK_FILE=`realpath $1`
APK_NAME=`basename ${APK_FILE%.apk}`

# Outputs
DARE_OUTPUT_DIRECTORY=$ROOT_OUTPUT"/dare/"$APK_NAME
mkdir -p $DARE_OUTPUT_DIRECTORY
DARE_OUTPUT_DIRECTORY=`readlink -f $DARE_OUTPUT_DIRECTORY`
IC3_OUTPUT_DIRECTORY=$ROOT_OUTPUT"/ic3/"$APK_NAME
mkdir -p $IC3_OUTPUT_DIRECTORY
IC3_OUTPUT_DIRECTORY=`readlink -f $IC3_OUTPUT_DIRECTORY`

# Generation of the retargeted APK
$DARE_DIRECTORY/dare -d $DARE_OUTPUT_DIRECTORY $APK_FILE

# Generation of the binary proto file
java -jar $IC3_DIRECTORY/ic3-0.2.0-full.jar \
    -apkormanifest $APK_FILE \
    -input $DARE_OUTPUT_DIRECTORY/retargeted/$APK_NAME \
    -cp $ANDROID_JAR \
    -protobuf $IC3_OUTPUT_DIRECTORY \
    -binary
rm -Rf $DARE_OUTPUT_DIRECTORY sootOutput
