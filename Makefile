ZSH = zsh
TEST_CHECK= test_resources/test_check.txt
all : $(TEST_CHECK) test

$(TEST_CHECK) : 
	$(ZSH) "test/zcp.tests_create_files.zsh"

test : FORCE
	$(ZSH) "test/zcp.tests.zsh"

FORCE: ;