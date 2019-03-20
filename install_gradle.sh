#!/bin/sh

wget -O gradle.zip http://services.gradle.org/distributions/gradle-5.2.1-bin.zip
unzip gradle.zip
rm gradle.zip
ln -s "$HOME/gradle-5.2.1/bin/gradle" /sbin/gradle
