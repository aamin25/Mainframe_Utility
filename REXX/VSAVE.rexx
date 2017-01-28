/*REXX*/                                             
"ISREDIT MACRO"                                      
"ISPEXEC CONTROL ERRORS RETURN"                      
X = MSG("OFF")                                       
  "ISREDIT (PDSNAME) = DATASET"                      
  "ISREDIT (MEMNAME) = MEMBER"                       
    VPDS = "'"PDSNAME"("MEMNAME")'"                  
                                                     
     Y = LISTDSI("'"PDSNAME"'")                      
     IF SYSDSORG = "PO" THEN                         
        DO                                           
        "ISREDIT REPL .ZF .ZL " MEMNAME              
        IF RC = 0 THEN                               
           ZEDLMSG = MEMNAME 'SAVED!'                
        ELSE                                         
           ZEDLMSG = MEMNAME 'NOT SAVED!'            
           "ISPEXEC SETMSG MSG(ISRZ001)"             
        END                                          
     ELSE                                            
        DO                                           
        "ISREDIT REPL .ZF .ZL " "'"PDSNAME"'"        
        IF RC = 0 THEN                               
           ZEDLMSG = MEMNAME 'SAVED!'                
        ELSE                                         
           ZEDLMSG = MEMNAME 'NOT SAVED!'            
           "ISPEXEC SETMSG MSG(ISRZ001)"             
        END                                          