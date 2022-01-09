select id as ensemble_id , datum ,genre,instructor_id,id,max_seats,
CASE 
WHEN  (max_seats - boked) = 0 
THEN 'full boked'

WHEN  (max_seats - boked) = 1 or (max_seats - boked) = 2 
THEN '1-2 seats left!'

WHEN  (max_seats - boked) > 2
THEN 'Seats left'

END
from ensemble 
inner join booked_students on ensemble.id = booked_students.ensemble_id
where DATE_PART('week', datum) = (CAST(to_char(current_date, 'WW') as INTEGER)+1)
order by genre, datum;


-- skapad view i update.sql

--CREATE VIEW booked_students AS
--SELECT ensemble_id, count(*) as boked
--FROM ensemble_students
--group by ensemble_id
--order by ensemble_id;

