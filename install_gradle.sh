#!/bin/sh
set -xe

# SHA256 of gradle-4.10.2-bin.zip
CHECKSUM=b49c6da1b2cb67a0caf6c7480630b51c70a11ca2016ff2f555eaeda863143a29

wget -O gradle.zip 'https://downloads.gradle-dn.com/distributions/gradle-4.10.2-bin.zip'
echo "$CHECKSUM  gradle.zip" | sha256sum -c -w -

unzip gradle.zip
rm gradle.zip
ln -s "$HOME/gradle-4.10.2/bin/gradle" /sbin/gradle
