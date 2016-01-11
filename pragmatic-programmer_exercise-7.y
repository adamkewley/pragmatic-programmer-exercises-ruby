%{
  #include <stdio.h>
  #include <ctype.h>
  #include <stdlib.h>
  int yylex(void);
  void yyerror(char const *);

  enum {AM_MINS=0, PM_MINS=12*60};
%}

%token END_TOKEN DIGIT AM PM
%start time

%%

time:
  spec END_TOKEN {
    if($1 >= 24*60) yyerror("Time too large");
    printf("%d minutes past midnight \n", $1);
    exit(0);
  }
;

spec:
  hour ampm { 
    if($1 > 11*60) yyerror("Hour out of range");
    $$ = $1 + $2;
  }
| hour ':' minute ampm { 
    if($1 > 11*60) yyerror("Hour out of range");
    $$ = $1 + $3 + $4;
  }
| hour ':' minute { 
    $$ = $1 + $3;
  }
;

hour:
  hour_num {
    if($1 > 23) yyerror("Hour out of range");
    $$ = $1 * 60;
  }
;

minute: 
  DIGIT DIGIT {
    $$ = $1 * 10 + $2;
    if($$ > 59) yyerror("Minute out of range");
  }
;

ampm: 
  AM { $$ = AM_MINS; }
| PM { $$ = PM_MINS; }
;

hour_num:
DIGIT { $$ = $1; }
| DIGIT DIGIT { $$ = $1 * 10 + $2; }
;

%%

// The thing being pointed to is constant, not the
// pointer itself (which is why cp++ is allowed)
const char *cp;

int yylex(void)
{
  // Get char at the pointer
  char ch = *cp;

  // If pointing to a zero terminator
  if(!ch)
    return END_TOKEN;

  // Increment the pointer to the next char
  cp++;

  // If previous was a digit
  if (isdigit(ch)) {
    // Assign digit to token value
    yylval = ch - '0';

    // Return digit token
    return DIGIT;
  }

  // Remember, cp has been incremented, so it's a lookahead
  if (((ch == 'a') || (ch == 'p')) && (*cp == 'm')) {
    // Increment cp past the 'am/pm' characters
    cp++;
    return (ch == 'a') ? AM : PM;
  }

  return ch;
}

void yyerror(char const *s)
{
  fprintf(stderr, "%s\n", s);
  exit(-1);
}

int main(int argc, char **argv)
{
  // First argument is the time string
  if (argc > 1) {
    cp = argv[1];
    yyparse();
  }

  return 0;
}
