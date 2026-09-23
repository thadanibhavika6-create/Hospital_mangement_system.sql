CREATE TABLE Patients_New (
    patient_id INT PRIMARY KEY,
    name VARCHAR(50),
    dob DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(15),
    address VARCHAR(100),
    registration_date DATE
);
CREATE TABLE Doctors_New (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(50),
    specialization VARCHAR(50),
    consultation_fee INT,
    experience_years INT
);

CREATE TABLE Appointments_New (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients_New(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors_New(doctor_id)
);

CREATE TABLE Medical_Records_New (
    record_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis VARCHAR(100),
    prescription VARCHAR(100),
    treatment_date DATE,
    admission_date DATE,
    discharge_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients_New(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors_New(doctor_id)
);

CREATE TABLE Billing_Neww (
    invoice_id INT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    amount INT,
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients_New(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments_New(appointment_id)
);

CREATE TABLE Dept (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE Doctor_Department_New (
    doctor_id INT,
    department_id INT,
    PRIMARY KEY (doctor_id, department_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors_New(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Dept(department_id)
);


-- 2. INSERT DATA
INSERT INTO Patients_New VALUES
(1,'Alice','1995-04-12','Male','9876500001','Ahmedabad','2025-01-10'),
(2,'Bob','2000-07-20','Female','9876500002','Ahmedabad','2026-01-15'),
(3,'Charlie','1998-02-18','Female','9876500003','Gandhinagar','2026-03-10'),
(4,'Johan','1989-09-05','Male','9876500004','Surat','2024-08-20'),
(5,'Carol','2002-12-11','Female','9876500005','Ahmedabad','2026-02-05');

INSERT INTO Doctors_New VALUES
(1,'Dr. Amit','Cardiology',1500,18),
(2,'Dr. Neha','Neurology',1800,12),
(3,'Dr. Rohan','Dermatology',1200,7),
(4,'Dr. Priya','Orthopedics',1600,16),
(5,'Dr. Isha','Pediatrics',1000,4);

INSERT INTO Appointments_New VALUES
(101,1,1,'2026-01-10','Completed'),
(102,2,2,'2026-02-15','Completed'),
(103,3,3,'2026-03-05','Scheduled'),
(104,4,1,'2026-04-15','Completed'),
(105,5,4,'2026-05-11','Cancelled');

INSERT INTO Medical_Records_New VALUES
(201,1,1,'Heart Checkup','Medicine A','2026-01-10','2026-01-10','2026-01-12'),
(202,2,2,'Migraine','Medicine B','2026-02-15','2026-02-15','2026-02-16'),
(203,3,3,'Acne','Cream C','2026-03-05','2026-03-05','2026-03-06'),
(204,4,1,'Blood Pressure','Medicine D','2026-04-15','2026-04-15','2026-04-18'),
(205,5,4,'Knee Pain','Medicine E','2026-05-11','2026-05-11','2026-05-14'),
(206,1,3,'Skin Allergy','Cream F','2026-06-10','2026-06-10','2026-06-11');

INSERT INTO Billing_Neww VALUES
(301,1,101,1500,'Paid','2026-01-10'),
(302,2,102,1800,'Paid','2026-02-15'),
(303,3,103,1200,'Pending',NULL),
(304,4,104,1500,'Paid','2026-04-15'),
(305,5,105,1600,'Cancelled',NULL);

INSERT INTO Dept VALUES
(1,'Cardiology'),
(2,'Neurology'),
(3,'Dermatology'),
(4,'Orthopedics'),
(5,'Pediatrics');

INSERT INTO Doctor_Department_New VALUES
(1,1),(2,2),(3,3),(4,4),(5,5);


-- CRUD

INSERT INTO Patients_New
VALUES (6,'Pooja','1997-03-21','Female','9876500006','Ahmedabad','2026-09-20');

INSERT INTO Doctors_New VALUES
(6,'Dr. Raj','General Medicine',900,3);

INSERT INTO Appointments_New VALUES
(110,6,6,'2025-01-15','Cancelled');

UPDATE Patients_New
SET address='Maninagar'
WHERE patient_id=6;

DELETE FROM Appointments_New
WHERE status = 'Cancelled'
AND appointment_date < CURRENT_DATE - INTERVAL '6 months';

-- WHERE, HAVING, LIMIT

SELECT *
FROM Patients_New
WHERE registration_date >= CURRENT_DATE - INTERVAL '1 year';

SELECT patient_id,
       SUM(amount) AS total_spent
FROM Billing_Neww
GROUP BY patient_id
ORDER BY total_spent DESC
LIMIT 5;

SELECT *
FROM Doctors_New
WHERE consultation_fee > 1000;


-- AND, OR, NOT

SELECT *
FROM Appointments_New
WHERE status='Scheduled' AND doctor_id=3;

SELECT *
FROM Doctors_New
WHERE specialization='Cardiology'
OR specialization='Neurology';

SELECT *
FROM Appointments_New
WHERE NOT status='Completed';


--ORDER BY, GROUP BY

SELECT *
FROM Doctors_New
ORDER BY specialization;

SELECT doctor_id, COUNT(*) AS total_patients
FROM Appointments_New
GROUP BY doctor_id;

SELECT dep.department_name,
       SUM(b.amount) AS total_revenue
FROM Dept dep
JOIN Doctor_Department_New dd
    ON dep.department_id = dd.department_id
JOIN Doctors_New d
    ON dd.doctor_id = d.doctor_id
JOIN Appointments_New a
    ON d.doctor_id = a.doctor_id
JOIN Billing_Neww b
    ON a.appointment_id = b.appointment_id
GROUP BY dep.department_name;

-- AGGREGATE FUNCTIONS
SELECT SUM(amount) AS total_revenue
FROM Billing_Neww
WHERE payment_status = 'Paid';

SELECT doctor_id, COUNT(*) AS total_visits
FROM Appointments_New
GROUP BY doctor_id
ORDER BY total_visits DESC
LIMIT 1;

SELECT AVG(consultation_fee) AS average_fee
FROM Doctors_New;

--JOINS

-- INNER JOIN
SELECT d.name AS doctor_name, dep.department_name
FROM Doctors_New d
INNER JOIN Doctor_Department_New dd
ON d.doctor_id=dd.doctor_id
INNER JOIN Dept dep
ON dd.department_id=dep.department_id;

-- LEFT JOIN
SELECT p.name, a.appointment_id
FROM Patients_New p
LEFT JOIN Appointments_New a
ON p.patient_id=a.patient_id;

-- RIGHT JOIN
SELECT a.appointment_id, b.amount
FROM Billing_Neww b
RIGHT JOIN Appointments_New a
ON b.appointment_id=a.appointment_id;

-- FULL OUTER JOIN
SELECT p.name, a.appointment_id
FROM Patients_New p
FULL OUTER JOIN Appointments_New a
ON p.patient_id=a.patient_id;


-- SUBQUERIES

SELECT doctor_id, name
FROM Doctors_New
WHERE doctor_id IN
(
    SELECT doctor_id
    FROM Appointments_New
    GROUP BY doctor_id
    HAVING COUNT(DISTINCT patient_id) > 50
);

SELECT patient_id, name
FROM Patients_New
WHERE patient_id =
(
    SELECT patient_id
    FROM Billing_Neww
    GROUP BY patient_id
    ORDER BY SUM(amount) DESC
    LIMIT 1
);

-- Dermatology doctor appointments
SELECT *
FROM Appointments_New
WHERE doctor_id IN
(
    SELECT doctor_id
    FROM Doctors_New
    WHERE specialization='Dermatology'
);

--DATE & TIME FUNCTIONS

SELECT EXTRACT(MONTH FROM appointment_date) AS month,
       COUNT(*) AS visits
FROM Appointments_New
GROUP BY EXTRACT(MONTH FROM appointment_date);

SELECT record_id,
       discharge_date - admission_date AS stay_days
FROM Medical_Records_New;

SELECT TO_CHAR(treatment_date,'DD-MM-YYYY') AS treatment_date
FROM Medical_Records_New;


--STRING FUNCTIONS

SELECT UPPER(name)
FROM Patients_New;

SELECT TRIM(name)
FROM Doctors_New;

SELECT COALESCE(phone_number,'Not Available')
FROM Patients_New;


--WINDOW FUNCTIONS
SELECT doctor_id,
       COUNT(DISTINCT patient_id) AS total_patients,
       RANK() OVER (ORDER BY COUNT(DISTINCT patient_id) DESC) AS doctor_rank
FROM Appointments_New
GROUP BY doctor_id;

SELECT TO_CHAR(payment_date, 'YYYY-MM') AS month,
       SUM(amount) AS revenue,
       SUM(SUM(amount)) OVER (
           ORDER BY TO_CHAR(payment_date, 'YYYY-MM')
       ) AS cumulative_revenue
FROM Billing_Neww
WHERE payment_status = 'Paid'
GROUP BY TO_CHAR(payment_date, 'YYYY-MM')
ORDER BY month;

SELECT appointment_id,
       appointment_date,
       COUNT(*) OVER (
           ORDER BY appointment_date
       ) AS running_total
FROM Appointments_New
ORDER BY appointment_date;

--CASE

SELECT p.name,
       COUNT(m.record_id) AS records,
       CASE
           WHEN COUNT(m.record_id) > 5 THEN 'High'
           WHEN COUNT(m.record_id) BETWEEN 3 AND 5 THEN 'Medium'
           ELSE 'Low'
       END AS patient_risk_level
FROM Patients_New p
LEFT JOIN Medical_Records_New m
ON p.patient_id=m.patient_id
GROUP BY p.patient_id,p.name;

SELECT name,
       experience_years,
       CASE
           WHEN experience_years > 15 THEN 'Senior'
           WHEN experience_years BETWEEN 5 AND 15 THEN 'Mid-Level'
           ELSE 'Junior'
       END AS category
FROM Doctors_New;