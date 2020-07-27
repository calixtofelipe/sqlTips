CREATE DIRECTORY admin AS 'oracle/admin';

ORACLE_HOME

impdp  treina/[password]@ORCL  DIRECTORY = ORACLE_HOME  DUMPFILE = bkp_1900_Qua.dmp  LOGFILE = sh_imp.log REMAP_SCHEMA=PRD:TEST  TABLES = PRD.TABLE_A  REMAP_TABLE = TABLE_A:TABLE_B;


CREATE OR REPLACE DIRECTORY dir_install AS '/install';

SELECT * FROM ALL_DIRECTORIES

expdp scott/tiger@db10g schemas=SCOTT directory=TEST_DIR dumpfile=SCOTT.dmp logfile=expdpSCOTT.log

impdp teste/[senha_secreta] directory=dir_install dumpfile=SCOTT.dmp logfile=imptrevo.log remap_schema=PRD:TEST