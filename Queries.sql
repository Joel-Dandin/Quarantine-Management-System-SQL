
/*1.Retrieve the type of the room and number of beds in it*/
select room_type,no_of_beds
from room;


/*2. Retrieve the name and phone number of the male patients */
select p.p_name,p.ph_no
from patient p
where p.sex='M' or p.sex='m';


/*3)Retrieve patient names,patient age and patient sex of patients who are in critical stage
Sol)*/
SELECT p.p_name,p.age,p.sex
FROM patient p,record r
WHERE p.p_id=r.Patient_Id and r.Description_patient='Critical'



/*4)Retrieve information of all female doctors
Sol)*/
SELECT e.*
FROM employee e, doctor d
WHERE e.e_id=d.employee_id and e.sex='F' or e.sex='f' 


/*5.Retrieve the total number of Patient in the Quarantine Hall(works)*/
SELECT COUNT (*) 
FROM Patient;






                                                    /*SET OPERATIONS*/

/*1. Retrieve the names of patients and the type of ventilator used*/
select p.p_name,v.v_type 
from patient p,ventilator v 
where p.ventilator_id=v.v_id;


/*2. Retrieve the name and salary of the receptionists working in quarantine hall*/
select e.e_name,e.slaray
from employee e,receptionist r
where e.e_id=r.employee_id;


/*3)Retrieve names of all people(employee,patients,donors) in quarantine hall
Sol)*/
SELECT e_name FROM employee
UNION 
SELECT p_name FROM patient
UNION 
SELECT donor_name FROM plasma_donor


/*4)Retrieve names of patients who are also plasma doners
Sol)*/
SELECT p_name FROM patient
INTERSECT
SELECT donor_name FROM Plasma_donor


/*5. Retrieve names of patients and donors*/
select p_name
from patient 
UNION
select Donor_Name
from Plasma_Donor;




                                              /*AGGREGATE*/ 
                                                  

1. Retrieve the maximum, minimum and average working hours of employees*/
select sum(working_hours),max(working_hours),min(working_hours)
from employee;


/*2. Retrieve all the information of doctors whose working hours is more than 5*/
select d.doctor_id,e.e_name,e.slaray,e.working_hours
from doctor d,employee e
where d.employee_id=e.e_id and e.working_hours>5;


/*3)Retrieve center id,number of employees in each center and average working_hours of centre where the average working hours of employees is more than 7 hours in descending order of average working hours
SOl)*/
SELECT e.centre_id,count(e.centre_id),round(cast(AVG(e.working_hours) as float),2)
FROM employee e,quarantine_hall q
WHERE e.centre_id=q.center_id
GROUP BY centre_id
HAVING (AVG(e.working_hours)>7)
ORDER BY(AVG(e.working_hours))desc


/*4)Retrieve quantitys of all Rh+ve blood(A+ve,B+ve,O+ve) donated
SOl)*/
SELECT bloog_group,sum(quantity)
FROM plasma_donor
WHERE bloog_group='A+' or bloog_group='B+' or bloog_group='O+' 
GROUP BY bloog_group


/*5. Retrieve the details of doctor whose age is more than 25 and salary more than 1,00,000*/
select *
from doctor d,employee e
where e.e_id=d.employee_id and e.slaray>100000 and e.e_age>25




                                             /* NESTED*/

/*1)Retrieve details of doctors who treat patients of age more than 30
SOl)*/
SELECT e.*
FROM employee e
WHERE e.e_id in
(SELECT d.employee_id 
FROM doctor d
WHERE d.doctor_id in
(SELECT p.doctor_id 
FROM patient p
WHERE p.age>30))


/*2)Retrieve details of centres which has employees having average salary more than average salary of all employees
SOL)*/
SELECT *
FROM quarantine_hall q
WHERE q.center_id in (SELECT c.centre_id
FROM employee c
where c.slaray>(SELECT avg(e.slaray)
FROM employee e ))

/*3)Retrieve id,name,ventilator_id of patients who are using mechanical ventilators
SOL)*/
SELECT p.p_id,p.p_name,p.ventilator_id
FROM patient p
where p.ventilator_id in
(SELECT v.v_id
 from ventilator v
 where v.v_type='mechanical')
 
/*4)Retrieve details of nurse having maximum salary among all nurses
SOL)*/
SELECT * 
FROM employee e
where e.slaray=
(SELECT MAX(d.slaray)
 FROM employee d
 where d.e_id in
 (SELECT r.employee_id
  FROM nurse r))


/*5)Retrieve patient name and condition of patients who are not plasma donors
SOL)*/
SELECT p.p_name,r.description_patient
FROM patient p,record r
where p.p_id=r.patient_id and p.p_name NOT IN 
(SELECT c.donor_name
 from plasma_donor c,patient d
 where c.donor_name=d.p_name)



		                                       /* VIEWS AND JOINS*/

/*1)Retrieve all doctor's details along with their speciality.
SOL)*/
CREATE VIEW employee_doc AS
SELECT a.*,b.specialization
FROM employee a,doctor b
WHERE a.e_id=b.employee_id

SELECT * FROM employee_doc

/*2) Select only doctor_id,doctor_name and specialization of doctors who have specialization
SOL)*/
SELECT d.e_id,d.e_name,p.specialization
FROM employee d
INNER JOIN doctor p
ON d.e_id = p.employee_id;


/*3)Retrieve patient's id,name,age,sex,corona_report and description.
SOL)*/
CREATE VIEW patient_record AS
SELECT a.p_id,a.p_name,a.age,a.sex,b.corona_report,b.description_patient
FROM patient a,record b
WHERE a.p_id=b.patient_id

SELECT * FROM patient_record

/*4)Select only all patient names and all descriptions.
SOL)*/
SELECT d.p_name,p.description_patient
FROM patient d
FULL OUTER JOIN record p
ON d.p_id = p.patient_id;

/*5)Retrieve details of all rooms along with id of nurses incharge 
SOL)*/
CREATE VIEW room_nurse AS
SELECT a.*,b.nurse_id
FROM room a,nurse b
WHERE a.room_id=b.room_id

SELECT * FROM  room_nurse;