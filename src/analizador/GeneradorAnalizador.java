package analizador;

import jflex.*;
import java_cup.runtime.*;
public class GeneradorAnalizador {

    public static void main(String[] args) {
        generarCompilador();
    }


    private static void generarCompilador(){
        try {
            String ruta = "src/analizador/"; //ruta donde tenemos los archivos con extension .jflex y .cup
            String opcFlex[] = { ruta + "lexico.jflex", "-d", ruta };
            jflex.Main.generate(opcFlex);
            String opcCUP[] = { "-destdir", ruta, "-parser", "parser", ruta + "sintactico.cup" };
            java_cup.Main.main(opcCUP);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}