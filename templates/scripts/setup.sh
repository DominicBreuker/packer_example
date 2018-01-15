#!/bin/bash
set -e

echo "Executing setup.sh..." > /tmp/setup-status.txt

echo "---- Update and Upgrade"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install curl unzip zip jq vim

echo "... setup done!" >> /tmp/setup-status.txt
