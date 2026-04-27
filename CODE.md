👉 Let’s focus on your **Experiment 2 (SPCC – LEX)** 

---

# 🧪 Q1: Even or Odd Number (`exp2a.l`)

```c
%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
[+-]?[0-9]+ {
    int i = atoi(yytext);
    if(i % 2 == 0)
        printf("It is Even Number\n");
    else
        printf("It is Odd Number\n");
}
. {
    printf("Invalid input\n");
}
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
```

---

# 🧪 Q2: Vowel or Consonant (`exp2b.l`)

```c
%{
#include <stdio.h>
int vowel = 0, consonant = 0;
%}

%%
[aeiouAEIOU] {
    printf("Entered character is Vowel\n");
    vowel++;
}
[a-zA-Z] {
    printf("Entered character is Consonant\n");
    consonant++;
}
. {
    printf("Invalid Input\n");
}
%%

int main() {
    printf("Enter characters:\n");
    yylex();
    printf("\nTotal Vowels = %d, Consonants = %d\n", vowel, consonant);
    return 0;
}

int yywrap() {
    return 1;
}
```

---

# 🧪 Q3: Count Characters (`exp2c.l`)

```c
%{
#include <stdio.h>
int count = 0;
%}

%%
[a-zA-Z0-9] { count++; }
\n {
    printf("Count: %d\n", count);
    count = 0;
}
. ;
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
```

---

# 🧪 Q4: Relational Operators (`exp2d.l`)

```c
%{
#include <stdio.h>
%}

%%
"==" { printf("Encountered IsEqual to operator\n"); }
"!=" { printf("Encountered Not equal to operator\n"); }
">=" { printf("Encountered Greater than equal to operator\n"); }
"<=" { printf("Encountered Less than equal to operator\n"); }
">"  { printf("Encountered Greater than operator\n"); }
"<"  { printf("Encountered Less than operator\n"); }
.    { printf("Invalid input\n"); }
%%

int main() {
    printf("Enter input:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
```

---

# 🧪 Q5: Copy File (`exp2e.l`)

```c
%{
#include <stdio.h>
FILE *outFile;
%}

%%
. { fputc(yytext[0], outFile); }
%%

int main(int argc, char *argv[]) {
    if(argc != 3) {
        printf("Usage: inputfile outputfile\n");
        return 0;
    }

    FILE *inFile = fopen(argv[1], "r");
    if(inFile == NULL) {
        printf("Error opening input file\n");
        return 0;
    }

    outFile = fopen(argv[2], "w");
    if(outFile == NULL) {
        printf("Error opening output file\n");
        return 0;
    }

    yyin = inFile;
    yylex();

    fclose(inFile);
    fclose(outFile);

    printf("File copied successfully\n");
    return 0;
}

int yywrap() {
    return 1;
}
```

---

# ⚙️ HOW TO RUN (same for all)

In VS Code terminal (CMD):

```bash
flex exp2a.l
gcc lex.yy.c -o exp2a
exp2a
```

---

# 🧠 For Q5 (file copy)

```bash
flex exp2e.l
gcc lex.yy.c -o exp2e
exp2e input.txt output.txt
```

---