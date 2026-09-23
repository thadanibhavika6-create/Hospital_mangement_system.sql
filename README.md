<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f3d3b,100:2f9e94&height=200&section=header&text=HOSPITAL%20MGMT%20SYSTEM&fontSize=40&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=Database%20Design%20%7C%20CRUD%20%7C%20Joins%20%7C%20Window%20Functions&descAlignY=58&descSize=18" width="100%"/>

<img src="https://readme-typing-svg.demolab.com/?lines=Patients+%E2%86%92+Doctors+%E2%86%92+Appointments+relational+design;CRUD+operations+in+pure+SQL;Joins%2C+subqueries+%26+window+functions;Portfolio-ready+hospital+analytics+queries&font=Fira+Code&center=true&width=650&height=45&color=2F9E94&vCenter=true&size=22&pause=1200"/>

<br/>

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Level](https://img.shields.io/badge/Level-Beginner--Intermediate-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

**🔴 [Open the live query explorer →](https://claude.ai/artifact/6NuoGCVjiosQTXdFQ5SRBz)**
<br/><sub>Every query in this README runs live on that page against the real dataset — click a query, watch the result compute.</sub>

</div>

---

## 📌 Project Overview

This project models the backend database of a **hospital management system**. It covers database design, CRUD operations, foreign-key relationships, joins, subqueries, window functions, and analytical queries across seven related tables — **Patients, Doctors, Appointments, Medical Records, Billing, Departments,** and the **Doctor–Department** mapping.

It's built as a complete, portfolio-ready reference for **DDL**, **DML**, and **analytical SQL** — every concept is demonstrated with a query that answers a real hospital-operations question, not a toy example.

<br/>

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0f3d3b,100:2f9e94&height=3&section=header" width="100%"/>
</div>

## 🗂️ Database Schema

### 1️⃣ `Patients_New`
| Column | Type | Description |
|---|---|---|
| patient_id | INT (PK) | Unique ID for each patient |
| name | VARCHAR(50) | Patient's name |
| dob | DATE | Date of birth |
| gender | VARCHAR(10) | Patient's gender |
| phone_number | VARCHAR(15) | Contact number |
| address | VARCHAR(100) | Patient's city/address |
| registration_date | DATE | Date the patient registered |

### 2️⃣ `Doctors_New`
| Column | Type | Description |
|---|---|---|
| doctor_id | INT (PK) | Unique ID for each doctor |
| name | VARCHAR(50) | Doctor's name |
| specialization | VARCHAR(50) | Field of specialization |
| consultation_fee | INT | Fee charged per consultation |
| experience_years | INT | Years of experience |

### 3️⃣ `Dept`
| Column | Type | Description |
|---|---|---|
| department_id | INT (PK) | Unique ID for each department |
| department_name | VARCHAR(50) | Name of the department |

### 4️⃣ `Doctor_Department_New`
| Column | Type | Description |
|---|---|---|
| doctor_id | INT (FK) | References `Doctors_New(doctor_id)` |
| department_id | INT (FK) | References `Dept(department_id)` |

### 5️⃣ `Appointments_New`
| Column | Type | Description |
|---|---|---|
| appointment_id | INT (PK) | Unique ID for each appointment |
| patient_id | INT (FK) | References `Patients_New(patient_id)` |
| doctor_id | INT (FK) | References `Doctors_New(doctor_id)` |
| appointment_date | DATE | Date of the appointment |
| status | VARCHAR(20) | Completed / Scheduled / Cancelled |

### 6️⃣ `Medical_Records_New`
| Column | Type | Description |
|---|---|---|
| record_id | INT (PK) | Unique ID for each record |
| patient_id | INT (FK) | References `Patients_New(patient_id)` |
| doctor_id | INT (FK) | References `Doctors_New(doctor_id)` |
| diagnosis | VARCHAR(100) | Diagnosis given |
| prescription | VARCHAR(100) | Prescribed medicine/treatment |
| treatment_date | DATE | Date of treatment |
| admission_date | DATE | Date admitted |
| discharge_date | DATE | Date discharged |

### 7️⃣ `Billing_Neww`
| Column | Type | Description |
|---|---|---|
| invoice_id | INT (PK) | Unique ID for each invoice |
| patient_id | INT (FK) | References `Patients_New(patient_id)` |
| appointment_id | INT (FK) | References `Appointments_New(appointment_id)` |
| amount | INT | Invoice amount |
| payment_status | VARCHAR(20) | Paid / Pending / Cancelled |
| payment_date | DATE | Date paid (nullable) |

**Relationships**
```
Patients_New 1───N Appointments_New N───1 Doctors_New N───N Dept
      │                    │                  (via Doctor_Department_New)
      ├───N Medical_Records_New
      └───N Billing_Neww N───1 Appointments_New
```

<br/>

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0f3d3b,100:2f9e94&height=3&section=header" width="100%"/>
</div>

## ⚙️ Features / Operations Covered

<table>
<tr>
<td width="50%" valign="top">

**🔹 CRUD Operations**
- Create all 7 tables with PK & FK constraints
- Insert seed + new records (patient, doctor, appointment)
- Retrieve with `SELECT` + `WHERE`
- Update a patient's address
- Delete stale cancelled appointments (date-driven)

</td>
<td width="50%" valign="top">

**🔹 Filtering & Sorting**
- Patients registered in the **last year**
- Doctors above a **fee threshold**
- `AND` / `OR` / `NOT` combinations
- Sort doctors by specialization

</td>
</tr>
<tr>
<td width="50%" valign="top">

**🔹 Aggregate Functions**
- `SUM()` for total revenue
- `COUNT()` for visits per doctor
- `AVG()` for average consultation fee
- Top-5 patients by total spend

</td>
<td width="50%" valign="top">

**🔹 Joins**
- `INNER JOIN` — doctors ↔ departments
- `LEFT JOIN` — patients ↔ appointments
- `RIGHT JOIN` — appointments ↔ billing
- `FULL OUTER JOIN` — patients ↔ appointments

</td>
</tr>
<tr>
<td width="50%" valign="top">

**🔹 Subqueries**
- Scalar subquery — highest-billed patient
- `IN (...)` subquery — Dermatology appointments
- `HAVING` inside a subquery — high-volume doctors

</td>
<td width="50%" valign="top">

**🔹 Window Functions & CASE**
- `RANK() OVER (...)` — doctors by patients seen
- Cumulative revenue by month
- Running total of appointments
- `CASE` — patient risk level & doctor seniority tier

</td>
</tr>
</table>

<br/>

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0f3d3b,100:2f9e94&height=3&section=header" width="100%"/>
</div>

## 🛠️ Tech Stack

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin-336791?style=flat-square&logo=postgresql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL_compatible*-4479A1?style=flat-square&logo=mysql&logoColor=white)

> ⚠️ **Note:** `CURRENT_DATE - INTERVAL '6 months'`, `TO_CHAR(...)`, and `EXTRACT(...)` are PostgreSQL syntax.
> For MySQL, the cleanup delete becomes:
> `WHERE appointment_date < CURDATE() - INTERVAL 6 MONTH;`

<br/>

## ▶️ How to Run

```bash
1. Open your SQL client (pgAdmin / DBeaver / psql)
2. CREATE DATABASE hospital_management;
3. Run Hospital_Managment_system.sql — it creates tables, inserts data,
   runs the CRUD block, and includes all 30 analytical queries
4. Check results in your SQL client's output panel
```

Prefer zero setup? Open the **[live query explorer](https://claude.ai/artifact/6NuoGCVjiosQTXdFQ5SRBz)** — every query runs there instantly against the same dataset.

<br/>

<div align="center">
<img src="https://capsule-render.vercel.app/api?type=rect&color=0:0f3d3b,100:2f9e94&height=3&section=header" width="100%"/>
</div>

## 📊 Sample Insights You Can Derive

- 💰 Total revenue collected across all paid invoices
- 🏆 The single busiest doctor by visit count
- 📈 Revenue broken down by department
- 🩺 Patients flagged as "High risk" by visit history
- 🕒 Cancelled appointments older than 6 months, ready for cleanup
- 📆 Month-over-month cumulative revenue trend

<br/>

## 📁 File Structure

```
├── Hospital_Managment_system.sql   # schema + seed data + CRUD + 30 queries
└── README.md                       # project documentation (this file)
```

## 🚀 Future Improvements

- [ ] Add a `Staff_New` table (nurses, admin) with its own department mapping
- [ ] Add indexes on foreign key columns + `EXPLAIN ANALYZE` benchmarks
- [ ] Wrap appointment booking + invoice creation in a single transaction
- [ ] Port date/string functions to MySQL / SQL Server equivalents
- [ ] Add `CHECK (discharge_date >= admission_date)` and similar constraints

<br/>

## 🖥️ Live Preview

Rather than a static screenshot, this project ships an actual **live, clickable query console** — open it and run any of the 30 queries yourself:

**👉 [claude.ai/artifact/6NuoGCVjiosQTXdFQ5SRBz](https://claude.ai/artifact/6NuoGCVjiosQTXdFQ5SRBz)**

<br/>

<div align="center">

<img width="3200" height="2000" alt="sample_output (4)" src="https://github.com/user-attachments/assets/ab4d41ed-ea11-4be0-b837-9b3248026b1c" />


### 👤 Author

**Bhavika Thadani**
📍 Ahmedabad

*(edit this section with your name/handle before publishing)*

Made with ❤️ to strengthen SQL fundamentals — schema design, joins, subqueries & window functions.

⭐ **If you found this project useful, consider giving it a star!**

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:2f9e94,100:0f3d3b&height=100&section=footer" width="100%"/>

</div>
