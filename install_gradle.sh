#!/bin/sh

wget -O gradle.zip https://services.gradle.org/distributions/gradle-6.4-bin.zip
unzip gradle.zip
rm gradle.zip
ln -s "$HOME/gradle-6.4/bin/gradle" /sbin/gradle
