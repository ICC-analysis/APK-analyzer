
"""Module for fetching data from protobufs."""

from google.protobuf import text_format
import logging
import os
import sys
import json

import protobuf_json
from primo.linking import ic3_data_pb2

exit_point_count = 0
intent_count = 0
intent_filter_count = 0


def FetchData(protobufs, protodirs, validate):
    """Fetches data from disk.

    Args:
        protobufs: A list of paths to protobufs.
        protodirs: A list of paths to directories containing protobufs.
        validate: True if validation is being performed.

    Returns: A tuple with the set of applications, the set of components, the list
    of Intents and the set of Intent Filters.
    """

    apps = set()
    components = set()
    intents = []
    intent_filters = set()

    if protobufs:
        for file_path in protobufs:
            ProcessFile(file_path, apps, components, intents, intent_filters,
                                    validate)

    if protodirs:
        for directory in protodirs:
            for file_path in os.listdir(directory):
                ProcessFile(os.path.join(directory, file_path), apps, components,
                                        intents, intent_filters, validate)

    print 'Applications: %s' % len(apps)
    print 'Exit points: %s' % exit_point_count
    print 'Intents: %s' % intent_count
    print 'Intent filters: %s' % intent_filter_count
    return apps, components, intents, intent_filters


def ProcessFile(file_path, apps, components, intents, intent_filters, validate):
    """Loads a single protobuf.

    Args:
        file_path: The path to a protobuf.
        apps: The set of applications.
        components: The set of components.
        intents: The list of Intents.
        intent_filters: The set of Intent Filters.
        validate: True if validation is being performed.
    """

    if os.path.islink(file_path):
        linked_path = os.readlink(file_path)
        file_path = (linked_path if os.path.isabs(linked_path)
                                 else os.path.join(os.path.dirname(file_path), linked_path))
    file_contents_string = None
    with open(file_path) as in_file:
        file_contents_string = in_file.read()

    application = ic3_data_pb2.Application()


    if file_path.endswith('.txt'):
        text_format.Merge(file_contents_string, application)
    else:
        application.ParseFromString(file_contents_string)


    #print(application)


    json_obj = protobuf_json.pb2json(application)



    output_folder = './json_output'
    with open(output_folder + '/test.json', 'w') as outfile:
        json.dump(json_obj, outfile, indent=4)
    #print json.dumps(json_obj, sort_keys=True, indent=4,
                        #separators=(',', ': '))



if __name__ == "__main__":
    # Point of entry in execution mode
    protobufs = sys.argv[1]
    apps, components, intents, intent_filters = FetchData([protobufs], "", True)
