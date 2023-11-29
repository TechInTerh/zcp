#! /usr/bin/env zsh

ZCP="zsh zcp.plugin.zsh"
TEST_RESOURCES="test_resources/"
#Write a file <$1> of size <$2>Mo 
write_random_file() {
    rm -fr $1
    dd if=/dev/urandom of=$1 bs=1M count=$2 > /dev/null 2>&1
}

#Plot time comparison between zcp and cp
plot_comparison() {
    TIME_ZCP=$1
    TIME_CP=$2
    NAME=$3

    #Display a nice comparison 
    # In green
    echo -e "\e[32m $NAME \e[0m"
    #In Yellow
    echo -e "\e[33m zcp: $TIME_ZCP s \e[0m"
    #In Red
    echo -e "\e[31m cp: $TIME_CP s \e[0m"
    echo
}

run_test() {
    SOURCE=$1
    TARGET=$2

    rm -fr $TARGET
    START_ZCP=$(date +%s.%N)
    zsh zcp.plugin.zsh $SOURCE $TARGET
    END_ZCP=$(date +%s.%N)
    TIME_ZCP=$((END_ZCP-START_ZCP))
    rm -fr $TARGET
    START_CP=$(date +%s.%N)
    cp -r $SOURCE $TARGET
    END_CP=$(date +%s.%N)
    TIME_CP=$((END_CP-START_CP))
    plot_comparison $TIME_ZCP $TIME_CP $SOURCE
}


test_few_files() {
    SOURCE=$TEST_RESOURCES"few_files/"
    TARGET=$TEST_RESOURCES"few_files_target/"
    mkdir -p $SOURCE
    #In blue
    echo -e "\e[34m Writing Few Files \e[0m"
    write_random_file $SOURCE"file1" 10
    write_random_file $SOURCE"file2" 20
    write_random_file $SOURCE"file3" 30
    run_test $SOURCE $TARGET

}

test_huge_files() {
    SOURCE=$TEST_RESOURCES"huge_files/"
    TARGET=$TEST_RESOURCES"huge_files_target/"
    mkdir -p $SOURCE
    #In blue
    echo -e "\e[34m Writing Huge Files \e[0m"
    write_random_file $SOURCE"file1" 1000
    write_random_file $SOURCE"file2" 2000
    write_random_file $SOURCE"file3" 3000
    run_test $SOURCE $TARGET
}

prepare_folder() {
    mkdir -p "$TEST_RESOURCES"
}

main() {
    prepare_folder
    test_few_files
    test_huge_files

}

main