#!/bin/bash

mkdir /data

curl -L $OSM_SOURCE --create-dirs -o /data/$OSM_FILE

./graphhopper.sh --action web --input "/data/$OSM_FILE" --config config.yml