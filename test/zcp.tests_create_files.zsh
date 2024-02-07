
#! /usr/bin/env zsh

TEST_RESOURCES="test_resources/"
#Write a file <$1> of size <$2>Mo 
write_random_file() {
    rm -fr $1
    dd if=/dev/urandom of=$1 bs=1M count=$2 > /dev/null 2>&1
}
write_single_file() {
    SOURCE=$TEST_RESOURCES"single_file/"
    rm -fr $SOURCE
    mkdir -p $SOURCE
    #In blue
    echo -e "\e[34m Writing Single File \e[0m"
    write_random_file $SOURCE"file1" 1
}

write_few_files() {

    SOURCE=$TEST_RESOURCES"few_files/"
    rm -fr $SOURCE
    mkdir -p $SOURCE
    #In blue
    echo -e "\e[34m Writing Few Files \e[0m"
    write_random_file $SOURCE"file1" 10
    write_random_file $SOURCE"file2" 20
    write_random_file $SOURCE"file3" 30
}

write_lot_of_files() {
    SOURCE=$TEST_RESOURCES"lot_of_files/"
    SOURCE_DIR1=$SOURCE"dir1/"
    SOURCE_DIR2=$SOURCE"dir2/"
    SOURCE_DIR3=$SOURCE"dir3/"
    rm -fr $SOURCE
    mkdir -p $SOURCE
    mkdir -p $SOURCE_DIR1
    mkdir -p $SOURCE_DIR2
    mkdir -p $SOURCE_DIR3
    #In blue
    echo -e "\e[34m Writing Lot of Files \e[0m"
    write_random_file $SOURCE"file1" 10
    write_random_file $SOURCE"file2" 20

    write_random_file $SOURCE_DIR1"file1" 10
    write_random_file $SOURCE_DIR1"file2" 20
    write_random_file $SOURCE_DIR1"file3" 30
    write_random_file $SOURCE_DIR1"file4" 40

    write_random_file $SOURCE_DIR2"file1" 10
    write_random_file $SOURCE_DIR2"file2" 20
    write_random_file $SOURCE_DIR2"file3" 30
    write_random_file $SOURCE_DIR2"file4" 40
    write_random_file $SOURCE_DIR2"file5" 50

    write_random_file $SOURCE_DIR3"file1" 10
    write_random_file $SOURCE_DIR3"file2" 20
    write_random_file $SOURCE_DIR3"file3" 30
    write_random_file $SOURCE_DIR3"file4" 40
    write_random_file $SOURCE_DIR3"file5" 50
    write_random_file $SOURCE_DIR3"file6" 60

}

write_huge_files() {
    SOURCE=$TEST_RESOURCES"huge_files/"
    rm -fr $SOURCE
    mkdir -p $SOURCE
    #In blue
    echo -e "\e[34m Writing Huge Files \e[0m"
    write_random_file $SOURCE"file1" 500
    write_random_file $SOURCE"file2" 1000
}

main() {
    write_few_files
    write_huge_files
    write_lot_of_files
    write_single_file
    touch "$TEST_RESOURCES"test_check.txt
}

main
