#!/bin/sh

if [ ! $2 ]; then
	echo "Please specify parameters: [section] [package]"
	exit
fi

# Create configuration folder.
mkdir -p debian/DEBIAN

# Specify version
timestamp=$(date +%s)
version=$timestamp

# Create metadata file.
echo "Package: $2" > debian/DEBIAN/control
echo "Version: $timestamp:$version" >> debian/DEBIAN/control
echo "Section: $1" >> debian/DEBIAN/control
echo "Priority: $PRIORITY" >> debian/DEBIAN/control
echo "Architecture: $ARCHITECTURE" >> debian/DEBIAN/control
echo "Essential: $ESSENTIAL" >> debian/DEBIAN/control
echo "Maintainer: $MAINTAINER" >> debian/DEBIAN/control
echo "Description: $2" >> debian/DEBIAN/control

# Run debfile script
if [ -e Debfile ]; then
	sh Debfile
elif [ -e /debfile/package/$2 ]; then
	sh /debfile/package/$2
fi

# Make postinst file executable if found.
if [ -f debian/DEBIAN/postinst ]; then
	chmod a+x debian/DEBIAN/postinst
fi

# Create package
dpkg-deb --build debian /target/$2-$timestamp:$version.deb

