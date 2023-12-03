       identification division.
       program-id. exam5.
      
       environment division.
           copy "postData-environmentdivision.cbl".

       input-output section.
       file-control.
           select infile assign to "mensBBStats.txt" organization is
           line sequential.

           copy "postData-filecontrol.cbl".

       data division.
       file section.

       fd  webinput.
       01  xPostData                    pic x(1024).

           copy "postData-filesection.cbl".

       fd  infile.
       01  xInput.
           05 nJerseyNum               pic 99.
           05 xLastName                pic x(13).
           05 xFirstName               pic x(13).
           05 xPlayerClass             pic x(2).
           05 xHometown                pic x(16).
           05 xState                   pic x(2).
           05 nPoints                  pic 9(3).
           05 nRebounds                pic 9(3).
           05 nAssists                 pic 9(3).
           05 nBlocks                  pic 9(3).

       working-storage section.
       77  xNewLine                    pic x         value x"0a".
       77  xEofFlag                    pic x         value 'n'.
       77  xProcessName                pic x(2).
       77  nAvgPoints                  pic 9(4).
       77  nNumPlayers                 pic 9(2).
       77  neAvgPointsOutput           pic zzz.z9.


       01  xOutput.
           05 filler                   pic x(4)      value "<tr>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(12)      
           value "       </td>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(8)      value "Num</td>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(9)      value "Name</td>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(13)      
           value "Hometown</td>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(11)      
           value "Points</td>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(13)      
           value "Rebounds</td>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(12)      
           value "Assists</td>".
           05 filler                   pic x(4)      value "<td>".
           05 filler                   pic x(11)      
           value "Blocks</td>".
           05 filler                   pic x(5)      value "</tr>".

       01  xOutput1.

           05 filler pic x(31) value "<tr><td align=center>".
           05 filler pic x(17) value "<img src='mensBB/".
           05 xOutPic  pic x(18).
           05 filler pic xx  value "'>".
           05 filler pic x(9) value "</td><td>".
           05 neJerseyNumOutput        pic z9.
           05 filler                   pic x(9)      value "</td><td>".
           05 xPlayerNameOutput        pic x(27).
           05 filler                   pic x(9)      value "</td><td>".
           05 xHometownOutput          pic x(20).
           05 filler                   pic x(9)      value "</td><td>".
           05 nePointsOutput           pic zz9.
           05 filler                   pic x(9)      value "</td><td>".
           05 neReboundsOutput         pic zz9.
           05 filler                   pic x(9)      value "</td><td>".
           05 neAssistsOutput          pic zz9.
           05 filler                   pic x(9)      value "</td><td>".
           05 neBlocksOutput           pic zz9.
           05 filler                   pic x(10)     value "</td></tr>".
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
           display "<title>Men's Basketball Stats</title>".
           display 
           "<link rel=stylesheet type='text/css' href='cobol.css'>".
           display "</head>".

           display "<body>".
           call "getPostData".
           move function getPostValue("class") to xProcessName.

       200-processing.
           display "<h2>Basketball stats for the ", xProcessName, 
           " class: </h2>".
           display "<table>".
           display xOutput.
           perform 210-loop until xEofFlag = "y".
           display "</table>".
           display "<h2>Average number of points per ", xProcessName, 
           " player: ", neAvgPointsOutput.

       210-loop.
           read infile
               at end 
                   move "y" to xEofFlag
               not at end
                   if xPlayerClass = xProcessName
                       perform 220-display
                   end-if,
           end-read.

       220-display.
           move function concatenate(function trim(xLastName), 
           ".jpg") to xOutPic.
           move nJerseyNum to neJerseyNumOutput.
           move function concatenate(function trim(xFirstName), " ", 
           xLastName) to xPlayerNameOutput.
           move function concatenate(function trim(xHometown),", ", 
           xState) to xHometownOutput.
           move nPoints to nePointsOutput.
           move nRebounds to neReboundsOutput.
           move nAssists to neAssistsOutput.
           move nBlocks to neBlocksOutput.

           add nPoints to nAvgPoints.
           add 1 to nNumPlayers.
           compute neAvgPointsOutput = nAvgPoints / nNumPlayers.

           display xOutput1.

       300-termination.
           close infile.
           display "</body>".
           display "</html>".

           copy "postData-procedure.cbl".

