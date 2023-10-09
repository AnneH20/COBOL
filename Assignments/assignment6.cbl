      * Program: Assignment 6 - East vs. West

       identification division.
       program-id. States-06.
       author. Anne.

       environment division.
       input-output section.
       file-control.
           select inFile assign to "States.txt" organization is line 
           sequential.

       data division.
       file section.
       fd  inFile.
       01  xInput.
           05 nStateNumberInput             pic 99.
           05 xStateAbrvInput               pic xx.
           05 xRegionInput                  pic x.
           05 xStateNameInput               pic x(20).
           05 nPopulationInput              pic 9(8).
           05 nAreaInput                    pic 9(6).

       working-storage section.
       77  xEofFlag                         pic x           value 'n'.
       77  nLoadSubscript                   pic 9999        value 0.
       77  nProccessSubscript               pic 9999.
       77  nTotalArea                       pic 9(10)       value 0.
       77  nTotalPopulation                 pic 9(12)       value 0.    

       01  xOutput.
           05 xRegionOutput                 pic x.
           05 xStateNameOutput              pic x(20).
           05 nePopulationOutput            pic 9(8).
           05 neAreaOutput                  pic 9(6).
           05 neDensityOutput               pic 9(4).99.

       01  xStateTable.
           05 xStateElement occurs 51 times.
               10 xRegionElement            pic x.
               10 xStateNameElement         pic x(20).
               10 nPopulationElement        pic 9(8).
               10 nAreaElement              pic 9(6).
               10 nDensityElement           pic 9(4)v99.

       procedure division.
       000-main.
           perform 100-initialization.
           perform 200-process.
           perform 300-termination.
           stop run.

       100-initialization.


       110-read-file.


       120-load-table.


       200-process.


       300-termination.
       
      

      * Add a blank line at the end 
