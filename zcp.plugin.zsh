zcp() {

    local SIZE_SOURCE_KILOBYTE=888 #$(du -s "$1" | awk '{print $1}')
    local SOURCES=${@:1:#-1} # Remove the last argument
    local TARGET=${@:$#}
    local NUMBER_FILES=4 #$(ls -1 "$1" | wc -l)
    count=0
    echo "SIZE_SOURCE_KILOBYTE: $SIZE_SOURCE_KILOBYTE"
    echo "NUMBER_FILES: $NUMBER_FILES"
    echo "SOURCES: $SOURCES"
    echo "TARGET: $TARGET"
    strace -q \cp -r $SOURCES $TARGET 2>&1 | awk '{
        # Check if "openat" is in the line
        if (match($0, /openat/)) {
            print "-----Begin-------"
            print $0
            if (match($0,/O_WRONLY/)) {
                printf "openat write \n"
            }
            else if (match($0,/O_RDONLY/)) {
                printf "openat read \n"
            }
            print "----count-----"
            print $NF
            print "------End-------"
        }
        #Check if "write in the line
        else if (match($0, /write/)) {
            print "-----Begin-------"
            print $0
            printf "simple write\n"
            print "----count-----"
            print $NF
            print "------End-------"
        }
    }'

}

RESOURCES="test_resources/"
SOURCE="$RESOURCES""few_files/"
TARGET="$RESOURCES""target/"
rm -rf $TARGET
mkdir $TARGET
zcp $SOURCE $TARGET

