%{
#include "easyCalc.tab.h"

/* Windows-specific adjustments */
#define YY_NO_UNISTD_H
#define YY_NO_INPUT
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
"+"         { return PLUS; }
"\n"        { return NEWLINE; }
[ \t]       ; /* Skip whitespace */
.           { printf("Unexpected character: %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
}