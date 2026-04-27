2.A
---
# 📄 Your LEX Code

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

int yywrap() {
    return 1;
}
```

---

# 🧠 Big Picture (very important)

👉 This program:

> Takes input → checks if number is even or odd

But internally:

👉 **LEX doesn’t read line like C**  
👉 It reads **patterns (tokens)**

---

# ⚙️ Structure of LEX Program

LEX always has 3 parts:

---

## 🔹 1. Definition Section

```c
%{
#include <stdio.h>
#include <stdlib.h>
%}
```

👉 This is normal C code  
👉 Used for libraries, variables

---

## 🔹 2. Rules Section (MOST IMPORTANT)

```c
%%
[0-9]+ { ... }
. { ... }
%%
```

👉 This is the **heart of LEX**

---

### 🔸 Rule 1:

```c
[0-9]+
```

👉 Means:

> Match one or more digits (0–9)

Examples:

```
2, 45, 123 → match
```

---

### 🔸 Inside block:

```c
int num = atoi(yytext);
```

👉 `yytext` = matched text (string)

Example:

```
input: "23"
yytext = "23"
```

👉 `atoi()` converts string → integer

---

### 🔸 Then logic:

```c
if(num % 2 == 0)
```

👉 Even → remainder 0  
👉 Odd → remainder 1

---

## 🔸 Rule 2:

```c
. { printf("Invalid Input\n"); }
```

👉 `.` means:

> Match ANY single character

So:

```
@, a, # → Invalid
```

---

# 🔹 3. User Code Section

```c
int main() {
    yylex();
    return 0;
}
```

---

## 🔸 yylex()

👉 This is the **engine of LEX**

👉 It:

- reads input
    
- matches patterns
    
- executes corresponding actions
    

---

# 🔹 yywrap()

```c
int yywrap() {
    return 1;
}
```

👉 Tells LEX:

> Input finished

---

# 🧠 Flow of Program (IMPORTANT)

Input:

```
23
```

---

### Step-by-step:

1. `yylex()` starts
    
2. Reads input
    
3. Matches `[0-9]+`
    
4. Stores in `yytext = "23"`
    
5. Converts → `num = 23`
    
6. Checks even/odd
    
7. Prints output
    

---

# 🎯 Example

Input:

```
5
```

Output:

```
Odd Number
```

---

# ⚠️ Important concept

LEX works like:

👉 **Pattern → Action**

|Pattern|Action|
|---|---|
|`[0-9]+`|even/odd logic|
|`.`|invalid|

---

# 🔥 Viva Points (VERY IMPORTANT)

Say these confidently:

👉 “LEX works using pattern matching rules.”  
👉 “yytext stores the matched token.”  
👉 “yylex() scans input and applies rules.”

---

# 🧠 One-line understanding

👉 This program:

> Reads input → matches digits → converts → checks even/odd

---

2.B
---
**Q2: Vowel / Consonant** (very common practical)

---

# 📄 Program: Vowel or Consonant (LEX)

Create file:

```text
exp2b.l
```

Paste this:

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

int yywrap() {
    return 1;
}
```

---

# 🧠 Understanding (simple + important)

## 🔹 Rule 1

```c
[aeiouAEIOU]
```

👉 Matches vowels (both cases)

---

## 🔹 Rule 2

```c
[a-zA-Z]
```

👉 Matches any alphabet

---

## 🔹 Rule priority (VERY IMPORTANT)

👉 LEX checks **top to bottom**

So:

1. First checks vowel
    
2. Then consonant
    

---

## 🔹 Rule 3

```c
.
```

👉 Anything else → invalid

---

# ⚙️ Run it

```bash
flex exp2b.l
gcc lex.yy.c -o exp2b
exp2b
```

---

# 🧪 Test

Input:

```
a → Vowel
B → Consonant
@ → Invalid Input
```

---

# ⚠️ Same behavior

👉 Program waits for input  
👉 After typing → press **Enter + Ctrl + Z + Enter**

---

# 🔥 Viva Points

👉 “Pattern matching is done using character classes”  
👉 “Order of rules matters in LEX”  
👉 “First matching rule is executed”

---

# 🧠 Important Concept Upgrade

Now you understand:

👉 `[ ]` = character set  
👉 `+` = one or more  
👉 `.` = any character

---

2.C 
---
---

# 📄 Q3: Count Characters (LEX)

👉 Goal:

> Count how many characters user enters

---

## 📁 Create file

```text
exp2c.l
```

---

## 📄 Code

```c
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
```

---

# 🧠 Understanding (important)

## 🔹 Variable

```c
int count = 0;
```

👉 Stores number of characters

---

## 🔹 Rule 1

```c
[a-zA-Z0-9]
```

👉 Matches:

- alphabets
    
- digits
    

👉 Action:

```c
count++;
```

---

## 🔹 Rule 2 (VERY IMPORTANT)

```c
\n
```

👉 When you press **Enter**

👉 Action:

```c
printf("Total characters = %d", count);
```

👉 Then reset:

```c
count = 0;
```

---

## 🔹 Rule 3

```c
.
```

👉 Ignore everything else

---

# ⚙️ Run

```bash
flex exp2c.l
gcc lex.yy.c -o exp2c
exp2c
```

---

# 🧪 Example

Input:

```text
Hello123
```

Output:

```text
Total characters = 8
```

---

# ⚠️ Behavior

👉 It prints result when you press **Enter**

👉 No need for Ctrl+Z here (because of `\n` rule)

---

# 🔥 Viva Points

👉 “\n is used to detect end of input line”  
👉 “count variable is updated for each match”  
👉 “LEX processes input character by character”

