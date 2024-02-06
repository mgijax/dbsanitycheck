\echo ''
\echo 'Strains with MGI ID (preferred=0) but no MGI ID (preferred=1)'
\echo ''
select a._accession_key, a.accid, a.creation_date, a.preferred, a._object_key, s.strain
from acc_accession a , prb_strain s
where a._mgitype_key = 10
and a._logicaldb_key = 1
and a.preferred = 0
and a._object_key = s._strain_key
and not exists
   (select 1 from acc_accession aa where aa._mgitype_key = 10 and aa._logicaldb_key = 1 and aa.preferred = 1 and a._object_key = aa._object_key)
order by s.strain;
