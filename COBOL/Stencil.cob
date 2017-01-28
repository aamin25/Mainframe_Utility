       IDENTIFICATION DIVISION.
       PROGRAM-ID.   STENCIL.
      *AUTHOR.       AAMIN KHAN.
      *DATE-WRITTEN. XXX 2015
      *DATE-COMPILED.
      *----------------------------------------------------------------*
      *  PURPOSE: SAMPLE LAYOUT                                        *
      *                                                                *
      *                                                                *
      *                                                                *
      *                                                                *
      *  INPUT FILE(S):                      COPYBOOK(S):              *
      *                                                                *
      *                                                                *
      *                                                                *
      *                                                                *
      *                                                                *
      *  OUTPUT FILE(S):                                               *
      *                                                                *
      *                                                                *
      *                                                                *
      *  REPORT(S):                                                    *
      *                                                                *
      *    NA                                                          *
      *                                                                *
      *----------------------------------------------------------------*
      *----------------------------------------------------------------*
      *---------------------- LOG OF CHANGES --------------------------*
      *----------------------------------------------------------------*
      * MM/DD/YY | AUTHOR | ICR-XXXXX   |        DESCRIPTION
      *          |        | INFRA-XXXXX |
      *          |        |             |
      *          |        |             |
      *          |        |             |
      *----------------------------------------------------------------*
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

      *------> DRIVER FILE
           SELECT ARSTR-SORT-FILE    ASSIGN       TO ARSORTFL
                                     ORGANIZATION IS SEQUENTIAL
                                     ACCESS MODE  IS SEQUENTIAL
                                     FILE STATUS  IS ARSTR-SORT-STATUS.

      *------> OUTPUT FILE
           SELECT ARSTR-DBS-FILE     ASSIGN       TO ARDBSFL
                                     ORGANIZATION IS INDEXED
                                     ACCESS MODE  IS DYNAMIC
                                     RECORD KEY   IS ARDBS-KEY
                                     FILE STATUS  IS ARSTR-DBS-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD  ARSTR-SORT-FILE
           LABEL RECORDS OMITTED
           BLOCK CONTAINS 0 RECORDS
           DATA RECORD IS ARSTR-SORT-RECORD.
           COPY ARSUMREC.

       FD  ARSTR-DBS-FILE
           LABEL RECORDS OMITTED
           BLOCK CONTAINS 0 RECORDS
           DATA RECORD IS ARSTR-DBS-RECORD.
           COPY ARDBSHOE.



       WORKING-STORAGE SECTION.

      *----------------------------------------------------------------*
      * CONSTANTS
      *----------------------------------------------------------------*

       01 PROGRAM-NAME                    PIC X(08) VALUE 'STENCIL'.
       01 ARABEND                         PIC X(07) VALUE 'ARABEND'.

      *----------------------------------------------------------------*
      * FILE STATUS
      *----------------------------------------------------------------*

       01 ARDBSTR-STATUS                  PIC X(02).
          88 ARSTR-DBS-OKAY                         VALUE '00'.
          88 ARSTR-DBS-OKAY                         VALUE '10'.

       01 ARSTR-SORT-STATUS               PIC X(02).
          88 ARSTR-SORT-OKAY                        VALUE '00'.
          88 ARSTR-SORT-EOF                         VALUE '10'.

      *----------------------------------------------------------------*
      * COUNTERS
      *----------------------------------------------------------------*

       01 WS-STENCIL-RCDS-READ            PIC 9(07) VALUE ZEROES.
       01 WS-STENCIL-RCDS-WRITE           PIC 9(07) VALUE ZEROES.
       01 WS-STENCIL-RCDS-BYPASSED        PIC 9(07) VALUE ZEROES.

      *----------------------------------------------------------------*
      * KEYS
      *----------------------------------------------------------------*


      *----------------------------------------------------------------*
      * VARIABLES
      *----------------------------------------------------------------*


      *----------------------------------------------------------------*
      *  FLAGS
      *----------------------------------------------------------------*

       01 WS-RCD-STATUS-FLAG-DBS          PIC X(01) VALUE SPACE.
             88 WS-RCD-FND-DBS                      VALUE 'Y'.
             88 WS-RCD-NT-FND-DBS                   VALUE 'N'.

       01 WS-RCD-STATUS-FLAG-RATE         PIC X(01) VALUE SPACE.
             88 WS-RCD-FND-RATE                     VALUE 'Y'.
             88 WS-RCD-NT-FND-RATE                  VALUE 'N'.

      *----------------------------------------------------------------*
      * SYSDATE STORAGE
      *----------------------------------------------------------------*

       COPY SYSDISPW.

      *----------------------------------------------------------------*
      *             P R O C E D U R E    D I V I S I O N               *
      *----------------------------------------------------------------*

       PROCEDURE DIVISION.

       0000-MAIN-CONTROL.

           PERFORM 1000-INITIALIZATION        THRU 1000-EXIT
           PERFORM 2000-PROCESS-DATA          THRU 2000-EXIT
             UNTIL ARSTR-SORT-EOF
           PERFORM 9000-TERMINATION           THRU 9000-EXIT

           STOP RUN.

       0000-EXIT.
           EXIT.


       1000-INITIALIZATION.

           COPY SYSDISPP.
           INITIALIZE  WS-FILE-WRITE
                       WS-SUMMARY-RECORD
           MOVE ZEROS      TO WS-STENCIL-RCDS-BYPASSED
           PERFORM 1100-OPEN-FILE             THRU 1100-EXIT
           PERFORM 1200-READ-SORT-FILE        THRU 1200-EXIT.

       1000-EXIT.
           EXIT.

       1100-OPEN-FILE.

           OPEN INPUT ARSTR-SORT-FILE

           EVALUATE ARSTR-SORT-STATUS
              WHEN ARSTR-SORT-OKAY
                 CONTINUE
              WHEN OTHER
                 DISPLAY '**************************************'
                 DISPLAY '* STENCIL   -                        *'
                 DISPLAY '* ERROR ON ARSORTFL (OPEN)           *'
                 DISPLAY '* FILE STATUS: ' ARSTR-SORT-STATUS
                 DISPLAY '* PARA: 1100-OPEN-FILES              *'
                 DISPLAY '**************************************'
                 CALL ARABEND
           END-EVALUATE

           OPEN OUTPUT ARSTR-DBS-FILE

           EVALUATE ARSTR-DBS-STATUS
              WHEN ARSTR-DBS-OKAY
                 CONTINUE
              WHEN OTHER
                 DISPLAY '**************************************'
                 DISPLAY '* STENCIL   -                        *'
                 DISPLAY '* ERROR ON ARDBSFL  (OPEN)           *'
                 DISPLAY '* FILE STATUS: ' ARSTR-DBS-STATUS
                 DISPLAY '* PARA: 1100-OPEN-FILES              *'
                 DISPLAY '**************************************'
                 CALL ARABEND
           END-EVALUATE


       1100-EXIT.
           EXIT.

       2000-PROCESS-DATA.
		  


       2000-EXIT.
           EXIT.


       3000-RECORD-BYPASSED.

             DISPLAY '-----------------------------------------------'
             DISPLAY '              RECORD BYPASSED                  '
             DISPLAY '-----------------------------------------------'
             DISPLAY 'XXXXXXXXXXXXXXX       : '    XXXXXXXXXXXXXXX
             DISPLAY 'XXXXXXXXXXXXXXX       : '    XXXXXXXXXXXXXXX
             DISPLAY 'XXXXXXXXXXXXXXX       : '    XXXXXXXXXXXXXXX
             DISPLAY 'XXXXXXXXXXXXXXX       : '    XXXXXXXXXXXXXXX
             DISPLAY 'XXXXXXXXXXXXXXX       : '    XXXXXXXXXXXXXXX
             DISPLAY 'XXXXXXXXXXXXXXX       : '    XXXXXXXXXXXXXXX
             DISPLAY '-----------------------------------------------'
             DISPLAY 'RECORD NUMBER         : '   WS-STENCIL-RCDS-READ
             DISPLAY '-----------------------------------------------'.

       3000-EXIT.
           EXIT.

       4000-WRITE-OUT-FILE.

           MOVE WS-FILE-WRITE TO ARSTRT-OUT-RECORD

           WRITE ARSTRT-OUT-RECORD

           EVALUATE ARSTR-OUT-STATUS
              WHEN ARSTR-DBS-OKAY
                 ADD 1 TO WS-STENCIL-RCDS-WRITE
              WHEN OTHER
                 DISPLAY '****************************************'
                 DISPLAY '* STENCIL  -                           *'
                 DISPLAY '* ERROR ON AROUTFL  (WRITE)            *'
                 DISPLAY '* FILE STATUS: ' ARSTR-OUT-STATUS
                 DISPLAY '* PARA: 4000-WRITE-OUT-FILE            *'
                 DISPLAY '****************************************'
                 CALL ARABEND
           END-EVALUATE.




       4000-EXIT.
            EXIT.

       9000-TERMINATION.

           DISPLAY '--------------------------------------------------'
           DISPLAY '*         S T E N C I L   T O T A L S            *'
           DISPLAY '--------------------------------------------------'
           DISPLAY 'TOTAL INPUT RCDS PROCESSED   = '
                   WS-STENCIL-RCDS-READ
           DISPLAY 'TOTAL INPUT RCDS BYPASSED    = '
                   WS-STENCIL-RCDS-BYPASSED
           DISPLAY 'TOTAL RCDS WRITTEN ON FILE   = '
                   WS-STENCIL-RCDS-WRITE
           DISPLAY '--------------------------------------------------'


           CLOSE ARSTR-DBS-FILE

           EVALUATE ARSTR-DBS-STATUS
              WHEN ARSTR-DBS-OKAY
                 CONTINUE
              WHEN OTHER
                 DISPLAY '**************************************'
                 DISPLAY '* STENCIL   -                        *'
                 DISPLAY '* ERROR ON ARDBSFL  (CLOSE)          *'
                 DISPLAY '* FILE STATUS: ' ARSTR-DBS-STATUS
                 DISPLAY '* PARA: 9000-TERMINATION             *'
                 DISPLAY '**************************************'
                 CALL ARABEND
           END-EVALUATE.

           CLOSE ARSTR-SORT-FILE

           EVALUATE ARSTR-SORT-STATUS
              WHEN ARSTR-SORT-OKAY
                 CONTINUE
              WHEN OTHER
                 DISPLAY '**************************************'
                 DISPLAY '* STENCIL   -                        *'
                 DISPLAY '* ERROR ON ARSORTFL (CLOSE)          *'
                 DISPLAY '* FILE STATUS: ' ARSTR-SORT-STATUS
                 DISPLAY '* PARA: 9000-TERMINATION             *'
                 DISPLAY '**************************************'
                 CALL ARABEND
           END-EVALUATE.

       9000-EXIT.
           EXIT.
