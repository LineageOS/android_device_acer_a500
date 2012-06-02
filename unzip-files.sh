#/bin/sh

VENDOR=acer
DEVICE=a500
UPDATE_PACKAGE=$1

if [ "x$UPDATE_PACKAGE" = "x" ]; then
    echo You must specify the update.zip as first argument
    exit
fi

OUTD=../../../vendor/$VENDOR/$DEVICE
PROPD=$OUTD/proprietary

[ ! -d $OUTD ] && mkdir -p $OUTD || rm -rf $OUTD/*

while read file; do
    dir=$PROPD/$(dirname $file)
    [ ! -d $dir ] && mkdir -p $dir
    unzip -j -o ${UPDATE_PACKAGE} system/$file -d $dir
done < proprietary-files.txt

./setup-makefiles.sh
