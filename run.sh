rm build/lexer
rm build/lex.yy.c

flex -o build/lex.yy.c lexer.l
gcc build/lex.yy.c -o build/lexer

./build/lexer < input.c

