#! /bin/sh


APK_FILE=$1
DARE_OUTPUT_DIRECTORY=${APK_FILE%.apk}
IC3_OUTPUT_DIRECTORY="./binary_proto"
IC3_PROTO="proto_file/ic3_data.proto"

# Paths to dare and ic3
DARE_DIRECTORY="./dare"
IC3_DIRECTORY="./ic3"


# Generation of the retargeted APK
$DARE_DIRECTORY/dare -d $DARE_OUTPUT_DIRECTORY $APK_FILE


# Generation of the binary proto file
if [ ! -d "$IC3_OUTPUT_DIRECTORY" ]; then
  mkdir $IC3_OUTPUT_DIRECTORY
  mkdir $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}`
fi
if [ ! -d $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}` ]; then
  mkdir $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}`
fi
java -jar $IC3_DIRECTORY/ic3-0.2.0-full.jar \
    -apkormanifest $APK_FILE \
    -input $DARE_OUTPUT_DIRECTORY/retargeted/${x%.apk} \
    -cp ic3/android.jar \
    -binary \
    -protobuf $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}`
rm -Rf $DARE_OUTPUT_DIRECTORY


# Load the binary proto file
node builder.js  $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}`/*.dat $IC3_PROTO
rm  -Rf $IC3_OUTPUT_DIRECTORY/`basename ${APK_FILE%.apk}`/




# Load the binary proto file
#node read_binary_protobuf.js ${x%.apk}.dat


#java -jar ic3/ic3-0.2.0-full.jar -apkormanifest $APK_FILE -input ./retargeted/${x%.apk} -cp android.jar -protobuf outputProto/
#primo.py --protodir ic3/ --stats stats.csv --dumpintentlinks links.blp
#make_plots_and_stats.py --input links.blp --out stats/
