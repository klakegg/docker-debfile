#!/bin/sh

if [ ! $2 ]; then
	echo "Please specify parameters: section package"
	exit
fi

# Copy debian folder if found.
if [ -e /src/debian ]; then
	cp -a /src/debian/. /debian
fi

# Create configuration folder.
mkdir -p DEBIAN

# Specify version
if [ ! $TIMESTAMP = "-" ]; then timestamp=$TIMESTAMP; else timestamp=$(date +%s); fi
if [ ! $VERSION = "-" ]; then version=$VERSION; else version=$timestamp; fi
if [ ! $TAG = "-" ]; then tag="-$TAG"; fi

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
if [ -e $DEBFILE ]; then
	sh $DEBFILE
elif [ -e /package/$2 ]; then
	sh /package/$2
fi

# Make postinst file executable if found.
if [ -f DEBIAN/postinst ]; then
	chmod a+x DEBIAN/postinst
fi

# Create package and write debfile-current
dpkg-deb --build /debian /target/$2-$timestamp:$version$tag-$ARCHITECTURE.deb
echo -n "$2-$timestamp:$version$tag-$ARCHITECTURE.deb" > /target/debfile-current
