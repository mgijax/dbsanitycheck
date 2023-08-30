\echo ''
\echo 'Annotations to obsolete terms'
\echo ''
select vat.name, a1.accid, vt.term, va.*
from voc_annot va, voc_term vt, voc_annottype vat, acc_accession a1
where va._term_key = vt._term_key
and vt.isobsolete = 1
and va._annottype_key = vat._annottype_key
and va._term_key = a1._object_key
and a1._mgitype_key = 13

;
