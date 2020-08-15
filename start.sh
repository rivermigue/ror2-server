#!/bin/bash

echo "Generating initial configuration..."
/opt/wine-stable/bin/winecfg

echo "Sleeping for 5 seconds"
sleep 5

echo "Starting server..."
xvfb-run /opt/wine-stable/bin/wine "./Risk of Rain 2.exe"
