#!/bin/bash

source /etc/apache2/envvars

mkdir -p /opt/photoshow/photos
mkdir -p /opt/photoshow/generated
chown www-data:www-data -R /opt/photoshow

apache2 -DFOREGROUND