---

# 🧠 Concept upgrade

Now you know:

|Symbol|Meaning|
|---|---|
|`[a-z]`|range|
|`\n`|newline|
|`.`|any char|
|action `{}`|executed code|

---

2.4
---
---

# 📄 Q4: Relational Operators (LEX)

👉 Goal:

> Identify operators like `==`, `!=`, `>`, `<`, `>=`, `<=`

---

## 📁 Create file

```text
exp2d.l
```

---

## 📄 Code

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

int yywrap() {
    return 1;
}
```

---

# 🧠 Understanding (VERY IMPORTANT)

## 🔹 Direct matching

```c
"=="
```

👉 Matches exactly `==`

---

## 🔹 Rule order matters ⚠️

👉 VERY IMPORTANT:

```c
">="  must come BEFORE  ">"
```

👉 Why?

If `>` comes first:

- Input `>=` → matched as `>` ❌
    

So:

👉 Always write **longer patterns first**

---

# 🔥 Pattern priority concept

LEX follows:

> First match in order (top → bottom)

---

# ⚙️ Run

```bash
flex exp2d.l
gcc lex.yy.c -o exp2d
exp2d
```

---

# 🧪 Test

Input:

```text
==
>=
<
@
```

Output:

```text
Equal Operator
Greater Than or Equal
Less Than
Invalid Input
```

---

# ⚠️ Behavior

👉 Each symbol processed separately  
👉 Press Enter after each input

---

# 🔥 Viva Points (VERY IMPORTANT)

👉 “LEX follows longest match + rule priority”  
👉 “Operators are matched using string patterns”  
👉 “Order of rules affects output”

---

# 🧠 Concept upgrade

Now you understand:

|Concept|Meaning|
|---|---|
|`"=="`|exact string match|
|rule order|priority|
|longest first|correct matching|

---

2.5
---
---

# 📄 Q5: File Copy Program (LEX)

👉 Goal:

> Copy content from one file → another file

---

# 📁 Create file

```text
exp2e.l
```

---

# 📄 Code (for reference)

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

int yywrap() {
    return 1;
}
```

---

# 🧠 Big Idea (one line)

👉 This program:

> Reads characters from one file and writes them to another using LEX

---

# ⚙️ PART 1: Definition Section

```c
%{
#include <stdio.h>
%}
```

👉 Normal C code  
👉 Needed for:

- `FILE`
    
- `fopen()`
    
- `fputc()`
    

---

# ⚙️ PART 2: Rules Section (CORE)

```c
%%
.|\n { fputc(yytext[0], yyout); }
%%
```

---

## 🔹 Pattern:

```c
.|\n
```

👉 Means:

- `.` → any character
    
- `\n` → newline
    

👉 So:

> Match EVERYTHING in file

---

## 🔹 Action:

```c
fputc(yytext[0], yyout);
```

👉 `yytext` = matched text  
👉 `yytext[0]` = first character

👉 `fputc()`:

> writes character to output file

---

## 🧠 Important concept

|Term|Meaning|
|---|---|
|`yytext`|matched token|
|`yyin`|input file|
|`yyout`|output file|

---

# ⚙️ PART 3: main() function

---

## 🔹 Command line arguments

```c
int main(int argc, char *argv[])
```

👉 `argc` = number of arguments  
👉 `argv` = argument values

---

## 🔹 Check arguments

```c
if(argc != 3)
```

👉 Why 3?

```text
exp2e input.txt output.txt
```

|Index|Value|
|---|---|
|argv[0]|program name|
|argv[1]|input file|
|argv[2]|output file|

---

## 🔹 Open files

```c
FILE *input = fopen(argv[1], "r");
FILE *output = fopen(argv[2], "w");
```

👉 `"r"` → read mode  
👉 `"w"` → write mode

---

## 🔹 Error handling

```c
if(input == NULL || output == NULL)
```

👉 If file not found → show error

---

## 🔹 Connect LEX to files

```c
yyin = input;
yyout = output;
```

👉 This is VERY IMPORTANT:

- LEX reads from `yyin`
    
- LEX writes to `yyout`
    

---

## 🔹 Start scanning

```c
yylex();
```

👉 Reads file → applies rule → copies data

---

## 🔹 Close files

```c
fclose(input);
fclose(output);
```

👉 Good practice + required

---

## 🔹 Final message

```c
printf("File copied successfully\n");
```

---

# ⚙️ PART 4: yywrap()

```c
int yywrap() {
    return 1;
}
```

👉 Tells LEX:

> End of input reached

---

# 🧠 Flow of Execution (IMPORTANT)

1. Program starts
    
2. Opens input & output files
    
3. `yyin` → input file
    
4. `yyout` → output file
    
5. `yylex()` starts scanning
    
6. Each character matched
    
7. `fputc()` writes to output file
    
8. End of file → stop
    
9. Print success message
    

---

# 🔥 Difference from old version

|Old|New|
|---|---|
|`putchar()`|`fputc(..., yyout)`|
|prints on screen ❌|writes to file ✅|

---

# 🎯 Viva Questions (from THIS program)

### ❓ What is `yyin`?

👉 Input file pointer for LEX

### ❓ What is `yyout`?

👉 Output file pointer

### ❓ Why use `fputc()`?

👉 To write to file instead of screen

### ❓ What does `.|\n` do?

👉 Matches all characters including newline

---

# 🧠 One-line summary (memorize)

👉 _“The program uses LEX to read characters from yyin and write them to yyout using fputc.”_

---

# 🚀 You’re done

Now you:

- understand logic ✅
    
- fixed bug ✅
    
- can explain in viva ✅
    

---
