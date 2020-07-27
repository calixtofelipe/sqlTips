create or replace directory test_dir as 'D:\ORACLE\test';

GRANT READ, WRITE ON DIRECTORY felipe_dir TO sankhya;

(select *
    from xmltable('/ROWSET/ROW'
           passing xmltype(bfilename('FELIPE_DIR', 'import.xml'), nls_charset_id('CHAR_CS'))
           columns empno  number(4)    path 'EMPNO',
                   ename  varchar2(10) path 'ENAME',
                   sal    number(7,2)  path 'SAL',
                   deptno number(2)    path 'DEPTNO'
         ))
         


 select m.*
from xmlTable
( XmlNamespaces(DEFAULT 'http://schemas.microsoft.com/project'),
'/Project/Tasks/Task'
passing xmltype(bfilename('FELIPE_DIR', 'Projeto_teste_integracaov002.xml'), nls_charset_id('UTF-8'))
Columns
IDTAREFA   VARCHAR2(8)  path  'UID',
IDSEQ        NUMBER(8)  path  'ID',
NAME       VARCHAR2(50) path 'Name',
CUSTO       NUMBER(8,2) path 'Cost'
) m