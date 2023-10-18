      * Program: Exam 3 - Fresh Food Menu

       identification division.
       program-id. States-06.
       author. Anne.

       environment division.
       input-output section.
       file-control.
           select inFile assign to "FreshFoodMenu.txt" organization is
           line sequential.
       
       data division.
       file section.
       fd  inFile.
       01  xInput.
           05 xFoodInput       pic x(25).
           05 xDeptInput       pic x(16).
           05 nCaloriesInput   pic 9(4).
           05 xMenuInput       pic x(6).

       working-storage section.
       77  xEofFlag            pic x           value 'n'.
       77  nLoadSubscript      pic 9999        value 0.
       77  nProcessSubscript  pic 9999.
       77  nFoodCount          pic 99.
       77  xOldDept            pic x(16).
       77  nTotalCalories      pic 9(5)        value 0.

       01  xOutput.
           05 xMenuOutput      pic x(6).
           05 filler           pic x(5)       value spaces.
           05 xFoodOutput      pic x(25).
           05 filler           pic x(5)       value spaces.
           05 xDeptOutput      pic x(16).
           05 filler           pic x(5)       value spaces.
           05 neCaloriesOutput  pic zzz9.

       01  xOutputHeading.
           05 filler           pic x(4)        value "MENU".
           05 filler           pic x(7)       value spaces.
           05 filler           pic x(9)        value "MENU ITEM".
           05 filler           pic x(21)       value spaces.
           05 filler           pic x(10)       value "DEPARTMENT".
           05 filler           pic x(10)       value spaces.
           05 filler           pic x(8)        value "CALORIES".

       01  xControl.
           05 filler           pic x(2)        value spaces.
           05 neFoodCount      pic z9.
           05 filler           pic x(14)       value " items in the ".
           05 xDeptCont        pic x(25).
           05 filler           pic xx          value spaces.
           05 neAvgCalories    pic zzz.99.
           05 filler           pic x(17)         
           value " average calories".

       01  xFreshTable.
           05 xFreshElement occurs 31 times.
               10 xFoodElement      pic x(25).
               10 xDeptElement      pic x(16).
               10 nCaloriesElement  pic 9(4).
               10 xMenuElement      pic x(6).

       procedure division.
       000-main.
           perform 100-initialization.
           perform 200-process.
           perform 300-termination.
           stop run.

       100-initialization.
           open input inFile.
           display xOutputHeading.
           perform 110-read-file until xEofFlag = "y".
           close inFile.

       110-read-file.
           read inFile
               at end 
                   move "y" to xEofFlag,
               not at end 
                   add 1 to nLoadSubscript,
                   move xFoodInput to xFoodElement(nLoadSubscript),
                   move xDeptInput to xDeptElement(nLoadSubscript),
                   move nCaloriesInput to 
                   nCaloriesElement(nLoadSubscript),
                   move xMenuInput to xMenuElement(nLoadSubscript),
               end-read.

       200-process.
           sort xFreshElement on descending key xDeptElement.
           perform 210-output varying nProcessSubscript from 1 by 1
           until nProcessSubscript > nLoadSubscript.

       210-output.
           if nFoodCount = 0
               move xDeptElement(nProcessSubscript) to xOldDept
           end-if.

           if xDeptElement(nProcessSubscript) not = xOldDept
               perform 220-control,
           end-if.

           move xMenuElement(nProcessSubscript) to xMenuOutput.
           move xFoodElement(nProcessSubscript) to xFoodOutput.
           move xDeptElement(nProcessSubscript) to xDeptOutput, 
           xOldDept.
           move nCaloriesElement(nProcessSubscript) to
           neCaloriesOutput.
           display xOutput.
           add nCaloriesElement(nProcessSubscript) to nTotalCalories.
           add 1 to nFoodCount.
           move function concatenate(function trim(xDeptOutput),
            " department") to xDeptCont.
           
       220-control.
           move nFoodCount to neFoodCount.
           compute neAvgCalories = nTotalCalories / nFoodCount.
           display ' '.
           display xControl.
           display ' '.
           move 0 to nFoodCount, nTotalCalories.

       300-termination.
           perform 220-control.

      * Add a blank line at the end
      
