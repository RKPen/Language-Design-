
%{
    FILE* outFile;
    void printKeyword(const char* s) {
        fprintf(outFile, "<span style=\"color:#a0a000;\">%s</span>", s);
    }

%}


%%

    /* Rules for keywords */
val             printKeyword(yytext);

"datatype"      { printKeyword(yytext);}
"of"            { printKeyword(yytext);}
"val"           { printKeyword(yytext);}
"fun"           { printKeyword(yytext);}
"let"           { printKeyword(yytext);}
"in"            { printKeyword(yytext);}
"end"           { printKeyword(yytext);}
"if"            { printKeyword(yytext);}
"then"          { printKeyword(yytext);}
"else"          { printKeyword(yytext);}
"orelse"        { printKeyword(yytext);}
"andalso"       { printKeyword(yytext);}
"case"          { printKeyword(yytext);}






    /* Rules for built-in types */

"int"          { fprintf(outFile, "<span style=\"color:#00c000;\">%s</span>", yytext); }
"bool"         { fprintf(outFile, "<span style=\"color:#00c000;\">%s</span>", yytext); }
"string"       { fprintf(outFile, "<span style=\"color:#00c000;\">%s</span>", yytext); }





    /* Rule for integer and boolean literals */

[0-9]+          { fprintf(outFile, "<span style=\"color:#ff0000;\">%s</span>", yytext); }
"true"          { fprintf(outFile, "<span style=\"color:#ff0000;\">%s</span>", yytext); }
"false"         { fprintf(outFile, "<span style=\"color:#ff0000;\">%s</span>", yytext); }





    /* Rule for identifiers */

[A-Z_$][a-zA-Z_$0-9]*    {
                                fprintf(outFile, "<span style=\"color:#ff00ff;\">%s</span>", yytext);
                            }

[a-z][a-zA-Z_$0-9]*    {
                                fprintf(outFile, "<span style=\"color:#000000;\">%s</span>", yytext);
                            }


    /* Rules for operators and separators */

"(*"                {
                        fprintf(outFile, "<span style=\"color:#00aaff;\">(*");
                        int level = 1;
                        char c;
                        while(level > 0) {
                            c = input();
                            if(c == '(' && input() == '*') {
                                ++level;
                            }
                            if(c == '*' && input() == ')') {
                                --level;
                            }
                            if(level > 0) {
                                fprintf(outFile, "%c", c);
                            }
                        }
                        fprintf(outFile, "*)</span>");
                    }

"+"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">+</span>"); }
"-"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">-</span>"); }
"*"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">*</span>"); }
"|"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">|</span>"); }
"=>"                { fprintf(outFile, "<span style=\"color:#0000ff;\">=></span>");}
"<="                { fprintf(outFile, "<span style=\"color:#0000ff;\">=></span>");}
"="                 { fprintf(outFile, "<span style=\"color:#0000ff;\">=</span>"); }
"<"                 { fprintf(outFile, "<span style=\"color:#0000ff;\"><</span>"); }
">"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">></span>"); }
"::"                { fprintf(outFile, "<span style=\"color:#0000ff;\">::</span>");}
":"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">:</span>"); }
"."                 { fprintf(outFile, "<span style=\"color:#0000ff;\">.</span>"); }
"["                 { fprintf(outFile, "<span style=\"color:#0000ff;\">[</span>"); }
"]"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">]</span>"); }
","                 { fprintf(outFile, "<span style=\"color:#0000ff;\">,</span>"); }                   
"("                 { fprintf(outFile, "<span style=\"color:#0000ff;\">(</span>"); }
")"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">)</span>"); }
";"                 { fprintf(outFile, "<span style=\"color:#0000ff;\">;</span>"); }




    /* Rule for string literal */
    /* Hint: you can call input() to read the next character in the stream */

    \"      {
            int c = input();
            fprintf(outFile, "<span style=\"color:#ff0000;\">\"");
            while (c != EOF && c != '\"') {
                if (c == '\\') {
                    fprintf(outFile, "\\");
                    c = input();
                    if (c == '\"') {
                        fprintf(outFile, "\"");
                    } else {
                        fprintf(outFile, "\\%c", c);
                    }
                } else {
                    fprintf(outFile, "%c", c);
                }
                c = input();
            }
            fprintf(outFile, "\"</span>");
        }









    /* Rule for comment */
    /* Hint: you can call input() to read the next character in the stream */
    /* Hint: you can call unput(char) to return a character to the stream after reading it */

"(*"   {
            int c;
            fprintf(outFile, "<span style=\"color:#00aaff;\">%s", yytext);
            do {
                c = input();
                if(c == EOF) {
                    fprintf(stderr, "Error: Comment not closed!\n");
                    break;
                }
                if(c == '*') {
                    c = input();
                    if(c == ')') {
                        fprintf(outFile, "*)</span>");
                        break;
                    }
                    else {
                        unput(c);
                    }
                }
                fprintf(outFile, "%c", c);
            } while(1);
        }
"*)"








    /* Rule for whitespace */

    
[ \t\r\n]+  {
                fprintf(outFile, "%s", yytext);
                int i;
                for(i = 0; i < strlen(yytext); i++) {
                    if(yytext[i] == ' ') {
                        fprintf(outFile, "&nbsp;");
                    }
                    else {
                        fprintf(outFile, "<br>");
                    }
                }
            }




    /* Catch unmatched tokens */
.               fprintf(stderr, "INVALID TOKEN: %s\n", yytext);

%%

int main(int argc, char** argv) {
    const char* inFileName = (argc > 1)?argv[1]:"test.sml";
    const char* outFileName = (argc > 2)?argv[2]:"test.html";
    yyin = fopen(inFileName, "r");
    outFile = fopen(outFileName, "w");
    fprintf(outFile, "<html>\n<body><tt>\n");
    yylex();
    fprintf(outFile, "</body>\n</html></tt>\n");
    fclose(yyin);
    fclose(outFile);
    return 0;
}
int yywrap() {
    return 1;
}

