#! /usr/bin/env zsh

TEST_RESOURCES="test_resources/"

#Plot time comparison between zcp and cp
plot_comparison() {
    TIME_ZCP=$1
    TIME_CP=$2
    NAME=$3

    #Display a nice comparison 
    #In Yellow
    echo -e "\e[33m zcp: $TIME_ZCP s \e[0m"
    #In Red
    echo -e "\e[31m cp: $TIME_CP s \e[0m"
    echo
}

run_test() {
    SOURCE=$1
    TARGET=$2

    # In green
    echo -e "\e[32m $SOURCE \e[0m"
    rm -fr $TARGET
    START_ZCP=$(date +%s.%N)
    zsh zcp_copy.zsh $SOURCE $TARGET
    END_ZCP=$(date +%s.%N)
    TIME_ZCP=$((END_ZCP-START_ZCP))
    rm -fr $TARGET
    START_CP=$(date +%s.%N)
    cp -r $SOURCE $TARGET
    END_CP=$(date +%s.%N)
    TIME_CP=$((END_CP-START_CP))
    plot_comparison $TIME_ZCP $TIME_CP $SOURCE
}

test_single_file() {
    SOURCE=$TEST_RESOURCES"single_file/"
    TARGET=$TEST_RESOURCES"single_file_target/"
    #In blue
    run_test $SOURCE $TARGET
}
test_few_files() {
    SOURCE=$TEST_RESOURCES"few_files/"
    TARGET=$TEST_RESOURCES"few_files_target/"
    #In blue
    run_test $SOURCE $TARGET

}

test_huge_files() {
    SOURCE=$TEST_RESOURCES"huge_files/"
    TARGET=$TEST_RESOURCES"huge_files_target/"
    mkdir -p $SOURCE
    #In blue
    run_test $SOURCE $TARGET
}

test_lot_of_files() {
    SOURCE=$TEST_RESOURCES"lot_of_files/"
    TARGET=$TEST_RESOURCES"lot_of_files_target/"
    #In blue
    run_test $SOURCE $TARGET
}

main() {
    #test_single_file
    #test_few_files
    #test_huge_files
    
    test_lot_of_files

}

cp ./zcp.plugin.zsh zcp_copy.zsh
echo 'zcp $@' >> zcp_copy.zsh
main
