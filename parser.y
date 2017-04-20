
%{
#include <stdio.h>
%}

%token NUMBER
%token ADD SUB MUL DIV LEFT_ROUND_BRACKET RIGHT_ROUND_BRACKET
%token EOL
%start aritmExpr

%%

aritmExpr: expr EOL { printf("= %d\n", $2); }
	;

expr: term expr1 
	;

expr1:
	| ADD term expr1 { $$ = $2 + $3; }
	| SUB term expr1 { $$ = $2 - $3; }
	;

term: factor term1
	;

term1: 
	| MUL factor term1 { $$ = $2 * $3; }
	| DIV factor term1 { $$ = $2 / $3; }
	;

factor: LEFT_ROUND_BRACKET expr RIGHT_ROUND_BRACKET { $$ = $2; }
	| NUMBER
	;
%%

main(int argc, char **argv)
{
	yyparse();
}

yyerror(char *s)
{
	fprintf(stderr, "error: %s\n",s);
}