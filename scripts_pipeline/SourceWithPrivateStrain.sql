\echo ''
\echo 'Sources that have a private strain'
\echo ''
select * from prb_source so
where exists (select 1 from prb_strain st
              where st._strain_key = so._strain_key and
                    st.private = 1);
