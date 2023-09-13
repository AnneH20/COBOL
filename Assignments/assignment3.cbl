      * Program: Assignment 3 - State Report

       identification division.
       program-id. States-01.
       author. Anne.
      
       environment division.
       input-output section.
       file-control.
           select infile assign to "States.txt" organization is line 
           sequential.
      
       data division.
       file section.
       fd infile.
       01  xInput.
           05 nStateNumber             pic 99.
           05 xStateAbrv               pic xx.
           05 xRegion                  pic x.
           05 xStateName               pic x(20).
           05 nPopulation              pic 9(8).
           05 nArea                    pic 9(6).
       working-storage section.
       77  xEofFlag                    pic x           value 'n'.
       77  nCounter                    pic 999         value 0.
       77  nTotalPopulation            pic 9(12)       value 0.
       77  nTotalArea                  pic 9(10)       value 0.

       01  xOutput.
           05 xStateNameOut            pic x(20).
           05 filler                   pic xx        value spaces.
           05 nePopulationOut          pic zz,999,999.
           05 filler                   pic x(5)        value spaces.
           05 neAreaOut                pic zzz,z99.
           05 filler                   pic xx          value spaces.
           05 neDensityOut             pic zz,zz9.99.

       01  xOutputHeading-1.
           05 filler                   pic x(10)       value 
           "State Name".
           05 filler                   pic x(12)       value spaces.
           05 filler                   pic x(12)       value 
           "Population".
           05 filler                   pic x(3)        value spaces.
           05 filler                   pic x(4)        value "Area".
           05 filler                   pic x(6)        value spaces.
           05 filler                   pic x(7)        value "Density".

       01  xOutputHeading-2.
           05 filler                   pic x(20)       value 
           "--------------------".
           05 filler                   pic xx          value spaces.
           05 filler                   pic x(10)       value 
           "----------".
           05 filler                   pic xx          value spaces.
           05 filler                   pic x(10)       value 
           "   -------".
           05 filler                   pic xx          value spaces.
           05 filler                   pic x(9)       value 
           " --------".

       01  xFooter.
           05 neCounter                pic z9.
           05 filler                   pic x(7)        value " states".
           05 filler                   pic x(12)       value spaces.       
           05 neTotalPopulation        pic 999,999,999.
           05 filler                   pic x(3)         value spaces.
           05 neTotalArea              pic 9,999,999.
           05 filler                   pic xx          value spaces.
           05 neDensity                pic zz,z99.99.
      
       procedure division. 
       000-main.
           perform 100-initialization.
           perform 200-loop until xEofFlag = 'y'.
           perform 300-termination.
           stop run.

       100-initialization.
           open input infile.
           display xOutputHeading-1.
           display xOutputHeading-2.

       200-loop.
           read infile
               at end 
                   move 'y' to xEofFlag,
               not at end
                   perform 210-processing,
           end-read.

       210-processing.
           move xStateName to xStateNameOut.
           move nPopulation to nePopulationOut.
           move nArea to neAreaOut.
           compute neDensityOut = nPopulation / nArea.
           display xOutput.
           add 1 to nCounter.           
           add nPopulation to nTotalPopulation.
           add nArea to nTotalArea.

       300-termination.
           close infile.
           display xOutputHeading-2.
           move nCounter to neCounter.
           move nTotalPopulation to neTotalPopulation.
           move nTotalArea to neTotalArea.
           compute neDensity = nTotalPopulation / nTotalArea.
           display xFooter.
      
      * Add a blank line at the end 
