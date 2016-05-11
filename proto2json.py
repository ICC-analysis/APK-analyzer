#! /usr/bin/env python
# -*- coding: utf-8 -*-

"""Converts an IC3 ProtoBuf message to JSON."""

import os
import sys
import json
from google.protobuf import text_format
from protobuf_json import protobuf_json
from primo.linking import ic3_data_pb2

def help():
    print "Usage:\n\t{} {} {}".format(sys.argv[0], "<ic3-proto-message>",
                                        "<output-directory>")
    exit(0)

if __name__ == "__main__":
    # Point of entry in execution mode
    try:
        file_path = sys.argv[1]
        output_folder = sys.argv[2]
    except:
        help()

    with open(file_path) as in_file:
        file_contents_string = in_file.read()

    application = ic3_data_pb2.Application()
    if file_path.endswith('.txt'):
        text_format.Merge(file_contents_string, application)
    else:
        application.ParseFromString(file_contents_string)

    json_obj = protobuf_json.pb2json(application)

    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    output_filename = os.path.splitext(os.path.basename(file_path))[0] + '.json'
    with open(os.path.join(output_folder, output_filename), 'w') as outfile:
        json.dump(json_obj, outfile, indent=4)
