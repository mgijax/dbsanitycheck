\echo ''
\echo 'Insitu results with EMAPA term key referring to EMAPS term'
\echo ''
select isr.*, t.term
from gxd_isresultstructure isr, voc_term t
where isr._emapa_term_key = t._term_key
and t._vocab_key = 91;
