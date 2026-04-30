#!/bin/bash
set -euo pipefail

PACKAGE_NAME=$1
VERSION=$2
ARCH=$3

# Load config
source package.env

echo "Packaging $PACKAGE_NAME version $VERSION for $ARCH"

# Create Debian package structure
BUILD_DIR="build_${PACKAGE_NAME}_${VERSION}_${ARCH}"
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr/bin"
mkdir -p "$BUILD_DIR/usr/share/doc/$PACKAGE_NAME"
mkdir -p output

# ----- TEMPLATE SECTION: Customize how to download and extract your binary -----
# Note: Upstream repositories use different naming conventions for their releases.
# You will likely need to adjust the filename format below.

# Example for fetching a linux gz release:
DOWNLOAD_URL="https://github.com/${UPSTREAM_REPO}/releases/download/v${VERSION}/${PACKAGE_NAME}-v${VERSION}-linux-${ARCH}.gz"
echo "Downloading from $DOWNLOAD_URL"

# Uncomment and adjust the following lines for real packaging:
wget -qO archive.gz "$DOWNLOAD_URL"
gunzip -c archive.gz > "$BUILD_DIR/usr/bin/$PACKAGE_NAME"
chmod +x "$BUILD_DIR/usr/bin/$PACKAGE_NAME"
rm archive.gz

# -------------------------------------------------------------------------------

# Create control file
cat <<EOF > "$BUILD_DIR/DEBIAN/control"
Package: $PACKAGE_NAME
Version: $VERSION
Architecture: $ARCH
Maintainer: $MAINTAINER
Description: $DESCRIPTION
Homepage: $HOMEPAGE
EOF

# Create copyright file
cat <<EOF > "$BUILD_DIR/usr/share/doc/$PACKAGE_NAME/copyright"
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: $PACKAGE_NAME
Source: $HOMEPAGE
License: $LICENSE
EOF

# Build the Debian package
dpkg-deb --build "$BUILD_DIR" "output/${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"

echo "Package built at output/${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"
