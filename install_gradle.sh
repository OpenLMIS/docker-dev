#!/bin/sh

wget -O gradle.zip http://services.gradle.org/distributions/gradle-4.0-bin.zip
unzip gradle.zip
rm gradle.zip
ln -s "$HOME/gradle-4.0/bin/gradle" /sbin/gradle
