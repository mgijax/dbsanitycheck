\echo ''
\echo 'Annotations to obsolete terms'
\echo ''
select *
from voc_annot va, voc_term vt
where va._term_key = vt._term_key
and vt.isobsolete = 1;
