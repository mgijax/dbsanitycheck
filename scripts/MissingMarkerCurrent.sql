\echo ''
\echo 'Missing mrk_current records'
\echo ''
select m._marker_key, m.symbol, substring(m.name,14,length(m.name)) as currentname
from mrk_marker m
where m._organism_key = 1
and m.name like 'withdrawn, = %'
and not exists (select 1 from mrk_current c where m._marker_key = c._marker_key);
