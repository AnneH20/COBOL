      * Program: Assignment 4 - Payroll Generator

       identification division.
       program-id. Payroll-01.
       author. Anne.
      
       environment division.
       input-output section.
       file-control.
           select inFile assign to "Payroll.transaction.txt"
           organization is line sequential.          
           
           select masterFile assign to "Payroll.master.txt" organization is
           line sequential.

           select outFile assign to "Payroll-01-output.txt" organization
           is line sequential.

       data division.
       file section.
       fd  inFile.
       01  xTransaction.
           05 nEmpNumIn        pic 9999.
           05 nHoursWorked     pic 999.

       fd  masterFile.
       01  xInput.
           05 nDeptNum         pic 9.
           05 nEmpNumMstr      pic 9999.
           05 xLastName      pic x(20).
           05 xFirstName     pic x(20).
           05 nPayRate       pic 999v99.

       fd  outFile.
       01  xOutput          pic x(80).
       working-storage section.
       77  xEofFlagTX          pic x               value 'n'.
       77  xEofFlagMaster      pic x               value 'n'.
       77  nCounter            pic 999             value 0.
       77  nTotalHours         pic 999.
       77  nGrossPay           pic 9999v99         value 0.
       77  nGrossCount         pic 9999v99         value 0.

       01  xOutputDetail.
           05 neDeptNum        pic 9.
           05 filler           pic x(4)            value spaces.
           05 neEmpNum         pic 9999.
           05 filler           pic x(4)            value spaces.
           05 xEmpName         pic x(20).
           05 filler           pic x(8)           value spaces.
           05 neHoursWorked    pic zz9.
           05 filler           pic x(5)            value spaces.
           05 neGrossPay       pic $$$9.99.

       01  xOutputHeading-1.
           05 filler           pic x(4)            value 'DEPT'.
           05 filler           pic x               value spaces.
           05 filler           pic x(7)            value 'EMP NUM'.
           05 filler           pic x               value spaces.
           05 filler           pic x(8)            value 'EMP NAME'.
           05 filler           pic x(20)           value spaces.
           05 filler           pic x(7)            value 'EMP HRS'.
           05 filler           pic x               value spaces.
           05 filler           pic x(7)            value 'EMP PAY'.

       01  xOutputHeading-2.
           05 filler           pic x(4)            value '----'.
           05 filler           pic x               value spaces.
           05 filler           pic x(7)            value '-------'.
           05 filler           pic x               value spaces.
           05 filler           pic x(8)            value '--------'.
           05 filler           pic x(20)           value spaces.
           05 filler           pic x(7)            value '-------'.
           05 filler           pic x               value spaces.
           05 filler           pic x(7)            value '-------'.       

       01  xFooter.
           05 neEmpCount       pic zz9.
           05 filler           pic x(14)           value ' employees'.
           05 neHrsCount       pic zzzz9.
           05 filler           pic x(15)           value ' hrs worked'.
           05 neGrossCount     pic $$,$$$.99.
           05 filler           pic x(16)           value ' gross pay'.
       
       procedure division.
       000-main.
           perform 100-initialization.
           perform 200-loop until xEofFlagTX = 'y'.
           perform 300-termination.
           stop run.       

      * Open Transaction File      
       100-initialization.
           open input inFile.
           open output outFile.
           write xOutput from xOutputHeading-1 before advancing 1 
           line.
           write xOutput from xOutputHeading-2 before advancing 1 
           line.

      * Read Transaction File
       200-loop.
           read inFile
               at end 
                   move "y" to xEofFlagTX,
               not at end
                   perform 210-process,
           end-read.
      * Process Transaction file and Open Input File
       210-process.
           move "n" to xEofFlagMaster.
           open input masterFile.
           perform 220-read-master until xEofFlagMaster = "y".
           close masterFile.
       
      * Read Input File
       220-read-master.
           read masterFile
               at end
                   move "y" to xEofFlagMaster,
               not at end 
                   if nEmpNumIn = nEmpNumMstr
                       perform 230-generate-detail,
                       move "y" to xEofFlagMaster,
                   end-if,
               end-read.
       
      * Process Input File
       230-generate-detail.
           move nDeptNum to neDeptNum.
           move nEmpNumIn to neEmpNum.
           move function concatenate(function trim(xLastName), ", ", 
           xFirstName) to xEmpName.

           move nHoursWorked to neHoursWorked.

           compute neGrossPay = nHoursWorked * nPayRate.

           move neGrossPay to nGrossPay.
           
           add 1 to nCounter.
           move nCounter to neEmpCount.
           add nHoursWorked to nTotalHours.
           move nTotalHours to neHrsCount.

           add nGrossPay to nGrossCount.

           move nGrossCount to neGrossCount.

           write xOutput from xOutputDetail before advancing 1 line.

      * Termination
       300-termination.
           
           close inFile.

           write xOutput from xOutputHeading-2 before advancing 1 
           line.
           write xOutput from xFooter before advancing 1 line.

           close outFile.

      * Add a blank line at the end 
          
