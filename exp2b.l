%{
#include <stdio.h>
%}

%%
[aeiouAEIOU] { printf("Vowel\n"); }
[a-zA-Z] { printf("Consonant\n"); }
. { printf("Invalid Input\n"); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}