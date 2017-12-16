#!/bin/sh

EXCHANGE_PATH=/exchange

if [ -d "/exchange/init.d" ]
then
  for f in /exchange/init.d/*; do
      case "$f" in
        */*.sh)     echo "$0: running init.d script $f"; . "$f" ;;
      esac
      echo
    done
fi
