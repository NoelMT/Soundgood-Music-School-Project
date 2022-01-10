
insert into student (personal_number, first_name, last_name, age, street, zip, city, id, main_instrument, total_lessons, aplication_id, total_ensembles, total_group_lessons) values ('608336704864', 'Sher', 'Rawsen', 9, '19 Scoville Hill', '3', 'Longgang', '3372', null, 1, '2213', 0, 0);
insert into student (personal_number, first_name, last_name, age, street, zip, city, id, main_instrument, total_lessons, aplication_id, total_ensembles, total_group_lessons) values ('165487277245', 'Elihu', 'Milburn', 29, '72462 Anthes Avenue', '6', 'Sukkozero', '3902', null, 2, '1260', 0, 0);
insert into student (personal_number, first_name, last_name, age, street, zip, city, id, main_instrument, total_lessons, aplication_id, total_ensembles, total_group_lessons) values ('774429691466', 'Allie', 'Nancekivell', 14, '82910 David Court', '193', 'Petaling Jaya', '1082', null, 1, '6065', 0, 0);
insert into student (personal_number, first_name, last_name, age, street, zip, city, id, main_instrument, total_lessons, aplication_id, total_ensembles, total_group_lessons) values ('828944401352', 'Vin', 'Muneely', 19, '38 Porter Center', '33837', 'Lukou', '8631', null, 1, '0948', 2, 1);
insert into student (personal_number, first_name, last_name, age, street, zip, city, id, main_instrument, total_lessons, aplication_id, total_ensembles, total_group_lessons) values ('859800086312', 'Elsinore', 'Van Hesteren', 28, '7364 Eliot Street', '8502', 'Gaocun', '7491', null, 2, '3854', 1, 1);

insert into instrument_renting(id,brand,is_rented,instrument,price,student_id) values ('1','yamaha',TRUE, 'piano',1200,'3372');
insert into instrument_renting(id,brand,is_rented,instrument,price,student_id) values ('2','pioner',TRUE, 'gitar',400,'3902');  --3902
insert into instrument_renting(id,brand,is_rented,instrument,price,student_id) values ('3','Arvada',FALSE, 'fiol',600,null);





insert into instructor (personal_number, first_name, last_name, age, id, street, zip, city, can_teach_ensemble) values ('997137283954', 'Beverlee', 'Gritsaev', 51, '2482', '20364 Spaight Place', '8164', 'Sanankerto', false);
insert into instructor (personal_number, first_name, last_name, age, id, street, zip, city, can_teach_ensemble) values ('405608868629', 'Ivory', 'Habbema', 26, '9367', '611 Hooker Road', '89', 'Huanshan', true);

insert into lesson (id, instructor_id, student_id, instrument, datum) values ('1',  '2482', '3372', 'piano', '2022-01-07');
insert into lesson (id, instructor_id, student_id, instrument, datum) values ('2',  '2482', '3902', 'piano', '2021-02-02');
insert into lesson (id, instructor_id, student_id, instrument, datum) values ('3',  '2482', '3902', 'piano', '2021-03-12');
insert into lesson (id, instructor_id, student_id, instrument, datum) values ('4', '2482', '1082', 'piano', '2021-04-18');
insert into lesson (id, instructor_id, student_id, instrument, datum) values ('5',  '9367', '8631', 'piano', '2021-06-09');
insert into lesson (id, instructor_id, student_id, instrument, datum) values ('6',  '9367', '7491', 'piano', '2021-10-10');
insert into lesson (id, instructor_id, student_id, instrument, datum) values ('7', '9367', '7491', 'piano', '2021-12-05');

insert into ensemble (id, level, genre, instructor_id, datum, max_seats) values ('3363', 'Advanced', 'gospel band', '9367', '2021-03-07', '1');
insert into ensemble (id, level, genre, instructor_id, datum, max_seats) values ('0126', 'Beginner', 'punk rock', '9367', '2022-01-20', '2'); --change date to any date in the next week to be able to test case
insert into ensemble (id, level, genre, instructor_id, datum, max_seats) values ('6590', 'Intermediate', 'punk rock', '9367', '2021-05-07', '5');

insert into ensemble_students(student_id, ensemble_id) values ('7491','0126');
insert into ensemble_students(student_id, ensemble_id) values ('8631','3363');
insert into ensemble_students(student_id, ensemble_id) values ('8631','6590');


insert into group_lesson (id, level, instructor_id, datum) values ('1', 'Beginner', '2482', '2021-02-07');
insert into group_lesson (id, level, instructor_id, datum) values ('2', 'Advanced', '9367', '2021-04-07');

insert into group_students(student_id, group_lesson_id) values ('8631','1');
insert into group_students(student_id, group_lesson_id) values ('7491','2');

UPDATE lesson SET instrument = 'piano';

-- quiry till instrumetn 
--select * from instrument_renting where is_rented = TRUE and instrument = 'piano';


/*
CREATE TABLE instrument_renting (
 id INT NOT NULL,
 brand VARCHAR(100),
 is_rented BOOLEAN NOT null, 
 instrument VARCHAR(100),
 price int,
 student_id INT 
);

*/