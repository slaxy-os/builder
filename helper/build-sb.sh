#!/bin/sh

mkdir -p /exchange/dist
mksquashfs "/sb" "/exchange/dist/$1" -comp xz -b 512K -noappend