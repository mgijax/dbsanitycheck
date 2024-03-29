\echo ''
\echo 'Null or empty ACC_Accession.accid'
\echo ''
select a.*
from acc_accession a
where a.accid is null or a.accid = ''
;
