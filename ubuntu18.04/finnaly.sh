#!/bin/bash

userName="stage";
chmod -R 755 /home/centos/dev/${userName}/

cd /usr/bin
ln -Tfs /usr/local/bin/python3.9 python3