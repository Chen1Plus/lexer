%{
    int pr_src = 1;
    int pr_tok = 1;

    int line_cnt = 1;
    char src[310] = {'\0'};

    #define push() strcat(src, yytext)
    #define print(s) if (pr_tok) printf(s, yytext)
    void print_line() {
        if (pr_src) printf("%d:%s\n", line_cnt++, src);
        src[0] = '\0';
    }
%}

key      for|do|while|break|continue|if|else|return|struct|switch|case|default|void|int|double|float|char|const|signed|unsigned|short|long
macro    NULL|__COUNTER__|__LINE__|INT_MAX|INT_MIN|CHAR_MAX|CHAR_MIN|MAX|MIN

integer  [-\+]?[[:digit:]]+
float    [-\+]?([[:digit:]]+\.|[[:digit:]]*\.[[:digit:]]+)
char     [[:print:]]|\\.

op       [\*\/%]|\+\+?|--?|[<>!=]=?|&&?|\|\|?
punc     [:;,\.\[\]\(\)\{\}]

id       [_[:alpha:]][_[:alnum:]]*

%x comment

%%
#pragma[ \t]+source[ \t]+on  { pr_src = 1; push(); }
#pragma[ \t]+source[ \t]+off { pr_src = 0; push(); }

#pragma[ \t]+token[ \t]+on   { pr_tok = 1; push(); }
#pragma[ \t]+token[ \t]+off  { pr_tok = 0; push(); }

\/\/.*         push();
\/\*           { BEGIN comment; push(); }
<comment>\*\/  { BEGIN INITIAL; push(); }
<comment>.     push();
<comment>\n    print_line();

{key}    { print("#key:%s\n");   push(); }
{macro}  { print("#macro:%s\n"); push(); }

{integer}   { print("#integer:%s\n"); push(); }
{float}     { print("#float:%s\n");   push(); }
\'{char}\'  { print("#char:%s\n");    push(); }
\"{char}*\" { print("#string:%s\n");  push(); }

{op}    { print("#op:%s\n");   push(); }
{punc}  { print("#punc:%s\n"); push(); }

{id} { print("#id:%s\n"); push(); }

.    { push();  }
\n   { print_line(); }

%%
int yywrap() { return 1; }
int main() { yylex(); }
