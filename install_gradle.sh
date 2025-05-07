#!/bin/sh
set -xe

# SHA256 of gradle-6.8.3-bin.zip
CHECKSUM=7faa7198769f872826c8ef4f1450f839ec27f0b4d5d1e51bade63667cbccd205

wget -O gradle.zip 'https://services.gradle.org/distributions/gradle-6.8.3-bin.zip'
echo "$CHECKSUM  gradle.zip" | sha256sum -c -w -

unzip gradle.zip
rm gradle.zip
ln -s "$HOME/gradle-6.8.3/bin/gradle" /sbin/gradle
