#!/bin/sh

wget -O gradle.zip http://services.gradle.org/distributions/gradle-2.13-bin.zip
unzip gradle.zip
rm gradle.zip
ln -s "$HOME/gradle-2.13/bin/gradle" /sbin/gradle
