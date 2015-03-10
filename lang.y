/* lang.y */

%{
#include <iostream>
#include "cSymbol.h"
#include "cSymbolTable.h"
#include "lex.h"
%}

%locations

// define semantic value type
%union{
    int             int_val;
    double          float_val;
    cSymbol*        symbol;
    cSymbolTable*   sym_table;
    void*           ast_node;
    }

%{
    int yyerror(const char *msg);

    void *yyast_root;
%}

// Define start symbol
%start  program

// define token types that have an associated semantic value
%token <symbol>     IDENTIFIER
%token <int_val>    INT_VAL
%token <float_val>  FLOAT_VAL

// define token types that don't have a semantic value
%token  SCAN PRINT
%token  WHILE IF ELSE JUNK_TOK
%token  STRUCT
%token  RETURN_TOK
%token  CHAR INT FLOAT
%token  JUNK_TOKEN

%type <ast_node> program
%type <ast_node> block
%type <sym_table> open
%type <sym_table> close
%type <ast_node> decls
%type <ast_node> decl

%%

program: block                  {
                                  if (yynerrs == 0) 
                                      YYACCEPT;
                                  else
                                      YYABORT;
                                }
        | /* empty */           { YYACCEPT; }
block:   open decls close       {}

open:   '{'                     { 
                                    symbolTableRoot->IncreaseScope();
                                    $$ = NULL; // probably want to change this
                                }

close:  '}'                     {  
                                    symbolTableRoot->DecreaseScope();
                                    $$ = NULL; // might want to change this
                                }

decls:      decls decl          {}
        |   decl                {}

decl:       IDENTIFIER ';'      { std::cout << $1->toString() << "\n"; }
        |   block               {}
%%

int yyerror(const char *msg)
{
    std::cerr << "ERROR: " << msg << " at symbol "
        << yytext << " on line " << yylineno << "\n";

    return 0;
}