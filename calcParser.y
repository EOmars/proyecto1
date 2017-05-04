%{
#include <stdio.h>
#include <stdlib.h>
#include "astHeader.h"	
%}

%union{
	struct ast *a;
	double d;
}

/* tokens */
%token <d> NUMBER
%token EOL
%token EXIT

/* precedencia explícita */
%left '+' '-'
%left '*' '/'
%nonassoc '|' UMINUS

%type <a> exp

%%
calclist:
	| 	calclist exp EOL {
			printf("= %4.4g\n",eval($2));
			treeFree($2);
			printf("> ");
		}
	| calclist EOL { printf("> "); }
	| calclist EXIT { printf("bye ;)\n"); exit(0);}
	;

exp: 	exp '+' exp 	{ $$ = newAst('+', $1,$3); }
	|	exp '-' exp 	{ $$ = newAst('-', $1,$3); }
	|	exp '*' exp 	{ $$ = newAst('*', $1,$3); }
	|	exp '/' exp 	{ $$ = newAst('/', $1,$3); }
	|	'|' exp 		{ $$ = newAst('|', $2, NULL); }
	|	'(' exp ')' 	{ $$ = $2; }
	| 	'-' exp %prec 	UMINUS{ $$ = newAst('M', $2, NULL); }
	|	NUMBER 			{ $$ = newNum($1); }
	;
%%

