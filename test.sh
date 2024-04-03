flex -o build/lex.yy.c lexer.l
gcc build/lex.yy.c -o build/lexer

NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'

run_test() {
    ./build/lexer < test/$1.c > build/test/$1.c.output

    DIFF=$(diff build/test/$1.c.output test/$1.c.expected) 
    if [ "$DIFF" = "" ]; then
        echo "Test: $1 -- ${GREEN}passed${NC}"
    else
        echo "Test: $1 -- ${RED}failed${NC}"
    fi
}

run_test float
