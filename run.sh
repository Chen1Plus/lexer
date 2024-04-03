flex -o build/lex.yy.c lexer.l
gcc build/lex.yy.c -o build/lexer.out

./build/lexer.out < input.c

