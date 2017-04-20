%option noyywrap
%{
#include "parser.tab.h"
%}
%%
"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"|" { return ABS; }
"(" { return OPEN_PARENTHESIS; }
")" { return CLOSE_PARENTHESIS; }
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n { return EOL; }
[ \t] { }
. { printf("Sweet Jesus! I've found a mystery character %c\n",*yytext); }
%%

