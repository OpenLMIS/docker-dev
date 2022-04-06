#!/bin/sh
set -xe

# SHA256 of gradle-5.2.1-bin.zip
CHECKSUM=748c33ff8d216736723be4037085b8dc342c6a0f309081acf682c9803e407357

wget -O gradle.zip 'https://downloads.gradle-dn.com/distributions/gradle-5.2.1-bin.zip'
echo "$CHECKSUM  gradle.zip" | sha256sum -c -w -

unzip gradle.zip
rm gradle.zip
ln -s "$HOME/gradle-5.2.1/bin/gradle" /sbin/gradle
