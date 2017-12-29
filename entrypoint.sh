#!/bin/sh

set -e

if [ ! $1 ]; then
	echo "Please specify parameter: package"
	exit
fi

package=$1

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
ver=$timestamp:$version$tag

# Create metadata file.
echo "Package: $package" > DEBIAN/control
echo "Version: $ver" >> DEBIAN/control
echo "Section: $SECTION" >> DEBIAN/control
echo "Priority: $PRIORITY" >> DEBIAN/control
echo "Architecture: $ARCHITECTURE" >> DEBIAN/control
echo "Essential: $ESSENTIAL" >> DEBIAN/control
echo "Maintainer: $MAINTAINER" >> DEBIAN/control
echo "Description: $1" >> DEBIAN/control

# Run debfile script
if [ -e $DEBFILE ]; then
	sh $DEBFILE
elif [ -e /package/$package ]; then
	sh /package/$package
fi

# Make postinst file executable if found.
for file in postinst preinst prerm postrm; do
	if [ -f DEBIAN/$file ]; then
		chmod 500 DEBIAN/$file
	fi
done

# Create target folder if it doesn't exists.
if [ ! -e $TARGET ]; then
	mkdir -p $TARGET
	chown $OWNER $TARGET
fi

# Create package and write debfile-current
dpkg-deb --build /debian $TARGET/$package-$ver-$ARCHITECTURE.deb
echo -n "$package-$ver-$ARCHITECTURE.deb" > $TARGET/$package-current-$ARCHITECTURE
chown $OWNER $TARGET/$package-$ver-$ARCHITECTURE.deb $TARGET/$package-current-$ARCHITECTURE
