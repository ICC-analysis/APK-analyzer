#! /usr/bin/env python
# -*- coding: utf-8 -*-

import sys

from primo.linking.fetch_data import FetchData

if __name__ == "__main__":
    # Point of entry in execution mode
    file_path = sys.argv[1:]

    apps, components, intents, intent_filters = FetchData(file_path, "", True)
    print("")
    for app in apps:
        print(app.name)
        print("""\tSends external intent: {}
        Has publicly accessible component: {}""". \
                                        format(app.SendsExternalIntent(),
                                                app.HasOpenComponent()))
