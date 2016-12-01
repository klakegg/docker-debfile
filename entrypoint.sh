#!/bin/sh

if [ ! $2 ]; then
	echo "Please specify parameters: [section] [package]"
	exit
fi

# Copy debian folder if found.
if [ -e /src/debian ]; then
	cp -a /src/debian/. /debian
fi

# Create configuration folder.
mkdir -p DEBIAN

# Specify version
timestamp=$(date +%s)
if [ ! $VERSION = "-" ]; then version=$VERSION; else version=$timestamp; fi
if [ ! $TAG = "-" ]; then tag="-$TAG"; else tag=""; fi

# Create metadata file.
echo "Package: $2" > DEBIAN/control
echo "Version: $timestamp:$version$tag" >> DEBIAN/control
echo "Section: $1" >> DEBIAN/control
echo "Priority: $PRIORITY" >> DEBIAN/control
echo "Architecture: $ARCHITECTURE" >> DEBIAN/control
echo "Essential: $ESSENTIAL" >> DEBIAN/control
echo "Maintainer: $MAINTAINER" >> DEBIAN/control
echo "Description: $2" >> DEBIAN/control

# Run debfile script
if [ -e /src/Debfile ]; then
	sh /src/Debfile
elif [ -e /debfile/package/$2 ]; then
	sh /debfile/package/$2
fi

# Make postinst file executable if found.
if [ -f DEBIAN/postinst ]; then
	chmod a+x DEBIAN/postinst
fi

# Create package
dpkg-deb --build /debian /target/$2-$timestamp:$version$tag.deb
