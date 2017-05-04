
%{
#include <stdio.h>
#include <stdlib.h>
#include "proyecto1.h"
%}

%union {
	struct ast *a;
	double d;
	struct symbol *s; //simbolo
	struct symlist *sl;
	int fn; //tipo de funcion predefinida
}

/* tokens */
%token <d> NUMBER;
%token <s> NAME;
%token <fn> FUNC;
%token EOL


%token IF THEN ELSE WHILE DO FUNCTION


/* precedencia explicita */
%nonassoc <fn> CMP
%right '='
%left '+' '-'
%left '*' '/'
%nonassoc '|' UMINUS

%type <a> exp stmt stmt_list explist
%type <sl> symlist

%start pakaBelial

%%

pakaBelial: 
	| pakaBelial stmt EOL {
		printf("=%4.4g\n> ", eval($2));
		treefree($2);				
		}
	| pakaBelial FUNCTION NAME '(' symlist ')' '=' stmt_list EOL {
		def_fun($3,$5,$8);
		printf("Funcion %s definida\n> ",$3->name); 
	} 
	
	;

stmt: IF exp THEN stmt_list					{ $$ = newflow('I',$2,$4,NULL); }
	| IF exp THEN stmt_list ELSE stmt_list	{ $$ = newflow('I',$2,$4,$6); }
	| WHILE exp DO stmt_list 				{ $$ = newflow('W',$2,$4,NULL); }
	;

stmt_list: /* vacio */ { $$ = NULL; }
	| stmt ';' stmt_list {	if($3 == NULL)
								$$ = $1;
							else
								$$ = newast('L',$1,$3);
						}
	;

exp:  exp CMP exp 		{ $$ = newcmp($2, $1, $3); }
	| exp '+' exp 		{ $$ = newast('+', $1,$3); }
	| exp '-' exp 		{ $$ = newast('-', $1,$3); }
	| exp '*' exp 		{ $$ = newast('*', $1,$3); }
	| exp '/' exp 		{ $$ = newast('/', $1,$3); }
	| '|' exp 			{ $$ = newast('|', $2, NULL); }
	| '(' exp ')' 		{ $$ = $2; }
	| '-' exp %prec 	UMINUS{ $$ = newast('M', $2, NULL); }
	| NUMBER 			{ $$ = newnum($1); }
	| NAME 				{ $$ = newref($1); }
	| NAME '=' exp 		{ $$ = newasgn($1,$3); }
	| FUNC '(' explist ')' { $$ = newfunc($1,$3); }
	| NAME '(' explist ')' { $$ = newcall($1,$3); }
	;

explist: exp
	| exp ',' explist {$$ = newast('L',$1,$3); }
	;

symlist: NAME 	{ $$ = newsymlist($1,NULL); }
	| NAME ',' symlist { $$ = newsymlist($1,$3); }
	;


%%