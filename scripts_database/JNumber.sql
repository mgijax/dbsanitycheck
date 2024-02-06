\echo ''
\echo 'One JNumber with > 1 reference'
\echo ''
WITH jnum AS
(
select jnumid from bib_citation_cache group by jnumid having count(*) > 1
)
select b._refs_key, b.numericpart, b.jnumID
from bib_citation_cache b, jnum j
where j.jnumid = b.jnumid;

\echo ''
\echo 'One reference with > 1 JNumber'
\echo ''
WITH object AS
(
select _object_key from acc_accession where _mgitype_key = 1 and prefixpart = 'J:' group by _object_key having count(*) > 1
)
select a.*
from acc_accession a, object j
where j._object_key = a._object_key
and a._mgitype_key = 1
and a.prefixpart = 'J:';
