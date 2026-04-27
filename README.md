---

# 📄 **Experiment : Implementation of LEX Programs**

---

## 🎯 **Aim**

To implement LEX programs for:

1. Checking Even/Odd number
2. Identifying Vowel/Consonant
3. Counting number of characters
4. Recognizing relational operators
5. Copying contents from one file to another

---

## 🧰 **Resources Required**

* Computer system with Windows OS
* Flex
* GCC
* Text editor (e.g., Visual Studio Code)

---

## 📚 **Theory**

LEX is a tool used to generate lexical analyzers. It scans input and matches patterns defined by rules. A LEX program consists of three sections:

1. **Definition Section** – Contains header files and declarations
2. **Rules Section** – Contains patterns and corresponding actions
3. **User Code Section** – Contains main function and additional logic

LEX works on the principle of **pattern matching**, where each input token is compared with defined rules and corresponding actions are executed.

---

# 🔹 **Program 1: Even or Odd Number**

### 💻 Code

```c
%{
#include <stdio.h>
#include <stdlib.h>
%}

%%
[0-9]+ {
    int num = atoi(yytext);
    if(num % 2 == 0)
        printf("Even Number\n");
    else
        printf("Odd Number\n");
}
. { printf("Invalid Input\n"); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() { return 1; }
```

### 🧪 Sample Output

```
Input: 2
Output: Even Number
```

---

# 🔹 **Program 2: Vowel or Consonant**

### 💻 Code

```c
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

int yywrap() { return 1; }
```

### 🧪 Sample Output

```
Input: a
Output: Vowel
```

---

# 🔹 **Program 3: Count Characters**

### 💻 Code

```c
%{
#include <stdio.h>
int count = 0;
%}

%%
[a-zA-Z0-9] { count++; }
\n { printf("Total characters = %d\n", count); count = 0; }
. { }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() { return 1; }
```

### 🧪 Sample Output

```
Input: Hello123
Output: Total characters = 8
```

---

# 🔹 **Program 4: Relational Operators**

### 💻 Code

```c
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

int yywrap() { return 1; }
```

### 🧪 Sample Output

```
Input: >=
Output: Greater Than or Equal
```

---

# 🔹 **Program 5: File Copy**

### 💻 Code

```c
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

int yywrap() { return 1; }
```

### 🧪 Sample Output

```
Output: File copied successfully
```

---

## ⚙️ **Procedure**

1. Write each LEX program in `.l` file
2. Generate C code using:

   ```
   flex filename.l
   ```
3. Compile using:

   ```
   gcc lex.yy.c -o output
   ```
4. Execute the program:

   ```
   output
   ```

   (or pass arguments for file copy)

---

## 🧾 **Conclusion**

Thus, various LEX programs were successfully implemented to perform pattern matching tasks such as number classification, character analysis, operator recognition, and file handling. The experiment demonstrates the use of LEX in lexical analysis and text processing.

---

# 🔥 Final Tip (write in exam)

👉 *“LEX uses pattern-action rules to process input and generate tokens efficiently.”*

---

