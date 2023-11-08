       identification division.
       program-id. Fruit-02.
      
       environment division.
           copy "postData-environmentdivision.cbl".

       input-output section.
       file-control.
           select infile assign to "FixedFruits.txt" organization is
           line sequential.

           copy "postData-filecontrol.cbl".

       data division.
       file section.

       fd  webinput.
       01  xPostData                    pic x(1024).

           copy "postData-filesection.cbl".

       fd  infile.
       01  xInput.
           05 xfruitNameInput           pic x(14).
           05 nfruitQuantityInput       pic 999.
           05 nfruitPriceInput          pic 9v99.

       working-storage section.
       77  xNewLine                    pic x         value x"0a".
       77  xEofFlag                    pic x         value 'n'.
       77  xProcessName                pic x(14).

       01  xOutput1.
           05 filler                   pic x(8)      value "<tr><td>".
           05 xfruitNameOutput         pic x(14).
           05 filler                   pic x(9)      value "</td><td>".
           05 nefruitQuantityOutput    pic zz9.
           05 filler                   pic x(9)      value "</td><td>".
           05 nefruitPriceOutput       pic $9.99.
           05 filler                   pic x(10)     value "</td></tr>".

       01  xOutput2.
           05 filler pic x(31) value "<tr><td colspan=3 align=center>".
           05 filler pic x(17) value "<img src='fruits/".
           05 xOutPic  pic x(14).
           05 filler pic xx  value "'>".
           05 filler pic x(10) value "</td></tr>".
      
           copy "postData-workingstorage.cbl".

       procedure division.
       000-main.
           perform 100-initialization.
           perform 200-processing.
           perform 300-termination.
           stop run.
       
       100-initialization.
           open input infile.
           display "Content-type: text/html", xNewLine.

           display "<!doctype html>".
           display "<html>".

           display "<head>".
           display "<title>Fruit-o2</title>".
           display 
           "<link rel=stylesheet type='text/css' href='cobol.css'>".
           display "</head>".

           display "<body>".
           call "getPostData".
           move function getPostValue("fruitname") to xProcessName.

       200-processing.
           display "<table>".
           perform 210-loop until xEofFlag = "y".
           display "</table>".

       210-loop.
           read infile
               at end 
                   move "y" to xEofFlag
               not at end
                   if xfruitNameInput = xProcessName
                       perform 220-display
                   end-if,
           end-read.

       220-display.
           move xfruitNameInput to xfruitNameOutput.
           move nfruitQuantityInput to nefruitQuantityOutput.
           move nfruitPriceInput to nefruitPriceOutput.
           display xOutput1.

           move function concatenate(function trim(xfruitNameInput), 
           ".png") to xOutPic.
           display xOutput2.

       300-termination.
           close infile.
           display "</body>".
           display "</html>".

           copy "postData-procedure.cbl".

