

proyecto: lexer.lex parser.y
	bison -d parser.y
	flex lexer.lex
	gcc -o $@ parser.tab.c lex.yy.c

clean: 
	$(RM) *.c *.h $@