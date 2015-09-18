#!/bin/sh

# -----------------------------------------------------------
#  LAJP-JNI 编译脚本 (2009-09 http://code.google.com/p/lajp/)
#  
#  编译环境: Unix/Linux
#  
#  源文件: lajp_MsgQ.c lajp_MsgQ.h
#  目标文件: liblajpmsgq.so
#  编译参数:
#		--share	: 编译为动态库
#		-I		: 搜索编译JNI需要的.h文件, 注意"/usr/lib/jvm/java-6-sun/"
#				: 要换成编译环境中的JAVA_HOME路径
#
#  liblajpmsgq.so发布	: 复制到<java.library.path>中，可通过java程序:
#						: System.out.println(System.getProperties().getProperty("java.library.path"));
#						: 获得本机的<java.library.path>
# -----------------------------------------------------------
# 
# 
#echo "gcc lajp_MsgQ.c  --share -FPIC -I. -I/usr/src/jdk1.7.0_80/include -I/usr/src/jdk1.7.0_80/include/linux -o liblajpmsgq.so"
gcc lajp_MsgQ.c  --share -fPIC -I. -I/usr/src/jdk1.7.0_80/include -I/usr/src/jdk1.7.0_80/include/linux -o liblajpmsgq.so
