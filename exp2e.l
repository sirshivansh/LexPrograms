%{
#include <stdio.h>
%}

%%
.|\n { fputc(yytext[0], yyout); }
%%

int main(int argc, char *argv[]) {

    if(argc != 3) {
        printf("Usage: exp2e input.txt output.txt\n");
        return 1;
    }

    FILE *input = fopen(argv[1], "r");
    FILE *output = fopen(argv[2], "w");

    if(input == NULL || output == NULL) {
        printf("Error opening file\n");
        return 1;
    }

    yyin = input;
    yyout = output;

    yylex();

    fclose(input);
    fclose(output);

    printf("File copied successfully\n");

    return 0;
}

int yywrap() {
    return 1;
}