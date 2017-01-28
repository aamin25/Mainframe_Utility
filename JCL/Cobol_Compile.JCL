//PR (accounting information)
//             'AAMIN',                                               
//             CLASS=Q,                                               
//             MSGCLASS=X,                                            
//             NOTIFY=&SYSUID                                         
//*                                                                    
//************************************************************        
//*  ENTERPRISE COBOL BATCH PROGRAM COMPILE AND LINK         *        
//*             SYSP.USER.PROCLIB(COBEUCL)                   *        
//************************************************************        
//*                                                                   
// SET SRC=PRPTOACR                                                   
//*                                                                    
//*                                                                   
//COMP    EXEC COBEUCL,                                               
//        PARM.COBOL='AWO,DATA(31),DYNAM,TEST(NOHOOK,SEPARATE,NOEJPD)',
//        PARM.LKED='LIST,XREF,LET,MAP,AMODE=(31),RMODE=(ANY)'        
//*                                                                   
//COBOL.SYSLIB   DD DISP=SHR,DSN=SCLM.PROD.COPYBOOK                   
//               DD DISP=SHR,DSN=OPP1.COPY.COBOL                       
//               DD DISP=SHR,DSN=OPP1.GEAC.COPY.COBOL                 
//               DD DISP=SHR,DSN=MILL.COPY                            
//*                                                                   
//COBOL.SYSIN    DD DISP=SHR,DSN=PRPT.L991494.SOURCE(&SRC)            
//*                                                                   
//COBOL.SYSDEBUG DD DISP=SHR,DSN=PRPT.L991494.DBUGLIST(&SRC)          
//*                                                                    
//LKED.SYSLMOD   DD DISP=SHR,DSN=PRPT.L991494.LINKLIB(&SRC)           
//*                                                                   
//LKED.SYSLIB    DD                                                   
//               DD DISP=SHR,DSN=MILL.LOADLIB                         
//               DD DISP=SHR,DSN=OPP1.LINKLIB                         
//               DD DISP=SHR,DSN=SCLM.PROD.GEACOBJ   