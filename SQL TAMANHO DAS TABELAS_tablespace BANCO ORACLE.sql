
--tamanho das tabelas
select table_name,
      decode(partitioned,'/','NO',partitioned) partitioned,
      num_rows,
      data_mb,
      indx_mb,
      lob_mb,
      total_mb
       from 
       (select data.table_name,
               partitioning_type
              || decode (subpartitioning_type,
                         'none', null,
                         '/' || subpartitioning_type)
                     partitioned,
              num_rows,
              nvl(data_mb,0) data_mb,
              nvl(indx_mb,0) indx_mb,
              nvl(lob_mb,0) lob_mb,
              nvl(data_mb,0) + nvl(indx_mb,0) + nvl(lob_mb,0) total_mb
              from (  select table_name,
                    nvl(min(num_rows),0) num_rows,
                    round(sum(data_mb),2) data_mb
                       from (select table_name, num_rows, data_mb
                           from (select a.table_name,
                                 a.num_rows,
                                 b.bytes/1024/1024 as data_mb
                                   from user_tables a, user_segments b
                                   where a.table_name = b.segment_name))
                  group by table_name) data,
                  (  select a.table_name,
                         round(sum(b.bytes/1024/1024),2) as indx_mb
                      from user_indexes a, user_segments b
                        where a.index_name = b.segment_name
                     group by a.table_name) indx,
                  (  select a.table_name,
                        round(sum(b.bytes/1024/1024),2) as lob_mb
                     from user_lobs a, user_segments b
                    where a.segment_name = b.segment_name
                     group by a.table_name) lob,
                    user_part_tables part
              where     data.table_name = indx.table_name(+)
                    and data.table_name = lob.table_name(+)
                    and data.table_name = part.table_name(+)
                    ) where total_mb > 100 
  order by total_mb desc;

select sum(bytes) /1073741824  TAMANHO_GB from dba_segments;

select *   
from dba_tablespace_usage_metrics   
--where tablespace_name in ('TBS_01', 'TBS_02', 'TBS_03')   
order by 1;

select tablespace_name, sum(bytes) / 1024 / 1024 / 1024 tamanho_GB from dba_segments group by tablespace_name;


SELECT STAT.OWNER AS "Schema proprietário",
         STAT.TABLE_NAME AS "Nome do objeto",
         STAT.OBJECT_TYPE AS "Tipo do objeto",
         STAT.NUM_ROWS AS "Quant. de Linhas",
         STAT.LAST_ANALYZED AS "Última coleta das estatísticas"
    FROM SYS.DBA_TAB_STATISTICS STAT
   WHERE STAT.OWNER NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
ORDER BY LAST_ANALYZED;


rodar estatisticas

execute dbms_stats.gather_schema_stats('[SQUEMA_NAME]',granularity => 'ALL', cascade => TRUE, block_sample => TRUE); 

