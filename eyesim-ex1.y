%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define YYSTYPE int  /* one attribute associated with all symbols, the type is int */

void yyerror(const char * msg) 
{
  printf("");
}

int vars[100];
int entered = 0;
extern int lineNum;
extern int yylineno;
void varCheck(int, int);
int index = 0;
void enter();
void leave();

%} 

%token tINT tSTRING tINTVAL tSTRINGVAL tIDENT tLPAR tRPAR tCOMMA tMOD tASSIGNM tMINUS tPLUS tDIV tSTAR tSEMI tLBRAC tRBRAC tRETURN tPRINT

%left tASSIGNM       
%left tPLUS tMINUS   
%left tSTAR tDIV     
%left tLPAR tRPAR    
%left tLBRAC tRBRAC  


%start program


%%

program:    stmtList
;

function:     funcBody return
            | return
;

funcBody:       var
            |   asgn
            |   print 
;

stmtList:      stmtList statement 
            |  statement
;

statement:      funcDef
            |   var
            |   asgn
            |   print 
;

value:          tIDENT     {varCheck($1, 0);}    /* variable check with tIDENT's att.*/                                  
            |   tINTVAL
            |   tSTRINGVAL
;

valueList:    valueList tCOMMA value
            | value
;

paramList:    tLPAR parameters tRPAR 
             | tLPAR tRPAR             {enter();}
		
; 
                                                    
var :        type tIDENT tASSIGNM expr tSEMI  {varCheck($2,1);}	/* variable check with tIDENT's att.*/
;

type :           tINT
            |    tSTRING
;

bin:            tSTAR
            |   tPLUS
            |   tMOD
            |   tMINUS
            |   tDIV
;

expr :           expr bin expr                  
            |    funcCall
            |    value
;

funcCall:    tIDENT tLPAR valueList tRPAR
            | tIDENT tLPAR tRPAR
;

asgn :       tIDENT tASSIGNM expr tSEMI {varCheck($1,0);}   /* variable check with tIDENT's att.*/
;

funcDef:     type tIDENT paramList tLBRAC function tRBRAC
;


return:     tRETURN expr tSEMI      {leave();}
;

print: tPRINT tLPAR expr tRPAR tSEMI
;

parameters:      parameters tCOMMA type tIDENT     {varCheck($4,1);}
               | type tIDENT                       {enter(); 
                                                   varCheck($2,1);
                                                   }
;

parameter: type tIDENT
;

/*funcBody:     funcBody var 
            | funcBody asgn 
            | funcBody print 
            | asgn return
            | var return
            | print return
            
;*/

%%

void enter() 
{
	entered = 0;
}	

void leave() 
{
	int x = 0;

	while (x < entered) 
	{
		vars[index - 1] = NULL;
		index--;
		x++;
	}
}

void varCheck(int attrb, int num) 
{
	int undef = 0;
	int redef = 0;

	if(num == 0)
	{
		for (int x = 0; x < index; x++) 
		{
			int a = vars[i];
			if(a != attrb){
				undef = 1;
		}

		if (undef == 0) 
		{
			printf("%d Undefined variable \n",yylineno);
			exit(0);
		}
	}
	else if (num == 1) 
	{
		for (int x = 0; x < index; x++) 
		{
			int a = vars[i];
			if(a != attrb)
			{
				redef=1;
			}
		}

		if (redef == 1) 
		{
			printf("%d Redefinition of variable \n", yylineno);
			exit(0);
		}

		else
		{
			vars[index] = attrb;
			index++;
			entered++;	
		}
	}
}

int main ()
{
   if (yyparse()) {
   // parse error
       printf("ERROR\n");
       return 1;
   }
   else {
   // successful parsing
      printf("OK\n");
      return 0;
   }
}

