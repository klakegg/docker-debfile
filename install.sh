#!/bin/sh

apt-get update

# Nice to have
apt-get install -y unzip zip curl wget

# Remove apt metadata
rm -r /var/lib/apt
rm -r /var/lib/dpkg
