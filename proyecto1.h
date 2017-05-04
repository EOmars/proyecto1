
extern int yylineno;
void yyerror(char *s, ...);

/*estructura para tabla de simbolos*/
struct symbol
{
	char *name;
	double value;
	struct ast *func;	//declaracion de funcion
	struct symlist *syms; //argumentos
};

/* tabla de simbolos */
#define NHASH 997
struct symbol symtab[NHASH];

struct symbol *lookup(char *);

/* lista de simbolos para los argumentos */
struct symlist {
	struct symbol *sym;
	struct symlist *next;
};

/* nueva lista de simbolos */
struct symlist *newsymlist(struct symbol *sym, struct symlist *next);

/* liberar lista de simbolos */
void symlistfree(struct symlist *sl);

/**
* TIPO DE NODOS
* + - * / | 
* 0-7 operaciones de comparacion
* M operador - unario
* L expression o statement list
* I IF THEN ELSE
* W WHILE 
* N simbolo
* = asignacion
* S lista de simbolos
* F funcion
* C llamada a funcion
* K NUMBER
*/

/* funciones predefinidas */
enum bifs{
	B_sqrt = 1, B_exp, B_log, B_print
};

/* definicion del AST */
struct ast{
	int nodetype;
	struct ast *l;
	struct ast *r;
};


/* nodo tipo F */
struct fncall {
	int nodetype;
	struct ast *l;
	enum bifs functype;
};

/* nodo tipo C */
struct ufncall{
	int nodetype;
	struct ast *l;
	struct symbol *s;
};

/* nodo tipo I, W */
struct flow{
	int nodetype;
	struct ast *cond;
	struct ast * tl;
	struct ast *el;
};

/* nodo tipo K */
struct numval{
	int nodetype;
	double number;
};

/* nodo tipo N */
struct symref{
	int nodetype;
	struct symbol *s;
};

/* nodo asignacion */
struct symasgn{
	int nodetype;
	struct symbol *s;
	struct ast *v;
};

/* construccion AST */
struct ast *newast(int nodetype,struct ast *l,struct ast *r);
struct ast *newcmp(int cmptype, struct ast *l, struct ast *r);
struct ast *newfunc(int functype, struct ast *l);
struct ast *newcall(struct symbol *s, struct ast *l);
struct ast *newref(struct symbol *s);
struct ast *newasgn(struct symbol *s, struct ast *v);
struct ast *newnum(double d);
struct ast *newflow(int nodetype, struct ast *cond, struct ast *tl, struct ast *tr);

/* definicion de funcion */
void def_func(struct symbol *name, struct symlist *syms, struct ast *stmts);

/* interprete de AST */
double eval(struct ast *);

/* elimiar AST */
void treefree(struct ast *);

extern int yylineno;
void yyerror(char *s, ...);