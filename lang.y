/* lang.y */

%{
#include <iostream>
#include "lex.h"
%}

%locations

// define semantic value type
%union{
    int             int_val;
    }

%{
    int yyerror(const char *msg);

    void *yyast_root;
%}

// Define start symbol
%start  program

// define token types that have an associated semantic value
%token <int_val>    INT_VAL

// define token types that don't have a semantic value
%token  PRINT
%token  END
%token  OPERATOR
%token  IDENTIFIER
%token  JUNK_TOKEN

%type <ast_node> program
%type <ast_node> stmts
%type <sym_table> stmt
%type <sym_table> expr

%%

program: stmts                  {}

stmts:   stmts stmts            {}
      |  stmt                   {}
      
stmt:   expr IDENTIFIER         {}
      | expr PRINT              {}
      | expr END                {}
      
expr:   INT_VAL                 {}
      | IDENTIFIER              {}
      | expr expr OPERATOR      {}

%%
