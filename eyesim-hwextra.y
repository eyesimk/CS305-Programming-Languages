%{
#include <stdio.h>
void yyerror(const char * msg) {
 printf("");
}

%} 

%token tINTTYPE tIDENT tINTNUM tAND tOR tSEMICOLON tSTRINGTYPE tSTRINGVAL tINTVAL

%start prog

%left tLT tLTE tGT tGTE tNE tEQ

%%


prog		: statementList 
; 

statementList	: statementList statement
             	| statementList tSEMICOLON
		| 
; 

statement	: asgn 
		| functionDefiniton
		| decl
		| print
; 

binaryOp: '*' | '+'| '-'| '/'| '%'
;

functionCall: tIDENT "(" vars ")"
;

functionDefiniton: type tIDENT "(" vars ")" "{" functionBody "}"
;

functionBody: decl functionBody 
            | asgn functionBody
            | print functionBody
            | return
;

return: "return" expr ";"

decl:	type vars '=' expr ';'
;
asgn:	vars '=' expr  ';'
;

print: "print" "(" expr ")" ";"

type:	tINTTYPE | tSTRINGTYPE
;

vars: tIDENT | vars ',' tIDENT
;
expr:  value | functionCall | expr binaryOp expr
;

value: tIDENT | tINTVAL | tSTRINGVAL
;



%% 

int main () {

  if(yyparse()) {
    printf("ERROR \n");
  }

  else {
    printf("OK \n");
  }
}
