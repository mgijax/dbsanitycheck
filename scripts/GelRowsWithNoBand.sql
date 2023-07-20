\echo ''
\echo 'Gel rows with no Gel bands'
\echo ''
select r.*
from gxd_gelrow r
where not exists (select 1 from gxd_gelband b
                  where r._gelrow_key = b._gelrow_key);
