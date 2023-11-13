
# Check if "openat" is in the line
if (match($0, /openat/)) {
    if (match($0,O_WRONLY)) {
        printf "openat write \n"
    }
    else if (match($0,O_WRONLY)) {
        printf "openat read \n"
    }
}
#Check if "write in the line
else if (match($0, /write/)) {
    printf "write\n"
}