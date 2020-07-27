Ocorreu um erro ao executar a operação solicitada:

ORA-13717: A Licença do Tuning Package é necessária para usar este recurso.
ORA-06512: em "SYS.PRVT_SMGUTIL", line 52
ORA-06512: em "SYS.PRVT_SMGUTIL", line 37
ORA-06512: em "SYS.DBMS_MANAGEMENT_PACKS", line 26
ORA-06512: em "SYS.DBMS_SQLTUNE", line 625
ORA-06512: em line 5
13717. 00000 -  "Tuning Package License is needed for using this feature."
*Cause:    The specified value for system parameter CONTROL_MANAGEMENT_PACK_ACCESS
           indicated that the Tuning Package was disabled.
*Action:   Modify the parameter value if the Tuning Package License was
           purchased.

Turns out the solution is simple
ALTER system SET CONTROL_MANAGEMENT_PACK_ACCESS='NONE';

SQL> ALTER system SET CONTROL_MANAGEMENT_PACK_ACCESS='DIAGNOSTIC+TUNING';
Don't forget the grant to your user

show parameter control_management_pack

select client_name,status from DBA_AUTOTASK_CLIENT;

SQL> GRANT advisor, administer SQL tuning SET,SELECT any dictionary TO &USER;

Ocorreu um erro ao executar a operação solicitada:

ORA-13605: Tarefa ou objeto staName60669 especificado(a) não existe para o usuário atual
ORA-06512: em "SYS.DBMS_SYS_ERROR", line 86
ORA-06512: em "SYS.PRVT_ADVISOR", line 5920
ORA-06512: em "SYS.DBMS_SQLTUNE", line 926
ORA-06512: em line 2
13605. 00000 -  "The specified task or object %s does not exist for the current user."  
*Cause:    The user attempted to reference an advisor task or object
           using a name that does not exist in the Advisor repository.
*Action:   Adjust the name and retry the operation.
Código de fornecedor 13605

https://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_sqltun.htm#CACIAHIH

DROP_SQL_PROFILE