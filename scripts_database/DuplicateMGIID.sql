\echo ''
\echo 'Duplicate MGI IDs, excluding annotation evidence'
\echo ''
WITH mgiid AS
(
select accid from acc_accession
where _logicaldb_key = 1
and prefixpart = 'MGI:'
and _mgitype_key not in (25)
and preferred = 1
group by accid
having count(*) > 1
)
select a.*
from acc_accession a, mgiid m
where m.accid = a.accid;
