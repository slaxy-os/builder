#!/bin/sh

BASE_DIR=$PWD
if [ ! "$1" = "" ]; then
   BASE_DIR="$( cd $1 && pwd )"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p dist/
cp -Rf $DIR/slax-src/* dist/

for f in $BASE_DIR/modules/*; do
  $DIR/create-sb.sh $f
  cp $f/dist/* $DIR/dist/slax/
done

if [ -f "$BASE_DIR/bootlogo.png" ]
then
  cp $BASE_DIR/bootlogo.png dist/bootlogo.png
fi
