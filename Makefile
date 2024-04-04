.PHONY:clean
lexer:lexer.l
	flex -o build/lex.yy.c lexer.l
	gcc -o build/lexer build/lex.yy.c
clean:
	rm build/lexer build/lex.yy.c
