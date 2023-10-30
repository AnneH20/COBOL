      * Program: Assignment 8 - Fruit Webpage

       identification division.
       program-id. Fruit-01.
       author. Anne.
      
       environment division.
       input-output section.
       file-control.
           select inFile assign to "FixedFruits.txt" organization is
           line sequential.

       data division.
       file section.

       fd  inFile.
       01  xInput.
           05 xfruitNameInput           pic x(14).
           05 xfruitQuantityInput       pic 999.
           05 xfruitPriceInput          pic 9v99.

       working-storage section.
       77  xNewLine                    pic x         value x"0a".
       77  xEofFlag                    pic x         value 'n'.

       01  xOutput.
           05 filler                   pic x(8)      value "<tr><td>".
           05 xfruitNameOutput         pic x(14).
           05 filler                   pic x(9)      value "</td><td>".
           05 xfruitQuantityOutput     pic 999.
           05 filler                   pic x(9)      value "</td><td>".
           05 xfruitPriceOutput        pic $9.99.
           05 filler                   pic x(9)      value "</td><td>".
           05 filler                   pic x(17)     value 
           "<img src='fruits/".
           05 xOutPic                  pic x(15).
           05 filler                   pic xx        value "'>".
           05 filler                   pic x(10)     value "</td></tr>".

       procedure division.
       000-main.
           perform 100-initialization.
           perform 200-generate.
           perform 300-termination.
           stop run.

       100-initialization.
           open input inFile.
           display "Content-type: text/html", xNewLine.
           display "<!doctype html>".
           display "<html>".
           display "<head>".
           display 
           "<link rel=stylesheet type='text/css' href='cobol.css'>".
           display "</head>".
           display "<body>".
       
       200-generate.
           display "<table>".
           perform 210-loop until xEofFlag = "y".
           display "</table>".

       210-loop.
           read inFile
               at end 
                   move 'y' to xEofFlag
               not at end 
                   perform 220-process
           end-read.

       220-process.
           move xfruitNameInput to xfruitNameOutput.
           move xfruitQuantityInput to xfruitQuantityOutput.
           move xfruitPriceInput to xfruitPriceOutput.
           
           move function concatenate(function trim(xfruitNameInput), 
           ".png") to xOutPic.


           display xOutput.

       300-termination.
           close inFile.

           display "</body>".
           display "</html>".

                 
      * Add a blank line at the end 
