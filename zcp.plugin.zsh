zcp() {

    local SIZE_SOURCE=$(du -S -b "$1" | cut -f1)
    local SOURCES=${@:1:#-1} # Remove the last argument
    local TARGET=${@:$#}
    local NUMBER_FILES=4 #$(ls -1 "$1" | wc -l)
    count=0
    echo "SIZE_SOURCE: $SIZE_SOURCE"
    echo "NUMBER_FILES: $NUMBER_FILES"
    echo "SOURCES: $SOURCES"
    echo "TARGET: $TARGET"
    strace -q \cp -r $@ 2>&1 | awk '{
        #Check if "write in the line
        if (match($0, /write/)) {
            print $NF
        }
    }'| tqdm --update --null --unit_scale --unit-divisor=1024  --unit=B --total $SIZE_SOURCE 
}

RESOURCES="test_resources/"
SOURCE="$RESOURCES""huges_files/"
TARGET="$RESOURCES""target/"
rm -rf $TARGET
mkdir $TARGET
zcp $SOURCE $TARGET

