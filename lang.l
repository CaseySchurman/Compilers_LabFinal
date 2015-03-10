%{
// Calc Parser
// Casey Schurman

#include "lex.h"

#define RETURN(a) return Return(a);
static int Return(int val);

%}

%option noyywrap
%option nounput
%option yylineno


whitespace      [' ''\t''\n']
operator        [+\-*/=]
integer         -?0|(-?[1-9][0-9]*)
identifier	    [a-zA-Z]*
%%

"//"(.)+$                   {}
{whitespace}+               {}
{operator}                  RETURN(yytext[0]);
"print"                     RETURN(PRINT);
"end"                       RETURN(END);
{integer}                   {
                                RETURN(INT_VAL);
                            }
{identifier}                RETURN(IDENTIFIER);

%%

static int Return(int val)
{
    //printf("Scanned '%s': %d\n", yytext, val);
    return val;
}
