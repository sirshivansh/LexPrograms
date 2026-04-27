%{
#include <stdio.h>
%}

%%
"==" { printf("Equal Operator\n"); }
"!=" { printf("Not Equal Operator\n"); }
">=" { printf("Greater Than or Equal\n"); }
"<=" { printf("Less Than or Equal\n"); }
">"  { printf("Greater Than\n"); }
"<"  { printf("Less Than\n"); }
.    { printf("Invalid Input\n"); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}