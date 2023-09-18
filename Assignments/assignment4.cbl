      * Program: Assignment 4 - Payroll Generator

       identification division.
       program-id. Payroll-01.
       author. Anne.
      
       environment division.
       input-output section.
       file-control.
           select inFile assign to "Payroll.master.txt" organization is
           line sequential.

           select transFile assign to "Payroll.transaction.txt"
           organization is line sequential.

           select outFile assign to "Payroll-01-output.txt" organization
           is line sequential.

       data division.
       file section.

       fd  inFile.
       01  xInRecord.
           05 nInDeptNum       pic 9.
           05 nInEmpNum        pic 9999.
           05 xInLastName      pic x(20).
           05 xInFirstName     pic x(20).
           05 nInPayRate       pic 999v99.

       fd  transFile.
       01  xTransRecord.
           05 nTransEmpNum     pic 9999.
           05 nTransEmpHrs     pic 999.

       fd  outFile.
       01  xOutRecord          pic x(80).

       working-storage section.
       77  xInEOF              pic x               value 'n'.
       77  xTransEOF           pic x               value 'n'.
       77  nEmpPay             pic 9(5)v99.        
       77  nEmpCount           pic 999             value 0.
       77  nHrsCount           pic 99999           value 0.
       77  nGrossCount         pic 9(7)v99         value 0.
       77  xBlankLine          pic x               value spaces.

       01  xOutputDetail.
           05 neDeptNum        pic 9.
           05 neEmpNum         pic 9999.
           05 xEmpName         pic x(40).
           05 neEmpHrs         pic 999.
           05 neEmpPay         pic $$$$9.99.

       01  xOutputHeading-1.
           05 filler           pic x(4)            value 'DEPT'.
           05 filler           pic x               value spaces.
           05 filler           pic (7)             value 'EMP NUM'.
           05 filler           pic x               value spaces.
           05 filler           pic x(8)            value 'EMP NAME'.
           05 filler           pic x(10)           value spaces.
           05 filler           pic x(7)            value 'EMP HRS'.
           05 filler           pic x               value spaces.
           05 filler           pic x(7)            value 'EMP PAY'.

       01  xOutputHeading-2.
           05 filler           pic x(4)            value '----'.
           05 filler           pic x               value spaces.
           05 filler           pic (7)             value '-------'.
           05 filler           pic x               value spaces.
           05 filler           pic x(8)            value '--------'.
           05 filler           pic x(10)           value spaces.
           05 filler           pic x(7)            value '-------'.
           05 filler           pic x               value spaces.
           05 filler           pic x(7)            value '-------'.       

       01  xFooter.
           05 neEmpCount       pic zz9.
           05 filler           pic x(14)           value ' employees'.
           05 neHrsCount       pic zzzz9.
           05 filler           pic x(15)           value ' hrs worked'.
           05 neGrossCount     pic $$$$$.99.
           05 filler           pic x(16)           value ' gross pay'.
       
       procedure division.
       000-main.
           perform 100-initialization.
           perform 200-loop until xInEOF = 'y'.
           perform 300-termination.
           stop run.       

      * Open Transaction File      
       100-initialization.
           open input transFile.
           display xOutputHeading-1.
           display xOutputHeading-2.
      * Read Transaction File
       200-loop.
           read transFile
               at end 
                   move 'y' to xTransEOF,
               not at end
                   perform 210-process,
           end-read.
      * Process Transaction file and Open Input File
       210-process.

       
      * Read Input File
       220-read-input.

       
      * Process Input File
       230-generate-detail.


      * Termination
       300-termination.

      * Add a blank line at the end 
          