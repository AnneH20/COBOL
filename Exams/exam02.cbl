      * Program: Exam 2 - Newspaper Table

       identification division.
       program-id. Newspapers.
       author. Anne.

       environment division.
       input-output section.
       file-control.
           select inFile assign to "Newspapers.txt" organization is line 
           sequential.

       data division.
       file section.
       fd  inFile.
       01  xInput.
           05 xPaperInput                   pic x(21).
           05 xCityInput                    pic x(15).
           05 xStateInput                   pic xx.
           05 nReadersInput                 pic 9(7).
           05 nPaperFoundInput              pic 9(4).

       working-storage section.
       77  xEofFlag                    pic x           value 'n'.
       77  nLoadSubscript              pic 9999        value 0.
       77  nProccessSubscript          pic 9999.
       77  nYear                       pic 9(4).
       77  neYear                      pic 9(4).
       77  nNum                        pic 99          value 0.
       77  neNum                       pic z9.

       01  xOutputHeader.
           05 xTitle                   pic x(5)        value 'Title'.
           05 filler                   pic x(20)       value spaces.
           05 xCity                    pic x(4)        value 'City'.
           05 filler                   pic x(22)        value spaces.
           05 xFounded                 pic x(7)        value 'Founded'.
           05 filler                   pic x(5)        value spaces.
           05 xCirculation             pic x(11)        
           value 'Circulation'.

       01  xOutput.
           05 xTitleOutput             pic x(21).
           05 filler                   pic x(4)        value spaces.
           05 xCityOutput              pic x(20).
           05 filler                   pic x(6)        value spaces. 
           05 neFoundYearOutput        pic 9(4).
           05 filler                   pic x(8)        value spaces.
           05 neCirculationOutput      pic 9(7).

       01  xNewspaperTable.
           05 xNewspaperElement occurs 32 times.
               10 xPaperElement            pic x(21).
               10 xCityElement             pic x(15).
               10 xStateElement            pic xx.
               10 nReadersElement          pic 9(7).
               10 nPaperFoundElement       pic 9(4).    

       procedure division.
       000-main.
           perform 100-initialization.
           perform 200-report.
           perform 300-termination.
           stop run.
       
       100-initialization.
           open input inFile.
           perform 110-next-record until xEofFlag = "y".
           close inFile.

       110-next-record.
           read inFile
               at end
                   move "y" to xEofFlag,
               not at end 
                   add 1 to nLoadSubscript,
                   move xPaperInput to xPaperElement(nLoadSubscript),
                   move xCityInput to xCityElement(nLoadSubscript),
                   move xStateInput to xStateElement(nLoadSubscript),
                   move nReadersInput to 
                   nReadersElement(nLoadSubscript),
                   move nPaperFoundInput to 
                   nPaperFoundElement(nLoadSubscript),
               end-read.
       
       200-report.
           display " ".
           display "Please enter the earliest year " with no advancing.
           display "a newspaper was founded: ".
           accept nYear.
           display " ".
           display xOutputHeader.
           if nYear not = 0
               perform 210-search varying nProccessSubscript from 1 by 1
               until nProccessSubscript > nLoadSubscript,
           end-if.

       210-search.
           if nPaperFoundElement(nProccessSubscript) >= nYear
               move xPaperElement(nProccessSubscript) to xTitleOutput,              
               move function concatenate(function 
               trim(xCityElement(nProccessSubscript)), ", ", 
               xStateElement(nProccessSubscript)) to xCityOutput,
               move nPaperFoundElement(nProccessSubscript) to 
               neFoundYearOutput,
               move nReadersElement(nProccessSubscript) to 
               neCirculationOutput,
               add 1 to nNum,
               display xOutput,
           end-if.

       300-termination.
           display " ".
           move nNum to neNum.
           move nYear to neYear.
           display neNum with no advancing.
           display " newspapers founded after ", neYear.
           display " ".

      * Add blank line at the end

