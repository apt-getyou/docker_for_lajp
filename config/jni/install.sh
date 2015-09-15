#!/bin/bash
#
tar -zxvf jdk-7u80-linux-x64.tar.gz -C /usr/src/
echo "export JAVA_HOME=\"/usr/src/jdk1.7.0_80\"" >> /etc/profile
source /etc/profile
echo "export PATH=\"$PATH:$JAVA_HOME/bin\"" >> /etc/profile
echo "export JRE_HOME=\"$JAVA_HOME/jre\"" >> /etc/profile
echo "export CLASSPATH=\".:$JAVA_HOME/lib:$JRE_HOME/lib\"" >> /etc/profile

./make.sh
cp ./jni/liblajpmsgq.so /usr/lib/