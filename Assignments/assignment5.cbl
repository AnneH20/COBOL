      * Program: Assignment 4 - Payroll Generator

       identification division.
       program-id. Capitals-01.
       author. Anne.

       environment division.
       input-output section.
       file-control.
           select inFile assign to "Capitals.txt" organization is line 
           sequential.

       data division.
       file section.
       fd  inFile.
       01  xInput.
           05 xStateAbrrInput          pic x(2).
           05 xCapitalNameInput        pic x(14).
           05 nPopulationInput         pic 9(7).
           05 nFoundYearInput          pic 9(4).
           05 nPopRankInput            pic 9(2).

       working-storage section.
       77  xEofFlag                    pic x           value 'n'.
       77  nLoadSubscript              pic 9999        value 0.
       77  nProccessSubscript          pic 9999.
       77  nMinimum                    pic 9(8).
       77  nNum                        pic 99          value 0.
       77  neNum                       pic z9.

       01  xOutputHeader.
           05 filler                   pic x(4)        value spaces.
           05 xCapital                 pic x(7)        value 'Capital'.
           05 filler                   pic x(16)       value spaces.
           05 xPopulation              pic x(10)       
           value 'Population'.
           05 filler                   pic x(4)        value spaces.
           05 xFounded                 pic x(7)        value 'Founded'.
           05 filler                   pic x(4)        value spaces.
           05 xRank                    pic x(4)        value 'Rank'.

       01  xOutput.
           05 filler                   pic x(6)        value spaces.
           05 xState                   pic x(18).
           05 filler                   pic x(6)        value spaces.
           05 nePopulationOutput       pic 9(7).
           05 filler                   pic x(6)        value spaces. 
           05 neFoundYearOutput        pic 9(4).
           05 filler                   pic x(6)        value spaces.
           05 nePopRankOutput          pic 9(2).

       01  xCapitalTable.
           05 xCapitalElement occurs 50 times.
               10 xStateAbrr           pic x(2).
               10 xCapitalName         pic x(14).
               10 nPopulation          pic 9(7).
               10 nFoundYear           pic 9(4).
               10 nPopRank             pic 9(2).      

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
                   move xStateAbrrInput to xStateAbrr(nLoadSubscript),
                   move xCapitalNameInput to 
                   xCapitalName(nLoadSubscript),
                   move nPopulationInput to nPopulation(nLoadSubscript),
                   move nFoundYearInput to nFoundYear(nLoadSubscript),
                   move nPopRankInput to nPopRank(nLoadSubscript),
           end-read.

       200-report.
           display " ".
           display "Minimum Population? " with no advancing.
           accept nMinimum.
           display " ".
           display xOutputHeader.
           if nMinimum not = 0
               perform 210-search varying nProccessSubscript from 1 by 1
               until nProccessSubscript > nLoadSubscript,
           end-if.

       210-search.
           if nPopulation(nProccessSubscript) >= nMinimum
               move function concatenate(function 
               trim(xCapitalName(nProccessSubscript)), ", ", 
               xStateAbrr(nProccessSubscript)) to xState,

               move nPopulation(nProccessSubscript) to 
               nePopulationOutput,
               move nFoundYear(nProccessSubscript) to neFoundYearOutput,
               move nPopRank(nProccessSubscript) to nePopRankOutput,
               add 1 to nNum,
               display xOutput,
           end-if.

       300-termination.
           display " ".
           move nNum to neNum.
           display "Number of Capitals Processed:  ", neNum.
           display " ".

      * Add blank line at the end

