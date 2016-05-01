package com.mak;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;

public class LoggingService {
    public static String readLoggingFile(String file) throws IOException{
        StringBuilder sb = new StringBuilder();
        File logFile = new File(file);
        sb.append("Snapshot for file [" + logFile.getAbsolutePath() + "] on [" + new Date().toString() + "]\r\n\r\n\r\n");

        FileInputStream fstream = new FileInputStream(file);
        DataInputStream in = new DataInputStream(fstream);
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
        String str = null;
        while((str = br.readLine()) != null){
            sb.append(str).append("\r\n");
        }
        in.close();
        fstream.close();

//        Scanner s = new Scanner(logFile);
//        while(s.hasNextLine()){
//            sb.append(s.nextLine() + "\r\n");
//        }

        return sb.toString();
    }
}
