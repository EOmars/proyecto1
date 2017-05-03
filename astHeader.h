
extern int yylineno;

void yyerror(char *s, ...);

/** estructura de un ast **/
struct  ast
{
	int nodeType;
	struct ast *l;
	struct ast *r;
};

struct numVal{
	int nodeType;
	double number;
};

/** construccion ast **/
struct ast *newAst(int nodeType, struct ast *l, struct ast *r);
struct ast *newNum(double d);

/** evaluacion ast **/
double eval(struct ast *);

/** eliminar ast **/
void treeFree(struct ast *);




