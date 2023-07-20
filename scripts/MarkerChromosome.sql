\echo ''
\echo 'Markers with no "assigned" by history'
\echo ''
select m.*
from MRK_Marker m
where m._organism_key = 1
and not exists (select 1 from MRK_Chromosome c where m.chromosome = c.chromosome);
