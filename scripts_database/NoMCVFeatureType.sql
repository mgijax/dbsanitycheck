\echo ''
\echo 'Mouse markers with no MCV/marker feature type'
\echo ''
select m.* from mrk_marker m
where m._organism_key = 1
and m._marker_status_key = 1
and m._marker_Type_key = 1
and not exists (select 1 from voc_annot a where m._marker_key = a._object_key and a._annottype_key = 1011);
