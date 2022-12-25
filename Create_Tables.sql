Create table Record
(
	Record_Id int primary key,
	Corona_Report varchar(3),
	Date_Addmission date,
	Description_patient varchar(200),
	Patient_Id int,
	Receptionist_Id int
);

create table Quarantine_hall
(
    Center_Id int primary key,
    Capacity int ,
    Address varchar(50)
);


create table Doctor
(
    Doctor_Id int primary key,
    employee_id int,
    Specialization varchar(50)
);


create table Receptionist
(
    Receptionist_Id int primary key,
    employee_id int,
    Desk_Number int
);


create table Nurse
(
    Nurse_Id int primary key,
    employee_id int,
    Room_Id int
);

Create table Plasma_Donor
(
	Donor_Id int primary key,
	Bloog_Group varchar(3),
	Donor_Name varchar(30),
	Patient_Id int,
	Quantity int
);

Create table Room
(
	Room_id int primary key,
	no_of_beds int,
	room_type varchar(10)
);

create table patient
(
  p_id int constraint pkey primary key,
  p_name varchar(20),
  age int,
  ph_no char(10),
  sex char,
  address varchar(30),
  ventilator_id int,
  room_id int,
  doctor_id int
);

create table ventilator
(
    v_id int constraint vke primary key,
    v_type varchar(10)
);



create table employee
(
    e_id int  constraint empke primary key,
    e_name varchar(20),
    e_age int,
    slaray int,
    sex char,
    working_hours float,
    centre_id int
);

alter table Doctor
add constraint fp_doc_emp
foreign key(employee_id) references employee(e_id);

alter table employee
add constraint fp_emp_cent
foreign key(centre_id) references quarantine_hall(Center_Id);

alter table receptionist
add constraint fp_rec_emp
foreign key(employee_id) references employee(e_id);

alter table Nurse
add constraint fp_nur_emp
foreign key(employee_id) references employee(e_id);

alter table Nurse
add constraint fp_nur_room
foreign key(Room_Id) references Room(Room_id);

alter table Patient
add constraint fp_pat_vent
foreign key(ventilator_id) references ventilator(v_id);

alter table Patient
add constraint fp_pat_room
foreign key(room_id) references room(room_id);

alter table Patient
add constraint fp_pat_doc
foreign key(doctor_id) references doctor(doctor_id);

alter table Record
add constraint fp_reco_rec
foreign key(Receptionist_Id) references Receptionist(Receptionist_Id);

alter table Record
add constraint fp_reco_pat
foreign key(Patient_Id) references Patient(p_id);

alter table Plasma_Donor
add constraint fp_dono_pat
foreign key(Patient_Id) references Patient(p_id);
