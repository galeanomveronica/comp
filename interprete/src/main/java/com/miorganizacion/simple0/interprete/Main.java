package com.miorganizacion.simple0.interprete;

import java.io.IOException;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

public class Main {

    private static final String EXTENSION = "smp";
    private static final String DIRBASE = "src/test/resources/";

    public static void main(String[] args) throws IOException {
        String files[] = args.length==0? new String[]{ "test." + EXTENSION } : args;
        System.out.println("Dirbase: " + DIRBASE);
        for (String file : files){
            System.out.println("START: " + file);

            CharStream in = CharStreams.fromFileName(DIRBASE + file);
            simpleLexer lexer = new simpleLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            simpleParser parser = new simpleParser(tokens);
            
            simpleParser.ProgramContext tree = parser.program();
            
            simpleCustomVisitor visitor = new simpleCustomVisitor();
            visitor.visit(tree);

            System.out.println("FINISH: " + file);
        }
    }
}
