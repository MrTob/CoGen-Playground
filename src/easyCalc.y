%{
#include <stdio.h>
void yyerror(const char *s);
int yylex(void);
%}

%token NUMBER
%token PLUS
%token NEWLINE

%%
program:
    | program line
    ;

line:
    expr NEWLINE    { printf("Result: %d\n", $1); }
    ;

expr:
    NUMBER          { $$ = $1; }
    | expr PLUS NUMBER { $$ = $1 + $3; }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Enter calculations (e.g., '5 + 3'). Press Ctrl+C to exit.\n");
    yyparse();
    return 0;
}