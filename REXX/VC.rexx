/*REXX*/                                                                
ADDRESS ISREDIT                                                         
"ISREDIT MACRO"                                                         
ARG LINER                                                               
PARSE VAR LINER TYP MEM .                                               
SAY MEM                                                                 
ADDRESS ISPEXEC                                                         
                                                                        
     IF TYP = 'P' THEN                                                  
        P2 = SCLM.PROD.PROC                                             
                                                                        
     IF TYP = 'J' THEN                                                  
        P2 = SCLM.PROD.JCL                                              
                                                                        
     IF TYP = 'C' THEN                                                  
        P2 = SCLM.PROD.COPYBOOK                                         
                                                                        
     IF TYP = 'PR' THEN                                                 
        P2 = SCLM.PROD.PARM                                             
                                                                        
     IF TYP = 'PG' THEN                                                 
        P2 = SCLM.PROD.SOURCE                                           
                                                                        
     IF TYP = 'ZJ' THEN                                                 
        P2 = ZEKE.OPP1.JCL.CNTL                                         
                                                                        
     IF TYP = 'CL' THEN                                                 
        P2 = SCLM.PROD.COMPLIST                                         
                                                                        
     Y = LISTDSI("'"P2"'")                                              
     IF SYSREASON = 0                                                   
     THEN "VIEW DATASET ('"P2"("MEM")')"                                
     ELSE ZEDLMSG = 'MEMBER DOES NOT EXIST'                             
     "ISPEXEC SETMSG MSG(ISRZ001)"                                      