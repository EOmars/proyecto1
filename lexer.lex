%option noyywrap
%{
#include "parser.tab.h"
%}
%%
";"  { return SEMI_COLON; }
"=" { return ASSIGN; }
"<" { return LESS_THAN; }
">" { return GREATER_THAN; }
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"(" { return OPEN_PARENTHESIS; }
")" { return CLOSE_PARENTHESIS; } 
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
"begin" {return BEGIN; }
"end" { return END; }
"if" { return  IF; }
"then" { return THEN; }
"else" { return ELSE; }
[a-zA-Z] { yylval = yytext; return ID; }
[ \t\n] { }
. { printf("Sweet Jesus! I've found a mystery character %c\n",*yytext); }
%%

