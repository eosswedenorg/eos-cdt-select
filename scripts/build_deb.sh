#!/usr/bin/env bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

PACKAGE_NAME=eos-cdt-select
PACKAGE_VERSION="0.1.2"
PACKAGE_PREFIX=${PACKAGE_PREFIX:-usr/local}
PACKAGE_DESCRIPTION="Simple script to switch between multiple EOS CDT verions on the same system."
PACKAGE_TMPDIR="pack"

# Default to 1 if no release is set.
if [[ -z $RELEASE ]]; then
  RELEASE="1"
fi

PACKAGE_FULLNAME="${PACKAGE_NAME}_${PACKAGE_VERSION}-${RELEASE}_all"

rm -fr ${BASE_DIR}/${PACKAGE_TMPDIR}

# Create debian files.
mkdir -p ${BASE_DIR}/${PACKAGE_TMPDIR}/DEBIAN
echo "Package: ${PACKAGE_NAME}
Version: ${PACKAGE_VERSION}-${RELEASE}
Section: devel
Priority: optional
Architecture: all
Homepage: https://github.com/eosswedenorg/eos-cdt-select
Maintainer: Henrik Hautakoski <henrik@eossweden.org>
Description: ${PACKAGE_DESCRIPTION}" &> ${BASE_DIR}/${PACKAGE_TMPDIR}/DEBIAN/control

cat ${BASE_DIR}/${PACKAGE_TMPDIR}/DEBIAN/control

mkdir -p ${BASE_DIR}/${PACKAGE_TMPDIR}/${PACKAGE_PREFIX}/bin
mkdir -p ${BASE_DIR}/${PACKAGE_TMPDIR}/${PACKAGE_PREFIX}/share/${PACKAGE_NAME}
cp ${BASE_DIR}/../${PACKAGE_NAME} ${BASE_DIR}/${PACKAGE_TMPDIR}/${PACKAGE_PREFIX}/bin
cp ${BASE_DIR}/../LICENSE ${BASE_DIR}/../README.md ${BASE_DIR}/${PACKAGE_TMPDIR}/${PACKAGE_PREFIX}/share/${PACKAGE_NAME}

dpkg-deb --root-owner-group --build ${BASE_DIR}/${PACKAGE_TMPDIR} ${BASE_DIR}/${PACKAGE_FULLNAME}.deb
