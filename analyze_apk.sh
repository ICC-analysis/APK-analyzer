#! /bin/sh

# This script extracts information from an Android application (APK file).
# The output is a JSON file with the components, intents, intents filters
# and permissions of the application.
#
# You can use it on a set of applications:
#  $ parallel -j 5 ./analyze_apk.sh ::: ~/sample-APK/*.apk
#
# Author: Cédric Bonhomme

ROOT_APPLICATION="./"
ROOT_OUTPUT="./result/"

# APK file to analyze
APK_FILE=`realpath $1`
APK_NAME=`basename ${APK_FILE%.apk}`

IC3_OUTPUT_DIRECTORY=$ROOT_OUTPUT"/ic3/"$APK_NAME
mkdir -p $IC3_OUTPUT_DIRECTORY
IC3_OUTPUT_DIRECTORY=`readlink -f $IC3_OUTPUT_DIRECTORY`
PROTO2JSON_OUTPUT_DIRECTORY=$ROOT_OUTPUT


# Analyzes the Inter-Component Communication (ICC) of the APK
# the output is a proto file
./apk2icc.sh $APK_FILE false


# Convert the proto file to a more readable JSON file
#IC3_PROTO=`realpath "proto_file/ic3_data.proto"`
#node proto2json.js  $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}`/*.dat $IC3_PROTO
echo "Convert the result of PRIMO to a JSON file..."
python proto2json.py $IC3_OUTPUT_DIRECTORY/*.txt \
                    $PROTO2JSON_OUTPUT_DIRECTORY
#rm -Rf $IC3_OUTPUT_DIRECTORY/
