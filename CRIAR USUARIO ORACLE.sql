CREATE USER TREINA IDENTIFIED BY [password]
DEFAULT TABLESPACE [tablespaceName]
TEMPORARY TABLESPACE TEMP
/
GRANT RESOURCE, CONNECT TO TREINA
/
ALTER USER TREINA QUOTA UNLIMITED ON [tablespaceName]
/
ALTER USER TREINA QUOTA UNLIMITED ON [tablespaceName]
/
CONN SYS/[sys_password] as sysdba
GRANT SELECT ON V_$SESSION TO TREINA
/
GRANT SELECT ON DBA_TABLES  TO TREINA
/
GRANT CREATE SESSION TO TREINA
/
GRANT SELECT ON DBA_TAB_COLUMNS TO TREINA
/
GRANT SELECT ON DBA_CONSTRAINTS  TO TREINA
/
GRANT SELECT ON DBA_TRIGGERS TO TREINA
/
GRANT SELECT ON DBA_INDEXES TO TREINA
/
GRANT SELECT ON DBA_VIEWS  TO  TREINA
/
GRANT SELECT ON DBA_IND_COLUMNS TO TREINA
/
GRANT SELECT ON DBA_OBJECTS TO   TREINA
/
GRANT EXP_FULL_DATABASE TO TREINA
/
GRANT IMP_FULL_DATABASE TO TREINA
/

