package analizador;
import java_cup.runtime.Symbol;

%%
%class lexico
%public
%line
%char
%cup
%unicode
%state CADENA
%ignorecase

%init{
    yyline = 1;
    yychar = 1;
%init}

%{
    //Código de usuario
    String cadena= "";
%}

//simbolos

DIAGO_INI = "\"
LLAV_A  = "{"
LLAV_C  = "}" 


//palabras reservadas

BEGIN1   = "begin"
TITLE    = "title"
END      = "end"

//expresiones

D       = [0-9]+
DD      = [0-9]+("."[  |0-9]+)?
BLANCOS = [\ \r\t\f\t]
ENTER   = [\ \n]
ID      = [A-Za-zñÑ][_0-9A-Za-zñÑ]*

%%

<YYINITIAL> {DIAGO_INI}      { return new Symbol(sym.DIAGO_INI, yyline, yycolumn,"dinicial");}
<YYINITIAL> {LLAV_A}    {return new Symbol(sym.LLAV_A, yyline, yycolumn,yytext());}
<YYINITIAL> {LLAV_C}    {return new Symbol(sym.LLAV_C, yyline, yycolumn,yytext());}

<YYINITIAL> {D}    { return new Symbol(sym.D, yyline, yycolumn,yytext());}
<YYINITIAL> {DD}    { return new Symbol(sym.DD, yyline, yycolumn,yytext());}
<YYINITIAL> {ID}        {return new Symbol(sym.ID, yyline, yycolumn,yytext());}
<YYINITIAL> [\"]        { yybegin(); cadena+="\""; }
<YYINITIAL> {BLANCOS}     { /*Espacios en blanco, ignorados*/ }
<YYINITIAL> {ENTER}     { /*Saltos de linea, ignorados*/}


<YYINITIAL> . {
        String errLex = "Error léxico : '"+yytext()+"' en la línea: "+(yyline+1)+" y columna: "+(yycolumn+1);
        System.out.println(errLex);
}

<CADENA> {
        [\"] { String tmp=cadena+"\""; cadena=""; yybegin(YYINITIAL);  return new Symbol(sym.CADENA, yychar,yyline,tmp); }
        [\n] {String tmp=cadena; cadena="";  
                System.out.println("Se esperaba cierre de cadena (\")."); 
                yybegin(YYINITIAL);
            }
        [^\"] { cadena+=yytext();}
}