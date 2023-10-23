      * Program: Assignment 7 - Hello Web Browser

       identification division.
       program-id. hw7.
       author. Anne.

       environment division.

       data division.
       working-storage section.
       77  xNewLine                pic x           value x"0a".

       procedure division.
       000-main.
           display "Content-type: text/html", xNewLine.

           display "<!doctype html>".
           display "<html>".
           display "<head>".
           display "<title>Hello Web Browser</title>".
           display "</head>".
           display "<body bgcolor=black>".
           display "<font color=white>".
           display "Hello World!".
           display "</font>".
           display "</body>".
           display "</html>".
           stop run.


      * Add a blank line at the end 
