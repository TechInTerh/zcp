#! /usr/bin/env zsh
zcp() {

    local SIZE_SOURCE=$(du -S -b "$1" | cut -f1)
    local SOURCES=${@:1:#-1} # Remove the last argument
    local TARGET=${@:$#}
    #local NUMBER_FILES=$(ls -1 "$1" | wc -l)
    count=0
    strace -q \cp -r $@ 2>&1 | awk '{
        #Check if "write in the line
        if (match($0, /write/)) {
            print $NF
        }
    }'| tqdm --update --null --unit_scale --unit-divisor=1024  --unit=B --total $SIZE_SOURCE 
}
