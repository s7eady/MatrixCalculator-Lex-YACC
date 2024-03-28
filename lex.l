%{
	#include<stdio.h>
	#include<stdlib.h>
	#include "y.tab.h"
%}

%%
[a-z]		{ yylval = *yytext - 'a'; return VARIABLE; }
[0-9][0-9]*	{ yylval = atoi(yytext); return INTEGER; }
[-+*\n]	{ return *yytext; }
"matrix"	{ return MATRIX; }
"set"		{ return SET; }
"show"		{ return SHOW; }
"det"		{ return DET; }
"transpose"	{ return TRANSPOSE; }
"inverse"	{ return INVERSE; }
"help"		{ return HELP; }
[ \t]		;
.		yyerror("Undefined character");
%%

int yywrap() {
	return 1;
}
