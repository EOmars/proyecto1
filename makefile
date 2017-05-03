

proyecto: calc.lex calcParser.y astHeader.h
	bison -d calcParser.y
	flex  calc.lex
	gcc -o $@ calcParser.tab.c lex.yy.c ast.c

clean: 
	rm calcParser.tab.c calcParser.tab.h lex.yy.c proyecto