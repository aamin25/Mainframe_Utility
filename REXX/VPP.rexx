/*REXX*/                                     
ADDRESS ISREDIT                              
P2=SCLM.PROD.PROC                            
"ISREDIT MACRO"                              
"(LINER) = LINE .ZCSR"                       
PARSE VAR LINER WRD1 WRD2 WRD3 WRD4 .        
PARSE VAR WRD3 PRT1 '=' PRT2 ',' PRT3 .      
MEM = PRT2                                   
ADDRESS ISPEXEC                              
   Y = LISTDSI("'"P2"'")                     
     IF SYSREASON = 0                        
     THEN "VIEW DATASET ('"P2"("MEM")')"     
     ELSE ZEDLMSG = 'MEMBER DOES NOT EXIST'  
     "ISPEXEC SETMSG MSG(ISRZ001)"           