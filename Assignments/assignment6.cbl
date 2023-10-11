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
       77  nTotalStateCount                 pic 99          value 0.
       77  neTotalStateCount                pic z9.

       77  nStateCount              pic 99.
       77  xOldRegion                       pic x.  

       01  xOutput.
           05 xRegionOutput               pic x.
           05 filler                      pic x(13)        value spaces.
           05 xStateNameOutput            pic x(20).
           05 filler                      pic x(5)        value spaces.
           05 nePopulationOutput          pic zz,999,999.
           05 filler                      pic x(5)        value spaces.
           05 neAreaOutput                pic zzz,z99.
           05 filler                      pic x(4)        value spaces.
           05 neDensityOutput             pic zz,zzz.99.

       01  xOutputHeading-1.
           05 filler                   pic x(11)       value 
           "Region Code".
           05 filler                   pic x(3)        value spaces.
           05 filler                   pic x(10)       value 
           "State Name".
           05 filler                   pic x(15)       value spaces.
           05 filler                   pic x(12)       value 
           "Population".
           05 filler                   pic x(3)        value spaces.
           05 filler                   pic x(4)        value "Area".
           05 filler                   pic x(8)        value spaces.
           05 filler                   pic x(7)        value "Density".

       01  xOutputHeading-2.
           05 filler                   pic x(12)       value 
           "-----------".
           05 filler                   pic xx          value spaces.
           05 filler                   pic x(20)       value 
           "--------------------".
           05 filler                   pic x(5)        value spaces.
           05 filler                   pic x(10)       value 
           "----------".
           05 filler                   pic xx          value spaces.
           05 filler                   pic x(10)       value 
           "   -------".
           05 filler                   pic x(4)        value spaces.
           05 filler                   pic x(9)        value 
           " --------".
       
       01  xControl.
           05 neStateCount             pic z9.
           05 filler                   pic x(8)        value " states ".
           05 filler                   pic x(28)       value spaces.
           05 neTotalPopulation        pic zzz,999,999.
           05 filler                   pic x(3)       value spaces.
           05 neTotalArea              pic z,zzz,999.
           05 filler                   pic x(4)       value spaces.
           05 neDensity                 pic zz,zz9.99.


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
           open input inFile.
           display xOutputHeading-1.
           display xOutputHeading-2.
           perform 110-read-file until xEofFlag = "y".
           close inFile.

       110-read-file.
           read inFile
               at end
                   move "y" to xEofFlag,
               not at end 
                   add 1 to nLoadSubscript,
                   move xRegionInput to xRegionElement(nLoadSubscript),
                   move xStateNameInput to 
                   xStateNameElement(nLoadSubscript),
                   move nPopulationInput to 
                   nPopulationElement(nLoadSubscript),
                   move nAreaInput to nAreaElement(nLoadSubscript),
                   divide nPopulationInput by nAreaInput giving 
                   nDensityElement(nLoadSubscript),
           end-read.      

       200-process.          
           sort xStateElement on descending key xStateNameElement.
           sort xStateElement on descending key xRegionElement.
           perform 210-output varying nProccessSubscript from 
           nLoadSubscript by -1,
           until nProccessSubscript < 1.

       210-output.
           if nStateCount = 0
              move xRegionElement(nProccessSubscript) to xOldRegion
           end-if.

           if xRegionElement(nProccessSubscript) not = xOldRegion
               perform 220-control,
           end-if.
           
           add 1 to nTotalStateCount.
           move xRegionElement(nProccessSubscript) to xRegionOutput,
           xOldRegion. 
         
           move xStateNameElement(nProccessSubscript) to 
           xStateNameOutput.
           move nPopulationElement(nProccessSubscript) to 
           nePopulationOutput.
           move nAreaElement(nProccessSubscript) to neAreaOutput.
           move nDensityElement(nProccessSubscript) to neDensityOutput.

           add nPopulationElement(nProccessSubscript) to 
           nTotalPopulation.
           move nTotalPopulation to neTotalPopulation.
           add nAreaElement(nProccessSubscript) to nTotalArea.
           move nTotalArea to neTotalArea.
           compute neDensity = nTotalPopulation / nTotalArea.
           display xOutput.
           add 1 to nStateCount.

       220-control.
           move nStateCount to neStateCount.      
           display ' '.
           display xControl.
           display ' '.
           move 0 to nStateCount, nTotalPopulation, nTotalArea.

       300-termination.
           perform 220-control.

      * Add a blank line at the end 
