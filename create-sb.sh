#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXCLUDE="^\$|/\$|[.]wh[.][.]wh[.]orph/|^/[.]wh[.][.]wh[.]plnk/|^/[.]wh[.][.]wh[.]aufs|^/var/cache/|^/var/backups/|^/var/tmp/|^/var/log/|^/var/lib/apt/|^/var/lib/dhcp/|^/var/lib/systemd/|^/sbin/fsck[.]aufs|^/etc/resolv[.]conf|^/root/[.]Xauthority|^/root/[.]xsession-errors|^/root/[.]fehbg|^/root/[.]fluxbox/lastwallpaper|^/root/[.]fluxbox/menu_resolution|^/etc/mtab|^/etc/fstab|^/boot/|^/dev/|^/mnt/|^/proc/|^/run/|^/sys/|^/tmp/|^/exchange|^/helper|^/var/spool|^/etc/.pwd.lock|^/etc/X11/Xsession\.d"

EXCHANGE_DIR=$PWD

if [ ! "$1" = "" ]; then
   EXCHANGE_DIR="$( cd $1 && pwd )"
fi

MODULE_NAME="$( basename $EXCHANGE_DIR )"

if [ ! "$2" = "" ]; then
   MODULE_NAME="$2"
fi

echo "Start creating SB module '$MODULE_NAME' for your Slaxy-Distro"
docker run -d --name slaxy_sb -v $EXCHANGE_DIR:/exchange -v $DIR/helper:/helper slaxy/base tail -f /dev/null

docker exec -it slaxy_sb /helper/init.d-exec.sh

echo "Prepare the content of your SB module '$MODULE_NAME'"
CHANGES="$( docker diff slaxy_sb | awk '{print $2}' | egrep -v "$EXCLUDE" )"
echo "#!/bin/sh" > $DIR/helper/prepare-sb.sh

for CHANGE in $CHANGES
do
  echo "/helper/copy2sb.sh '$CHANGE'" >> $DIR/helper/prepare-sb.sh
done

chmod +x $DIR/helper/prepare-sb.sh
docker exec -it slaxy_sb /helper/prepare-sb.sh

echo "Building your SB module '$MODULE_NAME'"
docker exec -it slaxy_sb /helper/build-sb.sh "$MODULE_NAME.sb"

docker kill slaxy_sb
docker rm slaxy_sb
