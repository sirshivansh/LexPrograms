%{
#include <stdio.h>

int count = 0;
%}

%%
[a-zA-Z0-9] { count++; }
\n { printf("Total characters = %d\n", count); count = 0; }
. { /* ignore other characters */ }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}