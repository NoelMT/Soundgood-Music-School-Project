select instructor_id ,extract(month from datum) as month, extract(year from datum) as year,count(instructor_id) as antal
from lestot
where extract(month from datum) = extract(month from current_date) 
and extract(year from datum) = extract(year from current_date) 
group by instructor_id,extract(month from datum),extract(year from datum) 
having count(*) > 0;


 -- Räcker det med en average som inkluderar alla lektioner??


 --filter (where extract(month from datum) = extract(month from current_date)) > 0;