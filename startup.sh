#!/bin/bash

mkdir -p /opt/photoshow/photos
mkdir -p /opt/photoshow/generated
chown www-data:www-data -R /opt/photoshow

apache2 -DFOREGROUND
