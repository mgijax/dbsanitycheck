\echo ''
\echo 'Note with > 1 row per object'
\echo ''
select _mgitype_key, _notetype_key, _object_key, note
into temp dupnotes
from mgi_note
group by _mgitype_key, _notetype_key, _object_key, note
having count(*) > 1
;

select n._note_key, n._object_key, n._mgitype_key, n._notetype_key, substring(n.note, 1, 50), n._createdby_key, n.creation_date, n._modifiedby_key, n.modification_date
from dupnotes d,
mgi_note n
where d._mgitype_key = n._mgitype_key
and d._notetype_key = n._notetype_key
and d._object_key = n._object_key
and d.note = n.note;
