
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "astHeader.h"

struct ast *
newAst(int nodeType, struct ast *l, struct ast *r)
{
	struct ast *a = malloc(sizeof(struct ast));
	if(!a){
		yyerror("No hay espacio para ast");
		exit(0);
	}
	a->nodeType = nodeType;
	a->l = l;
	a->r = r;
	return a;
}

struct ast *
newNum(double d){
	struct numVal *a = malloc(sizeof(struct numVal));
	if(!a) {
		yyerror("No hay espacio para estructura numVAl");
		exit(0);
	}
	a->nodeType = 'K';
	a->number = d;
	return (struct ast *)a; 
}

double eval(struct ast *a){
	double v; //valor del subarbol

	switch(a->nodeType){
		case 'K': v = ((struct numVal*)a)->number; break;
		case '+': v = eval(a->l) + eval(a->r); break;
		case '-': v = eval(a->l) - eval(a->r); break;
		case '*': v = eval(a->l) * eval(a->r); break; 
		case '/': v = eval(a->l) / eval(a->r); break;
		case '|': v = eval(a->l); if(v<0) v= -v; break;
		case 'M': v = -eval(a->l); break;
		default: printf("Error fatal. Nodo malformado %c\n",a->nodeType);
	}
	return v;
}

void treeFree(struct ast *a){
	switch(a->nodeType){
		case '+': 
		case '-':
		case '*':
		case '/':
			treeFree(a->r);

		case '|':
		case 'M':
			treeFree(a->l);

		case 'K':
			free(a);
			break;
		default: printf("Error fatal. Nodo malformado %c\n",a->nodeType);
	}
}


void yyerror(char *s, ...){
	va_list ap;
	va_start(ap,s);

	fprintf(stderr, "%d: error\n", yylineno );
	vfprintf(stderr,s,ap);
	fprintf(stderr,"\n");
}

int main(){
	printf("> ");
	return yyparse();
}