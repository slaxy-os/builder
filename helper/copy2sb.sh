#!/bin/sh

if [ -d "$1" ]
then
  mkdir -p /sb$1
  chown `stat -c "%U:%G" $1` /sb$1
  chmod `stat -c "%a" $1` /sb$1
fi

if [ -f "$1" ]
then
  TMP_DIR="$(dirname $1)"
  mkdir -p /sb$TMP_DIR
  chown `stat -c "%U:%G" $TMP_DIR` /sb$TMP_DIR
  chmod `stat -c "%a" $TMP_DIR` /sb$TMP_DIR
  cp -a $1 /sb$1
fi
