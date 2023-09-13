      * Program: Exam 1 - Currency Conversion

       identification division.
       program-id. CurrencyConverter.
       author. Anne.
      
       environment division.
      
       data division.
       working-storage section.
       77  nUSD                    PIC S999999999V99.
       77  neEUR                  PIC ---,---,--9.99.
      
       procedure division.
       000-main.
           display " ".
           display "WELCOME TO THE CURRENCY CONVERTER".
           display " ".

           display "Enter the US amount to convert to Euros: " 
           with no advancing.
           accept nUSD.
           compute neEUR = nUSD * 0.93033.

           display " ".
           display "FORMULA USED: USD * 0.93033".
           display " ".

           display "The amount in Euros is: ", neEUR.
           display " ".

           display "THANK YOU FOR USING THE CURRENCY CONVERTER".
           display " ".
           display "Enjoy your trip across the pond. Cheerio!".
           display " ".
           stop run.
      
      * Add a blank line at the end 
