%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "t2c.h"
	#include "t_parse.h"
%}

%token lWRITE lREAD lIF lASSIGN
%token lRETURN lBEGIN lEND
%left  lEQU lNEQ lGT lLT lGE lLE
%left  lADD lMINUS
%left  lTIMES lDIVIDE
%token lLP lRP
%token lINT lREAL lSTRING
%token lELSE
%token lMAIN
%token lSEMI lCOMMA
%token lID lINUM lRNUM lQSTR

%expect 1

%%
prog	:	mthdcls
		{ printf("Program -> MethodDecls\n");
		  printf("Parsed OK!\n"); }
	|
		{ printf("****** Parsing failed!\n"); }	
	;

mthdcls	:	mthdcl mthdcls
		{ printf("MethodDecls -> MethodDecl MethodDecls\n"); }	
	|	mthdcl
		{ printf("MethodDecls -> MethodDecl\n"); }	
	;

type	:	lINT
		{ printf("Type -> INT\n"); }	
	|	lREAL
		{ printf("Type -> REAL\n"); }	
	;

mthdcl	:	type lMAIN lID lLP formals lRP block
		{ printf("MethodDecl -> Type MAIN ID LP Formals RP Block\n"); }	
	|	type lID lLP formals lRP block
		{ printf("MethodDecl -> Type ID LP Formals RP Block\n"); }	
	;

formals	:	formal oformal
		{ printf("Formals -> Formal OtherFormals\n"); }	
	|
		{ printf("Formals -> \n"); }	
	;

formal	:	type lID
		{ printf("Formal -> Type ID\n"); }	
	;

oformal	:	lCOMMA formal oformal
		{ printf("OtherFormals -> COMMA Formal OtherFormals\n"); }	
	|
		{ printf("OtherFormals -> \n"); }	
	;

// Statements and Expressions

//Statements

// Block
block :	lBEGIN stmts lEND
		{ printf("Block -> BEGIN Statements END\n"); }
	;

// Statements
stmts :	stmt ostmts
		{ printf("Statements -> Statement OtherStatements\n"); }
	;

//OtherStatments
ostmts :	stmts
		{ printf("OtherStatements -> Statements\n"); }
	|
		{ printf("OtherStatements -> \n"); }
	;

// Statement
stmt :	block
		{ printf("Statement -> Block\n"); }
	|	localvardcl
		{ printf("Statement -> LocalVarDecl\n"); }
	|	assignstmt
		{ printf("Statement -> AssignStmt\n"); }
	|	returnstmt
		{ printf("Statement -> ReturnStmt\n"); }
	|	ifstmt
		{ printf("Statement -> IfStmt\n"); }
	|	writestmt
		{ printf("Statement -> WriteStmt\n"); }
	|	readstmt
		{ printf("Statement -> ReadStmt\n"); }
	;

//LocalVarDecl
localvardcl :	type lID lSEMI
			{ printf("LocalVarDecl -> Type ID ;\n"); }
			|	type assignstmt
			{ printf("LocalVarDecl -> Type AssignStmt\n"); }
			;

// AssignStmt
assignstmt :	lID lASSIGN expr lSEMI
			{ printf("AssignStmt -> ID := Expression ;\n"); }
		;	
		
//ReturnStmt
returnstmt :	lRETURN expr lSEMI
			{ printf("ReturnStmt -> RETURN Expression ;\n"); }
		;

//IfStmt
ifstmt :	lIF lLP boolexpr lRP stmt
		{ printf("IfStmt -> IF ( BoolExpression ) Statement\n"); }
	|	lIF lLP boolexpr lRP stmt lELSE stmt
		{ printf("IfStmt -> IF ( BoolExpression ) Statement\n"); }
	;

//WriteStmt
writestmt :	lWRITE lLP expr lCOMMA lQSTR lRP lSEMI
			{ printf("WriteStmt -> WRITE ( Expression , QString ) ;\n"); }
		;

//ReadStmt
readstmt :	lREAD lLP lID lCOMMA lQSTR lRP lSEMI
			{ printf("ReadStmt -> READ ( ID , QString ) ;\n"); }
		;

//Expressions




%%

int yyerror(char *s)
{
	printf("%s\n",s);
	return 1;
}

