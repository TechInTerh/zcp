ZSH = zsh
TEST_RESOUCES = test_resources
TEST_CHECK= test_resources/test_check.txt
all : $(TEST_CHECK) test

$(TEST_CHECK) : 
	$(ZSH) "test/zcp.tests_create_files.zsh"

test : FORCE
	$(ZSH) "test/zcp.tests.zsh"

view : $(TEST_CHECK)
	rm -fr $(TEST_RESOUCES)/single_file_target
	$(ZSH) "zcp.plugin.zsh" $(TEST_RESOUCES)/single_file $(TEST_RESOUCES)/single_file_target

FORCE: ;
