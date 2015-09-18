#!/bin/bash
#

set -e
echo "export JAVA_HOME=/usr/src/jdk1.7.0_80" >> /etc/profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin:~/.composer/vendor/bin" >> /etc/profile
echo "export JRE_HOME=\$JAVA_HOME/jre" >> /etc/profile
echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JRE_HOME/lib" >> /etc/profile
source /etc/profile