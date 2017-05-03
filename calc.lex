
%option noyywrap nodefault yylineno
%{
#include "astHeader.h"
#include "calcParser.tab.h"	
%}

EXP ([Ee][-+]?[0-9]+)

%%
"+" | 
"-" |
"*" |
"/" |
"|" |
"(" |
")"		{ return yytext[0]; }
[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER; }

\n { return EOL; }
"exit" { return EXIT; }
"//".*
[ \t] {}
. { yyerror("Caracter no reconocido %c\n", *yytext); }
%%
