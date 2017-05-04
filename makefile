

proyecto: lexer.lex parser.y proyecto1.h
	bison -d parser.y
	flex  lexer.lex
	gcc -o $@ parser.tab.c lex.yy.c proyecto1.c

clean: 
	rm  *.tab.h *.tab.c lex.yy.c proyecto