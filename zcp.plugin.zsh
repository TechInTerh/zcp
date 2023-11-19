zcp() {

    local SIZE_SOURCE_KILOBYTE=$(du -S -b "$1" | cut -f1)
    local SOURCES=${@:1:#-1} # Remove the last argument
    local TARGET=${@:$#}
    local NUMBER_FILES=4 #$(ls -1 "$1" | wc -l)
    count=0
    echo "SIZE_SOURCE_KILOBYTE: $SIZE_SOURCE_KILOBYTE"
    echo "NUMBER_FILES: $NUMBER_FILES"
    echo "SOURCES: $SOURCES"
    echo "TARGET: $TARGET"
    strace -q \cp -r $@ 2>&1 | awk '{
        #Check if "write in the line
        if (match($0, /write/)) {
            print $NF
        }
        sleep 1
    }'| tqdm --update --null --unit_scale --unit-divisor=1024  --unit=B --total $SIZE_SOURCE_KILOBYTE 
}

RESOURCES="test_resources/"
SOURCE="$RESOURCES""huges_files/"
TARGET="$RESOURCES""target/"
rm -rf $TARGET
mkdir $TARGET
zcp $SOURCE $TARGET

