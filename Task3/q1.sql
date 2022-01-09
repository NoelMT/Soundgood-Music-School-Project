

        SELECT 'This is single lessons per month in year 2021';
select extract(MONTH from lesson.datum) AS MONTH,
 extract(year from datum) AS year,  
 count(*) from lesson where extract(year from datum) = 2021 group by extract(MONTH from datum), extract(year from datum);

        SELECT 'This is group lessons per month in year 2021';
 select extract(MONTH from datum) AS MONTH,
 extract(year from datum) AS year,  
 count(*) from group_lesson where extract(year from datum) = 2021 
 group by extract(MONTH from datum), extract(year from datum);

        select 'This is ensamble lessons per month in year 2021';
select extract(MONTH from datum) AS MONTH, extract(year from datum) AS year, count(*)
from ensemble 
where extract(year from datum) = 2021 
group by extract(MONTH from datum), extract(year from datum);

    SELECT 'This is table with all lessons per month in year 2021';
select extract(MONTH from datum) AS MONTH, extract(year from datum) AS year, count(*)
from lestot  
where extract(year from datum) = 2021 
group by extract(MONTH from datum), extract(year from datum);
 


 --select extract(MONTH from l.datum) AS MONTH,
 --extract(year from l.datum) AS year,  
 --count(*) from lesson as l left join ensemble as e on l.instructor_id = e.instructor_id left join group_lesson as g on l.instructor_id = g.instructor_id group by extract(MONTH from l.datum), extract(year from l.datum);

--select count(*) from lesson as l inner join ensemble as e on l.instructor_id = e.instructor_id inner join group_lesson as g on e.instructor_id = g.instructor_id;


--The same as above, but retrieve the average 
--number of lessons per month during the entire
--year, instead of the total for each month.