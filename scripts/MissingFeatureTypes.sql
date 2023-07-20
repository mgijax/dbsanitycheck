\echo ''
\echo 'Missing feature types'
\echo ''
select m._marker_key, m.symbol, m._marker_type_key , t.name, u.login, m.modification_date
from mrk_marker m , mrk_types t, mgi_user u
where m._organism_key = 1 and m._marker_status_key in (1) and m._marker_type_key not in (2,6,8,10,12)
and m._marker_type_key = t._marker_type_key
and m._modifiedby_key = u._user_key
and not exists (select 1 from voc_annot a where a._annottype_key = 1011 and m._marker_key = a._object_key)
order by m._marker_type_key, m.symbol;
