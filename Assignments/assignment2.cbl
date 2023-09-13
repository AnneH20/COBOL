      * Program: Assignment 2 - Temperature Conversion

       identification division.
       program-id. TempConverter-02.
       author. Anne.
      
       environment division.
      
       data division.
       working-storage section.
       77  nFah                    PIC S999999999V99.
       77  neCent                  PIC ---,---,--9.99.
      
       procedure division.
       000-main.
           display " ".
           display "WELCOME TO THE TEMP CONVERTER".
           display " ".

           display "Please enter a temperature in Fahrenheit -->"
           accept nFah.
           compute neCent = (nFah - 32) * 0.5556.

           display " ".
           display "FORMULA USED: (FAHRENHEIT # - 32) * 0.5556".
           display " ".

           display "The centigrade equivalent is ", neCent, " degrees.".
           display " ".

           display "THANK YOU FOR USING THE TEMP CONVERTER".
           display " ".
           stop run.
      
      * Add a blank line at the end 
