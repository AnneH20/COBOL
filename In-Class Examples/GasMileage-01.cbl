       
       identification division.
       program-id. GasMileageCalculator.

       environment division.
       
       data division.
       working-storage section.

       77  nInputMiles         pic 99999.
       77  nInputGallons       pic 999v9.
       77  neOutputMPG         pic zz9.99.

       procedure division.

           display " ".
           display "Please enter miles driven: ".
           accept nInputMiles.
       
           display " ".
           display "Please enter number of gallons: ".
           accept nInputGallons.

           compute neOutputMPG = nInputMiles / nInputGallons.

           display "You drove ", neOutputMPG, " miles per gallon".
           stop run.
           