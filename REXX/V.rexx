/*REXX*/                                                                
ADDRESS ISREDIT                                                         
"ISREDIT MACRO"                                                         
"(LINER) = LINE .ZCSR"                                                  
PARSE VAR LINER WRD1 WRD2 WRD3 WRD4 .                                   
PARSE VAR WRD3 PRT1 ',' PRT2 .                                          
ADDRESS ISPEXEC                                                         
OUT1 = POS('DSN=',PRT1)                                                 
OUT2 = POS('DSN=',PRT2)                                                 
                                                                        
     IF OUT1 = 1                                                        
     THEN PARSE VAR PRT1 P1 '=' P2                                      
                                                                        
     IF OUT2 = 1                                                        
     THEN PARSE VAR PRT2 P1 '=' P2                                      
                                                                        
     Y = LISTDSI("'"P2"'")                                              
     IF SYSREASON = 0                                                   
     THEN "VIEW DATASET ('"P2"')"                                       
     ELSE ZEDLMSG = 'MEMBER DOES NOT EXIST'                             
     "ISPEXEC SETMSG MSG(ISRZ001)"                                      