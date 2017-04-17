%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
void ThreeAddressCode();
void triple();
void qudraple();
char AddToTable(char ,char, char);

int ind=0;
char temp='A';
struct incod
{
char opd1;
char opd2;
char opr;
char result;
};
%}

%union
{
char sym;
}

%token <sym> LETTER NUMBER
%type <sym> expr
%left '-''+'
%right '*''/'
%%

statement: LETTER '=' expr ';' {AddToTable((char)$1,(char)$3,'=');}
| expr ';'
;

expr: expr '+' expr {$$ = AddToTable((char)$1,(char)$3,'+');}
| expr '-' expr {$$ = AddToTable((char)$1,(char)$3,'-');}
| expr '*' expr {$$ = AddToTable((char)$1,(char)$3,'*');}
| expr '/' expr {$$ = AddToTable((char)$1,(char)$3,'/');}
| '(' expr ')' {$$ = (char)$2;}
| NUMBER {$$ = (char)$1;}
| LETTER {$$ = (char)$1;}
;

%%

yyerror(char *s)
{
	printf("%s",s);
	exit(0);
}

struct incod code[20];
int id=0;

char AddToTable(char opd1,char opd2,char opr)
{
	
	code[ind].opd1=opd1;
	code[ind].opd2=opd2;
	
	code[ind].opr=opr;
	code[ind].result=temp;
	ind++;
	temp++;
	return code[ind].result;
}

void ThreeAddressCode()
{
	int cnt=0;
	char t='A';
	printf("\n\n\t THREE ADDRESS CODE\n\n");
	while(cnt<ind)
	{
		if(code[cnt].opr=='=')
		{
			printf("%c = \t",code[cnt].opd1);
			
			printf("%c\n",code[cnt-1].result);
		}
		else
		{
			printf("%c = \t",code[cnt].result);
			if(isalpha(code[cnt].opd1))
				printf("%c\t",code[cnt].opd1);
			else
				printf("%c\t",t++);
			
			printf("%c\t",code[cnt].opr);
			if(isalpha(code[cnt].opd2))
				printf("%c\t",code[cnt].opd2);
			else
				printf("%c\t",t++);
			printf("\n");
		}
		cnt++;
	}
}

void quadraple()
{
	int cnt=0;
	char t='A';
	printf("\n\n\t QUADRAPLE ADDRESS CODE\n\n");
	while(cnt<ind)
	{
		printf("%c\t",code[cnt].opr);
		if(code[cnt].opr=='=')
		{
			
			printf("%c\t\t",code[cnt-1].result);
			printf("%c\n",code[cnt].opd1);
		}
		else
		{
			
			if(isalpha(code[cnt].opd1))
				printf("%c\t",code[cnt].opd1);
			else
				printf("%c\t",t++);
			if(isalpha(code[cnt].opd2))
				printf("%c\t",code[cnt].opd2);
			else
				printf("%c\t",t++);
			printf("%c\t",code[cnt].result);
			printf("\n");
		}
		cnt++;
	}
}
void triple()
{
	int cnt=0,id=0,id1;
	char t='A';
	printf("\n\n\tTRIPLE ADDRESS CODE\n\n");
	while(cnt<ind)
	{
		printf("%d\t",id);
		printf("%c\t",code[cnt].opr);
		if(code[cnt].opr=='=')
		{
			if(isalpha(code[cnt].opd2))
				printf("%c\t",code[cnt-1].result);
			else
				printf("%d\n",id-1);
		}
		else
		{
			id1=id-1;
			if(isalpha(code[cnt].opd1))
				printf("%c\t",code[cnt].opd1);
			else
			{
				
				printf("%d\t",id1);
				id1--;
			}
			if(isalpha(code[cnt].opd2))
				printf("%c\t",code[cnt].opd2);
			else
				printf("%d\t",id1);
			printf("\n");
		}
		cnt++;
		id++;
	}
}

main()
{
printf("\nEnter the Expression: ");
yyparse();
ThreeAddressCode();
quadraple();
triple();
}
