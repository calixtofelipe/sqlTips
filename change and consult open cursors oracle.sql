select value from v$parameter where name = 'open_cursors';

alter system set open_cursors=4000;

select a.value, s.username, s.sid, s.serial#
from v$sesstat a, v$statname b, v$session s
where a.statistic# = b.statistic#
and s.sid = a.sid
and b.name = 'opened cursors current'
and s.username is not null;