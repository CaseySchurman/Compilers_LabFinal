// Main routine for lang compiler.
// This version only runs the lexer
//

%{
#include <iostream>
#include "lex.h"
%}

%locations

%union
    {
        int     int_val;
    }
%{
    int yyerror(const char *msg);
%}

%start  program

%token <int_val>    INT_VAL

%token  PRINT
%token  END
%token  OPERATOR
%token  IDENTIFIER
%token  JUNK_TOKEN

//Need to declare types for non-terminals below, don't know what to make them,
//can't be cAstNode's.


%%
program:    stmts END ';'       {
                                    //$$ = $1;
                                    //yyast_root = $$;
                                    //if (yynerrs == 0) 
                                    //  YYACCEPT;
                                    //else
                                    //  YYABORT;
                                }

stmts:  stmts stmt              {}
        |   stmt                {}

stmt:   expr PRINT              {}
        
id:     expr IDENTIFIER         {}

expr:   INT_VAL                 {}
        |   expr expr OPERATOR  {}
        |   id                  {}
        
%%

int yyerror(const char *msg)
{
    std::cerr << "ERROR: " << msg << " at symbol "
        << yytext << " on line " << yylineno << "\n";

    return 0;
}
