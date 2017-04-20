
%{
#include <stdio.h>
%}

%token BEGIN END
%token SEMI_COLON
%token IF THEN ELSE
%token LESS_THAN GREATER_THAN
%token ASSIGN ID

%token OPEN_PARENTHESIS CLOSE_PARENTHESIS
%token NUMBER
%token ADD SUB MUL DIV ABS
%start pakaBelial

%%

pakaBelial: BEGIN statements END
	;

statements: statement
	| statement SEMI_COLON statements;
	;

statement: if_else
	| assignment
	| pakaBelial
	;

if_else: IF condition THEN statement ELSE statement
	;

assignment: ID ASSIGN expr
	;

condition: expr relop expr
	;

relop: LESS_THAN
	| GREATER_THAN
	;

expr: arit_expr SEMI_COLON { printf("=%d\n", $1);}
	;


arit_expr: factor 
	| expr ADD factor { $$ = $1 + $3; }
	| expr SUB factor { $$ = $1 - $3; }
	;

factor: term 
	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
	;

term: NUMBER
	| OPEN_PARENTHESIS expr CLOSE_PARENTHESIS { $$ = $2;}
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