\echo ''
\echo 'Gel lanes using EMAPS term instead of EMAPA'
\echo ''
select a.accid, a._object_key, t._vocab_key, t.term , g.*
from voc_Term t, gxd_gellanestructure g, gxd_gellane l, acc_accession a
where g._emapa_term_key = t._term_key and t._vocab_key = 91
and g._gellane_key = l._gellane_key
and l._assay_key = a._object_key
and a._mgitype_key = 8;

\echo ''
\echo 'InSitu Results using EMAPS term instead of EMAPA'
\echo ''
select a.accid, a._object_key, t._vocab_key, t.term , g.*
from voc_Term t, gxd_isresultstructure g, gxd_insituresult r, gxd_specimen s, acc_accession a
where g._emapa_term_key = t._term_key and t._vocab_key = 91
and g._result_key = r._result_key
and r._specimen_key = s._specimen_key
and s._assay_key = a._object_key
and a._mgitype_key = 8
