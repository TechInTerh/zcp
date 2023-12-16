
#! /usr/bin/env zsh

ZCP="zsh zcp.plugin.zsh"
TEST_RESOURCES="test_resources/"
#Write a file <$1> of size <$2>Mo 
write_random_file() {
    rm -fr $1
    dd if=/dev/urandom of=$1 bs=1M count=$2 > /dev/null 2>&1
}

write_few_files() {

    SOURCE=$TEST_RESOURCES"few_files/"
    TARGET=$TEST_RESOURCES"few_files_target/"
    mkdir -p $SOURCE
    #In blue
    echo -e "\e[34m Writing Few Files \e[0m"
    write_random_file $SOURCE"file1" 10
    write_random_file $SOURCE"file2" 20
    write_random_file $SOURCE"file3" 30
}

write_huge_files() {
    SOURCE=$TEST_RESOURCES"huge_files/"
    TARGET=$TEST_RESOURCES"huge_files_target/"
    mkdir -p $SOURCE
    #In blue
    echo -e "\e[34m Writing Huge Files \e[0m"
    write_random_file $SOURCE"file1" 1000
    write_random_file $SOURCE"file2" 2000
}

main() {
    write_few_files
    write_huge_files
    touch "$TEST_RESOURCES"test_check.txt
}

main