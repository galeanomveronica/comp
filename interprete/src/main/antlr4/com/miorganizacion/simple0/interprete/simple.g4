grammar simple;
  
@parse::header{
	import java.util.Map;
	import java.util.HashMap;
}
  
@parser::members {
	Map<String, Object> symbolTable = new HashMap<String, Object>();
}
 
 
program: PROGRAM ID BRACKET_OPEN
	sentence *
	BRACKET_CLOSE;
	
sentence: var_decl | var_assign | println;

var_decl: VAR ID SEMICOLON
	{symbolTable.put($ID.text, 0);};
var_assign: ID ASSIGN expression SEMICOLON
	{symbolTable.put($ID.text, $expression.value);};
println: PRINTLN expression SEMICOLON
	{System.out.println($expression.value);};
	
expression returns [Object value]:
	t1=factor {$value = (int)$t1.value;}
	(PLUS t2=factor {$value = (int)$value + (int)$t2.value;})* | (MINUS t2=factor {$value = (int)$value - (int)$t2.value;})*;
	
factor returns [Object value]: t1=term {$value = (int)$t1.value;}
	(MULT t2=term {$value = (int)$value * (int)$t2.value;})* | (DIV t2=term {$value = (int)$value / (int)$t2.value;})*;
	
	
term returns [Object value]:
	NUMBER {$value = Integer.parseInt($NUMBER.text); }
	| ID {$value = symbolTable.get($ID.text);}
	| PAR_OPEN expression {$value = $expression.value;} PAR_CLOSE;
	 
	 
PROGRAM:'program';
VAR: 'var';
PRINTLN: 'println';

PLUS: '+';
MINUS: '-';
MULT: '*';
DIV: '/';

AND: '&&';
OR:'||';
NOT: '!';

GT: '>';
LT: '<';
GEQ: '>=';
LEQ: '<=';
EQ: '==';
NEQ: '!=';

ASSIGN: '=';

BRACKET_OPEN: '{';
BRACKET_CLOSE: '}';

PAR_OPEN: '(';
PAR_CLOSE: ')';

SEMICOLON: ';';

ID: [a-zA-Z_][a-zA-Z0-9_]*;

NUMBER: [0-9]+;

WS: [\t\n\r]+ -> skip;

