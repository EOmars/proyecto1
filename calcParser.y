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

%type <a> exp factor term

%%
calclist:
	| 	calclist exp EOL {
			printf("= %4.4g\n",eval($2));
			treeFree($2);
			printf("> ");
		}
	| calclist EOL { printf("> "); }
	| calclist EXIT { printf("bye ;)\n"); exit(0);}

exp: factor
	| exp '+' factor { $$ = newAst('+', $1,$3); }
	| exp '-' factor { $$ = newAst('-', $1,$3); }
	;

factor: term
	| factor '*' term { $$ = newAst('*', $1,$3); }
	| factor '/' term { $$ = newAst('/', $1,$3); }
	;

term: NUMBER { $$ = newNum($1); }
	| '|' term { $$ = newAst('|', $2, NULL); }
	| '(' exp ')' { $$ = $2; }
	| '-' term { $$ = newAst('M', $2, NULL); }
	;
%%

