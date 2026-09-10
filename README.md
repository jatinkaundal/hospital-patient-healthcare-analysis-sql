🏥 Hospital Patient & Healthcare Analysis using MySQL

📌 Project Overview

This project focuses on analyzing hospital healthcare data using MySQL to understand patient demographics, doctor performance, appointment trends, hospital admissions, treatment costs, insurance coverage, and revenue performance.

The analysis uses multiple related tables to generate meaningful insights that can support hospital operations, resource planning, and financial decision-making.

---

🎯 Project Objectives

- Analyze patient demographics and healthcare patterns.
- Understand doctor and department performance.
- Analyze appointment trends and appointment status.
- Identify common diagnoses and admission patterns.
- Calculate hospital treatment revenue and average treatment costs.
- Analyze insurance coverage and patient payments.
- Analyze room utilization and length of stay.
- Identify high-value patients and high-demand doctors.
- Generate actionable business insights from healthcare data.

---

🗂️ Dataset

The project contains five related datasets:

Dataset| Description
"patients.csv"| Patient demographic and registration information
"doctors.csv"| Doctor details, specialization, and experience
"departments.csv"| Hospital department information
"appointments.csv"| Patient appointment records and status
"admissions.csv"| Hospital admissions, diagnosis, treatment costs, and payments

Dataset Size

- 50 Patients
- 15 Doctors
- 8 Departments
- 100 Appointments
- 100 Admissions

---

🛠️ Tools & Technologies

- MySQL
- SQL
- MySQL Workbench
- CSV Data

---

🔗 Database Relationships

Departments
     │
     └── Doctors
           │
           ├── Appointments
           │
           └── Admissions

Patients
     │
     ├── Appointments
     │
     └── Admissions

---

📊 Analysis Performed

👥 Patient Analysis

- Total patient count
- Gender-wise patient distribution
- City-wise patient distribution
- Blood-group distribution
- Patient age calculation
- Age-group analysis
- Repeat patient identification

👨‍⚕️ Doctor & Department Analysis

- Total doctors
- Doctors by department
- Doctor experience analysis
- Doctor-wise appointment volume
- Doctor-wise admission analysis
- Doctor-wise revenue analysis
- Department-wise admissions
- Department-wise revenue

📅 Appointment Analysis

- Total appointments
- Appointment status analysis
- Appointment type analysis
- Monthly appointment trends
- Doctor-wise appointments
- Appointment completion rate
- Repeat patient appointment analysis

🏥 Admission Analysis

- Total admissions
- Room-type analysis
- Diagnosis-wise cases
- Length of stay analysis
- Average length of stay
- Longest hospital stays

💰 Revenue Analysis

- Total treatment revenue
- Average treatment cost
- Highest and lowest treatment costs
- Department-wise revenue
- Doctor-wise revenue
- Diagnosis-wise revenue
- Room-wise revenue
- Monthly revenue
- Payment-method analysis
- Insurance coverage analysis
- Patient payment analysis
- Top 10 highest-spending patients

---

💡 Key Business Insights

- Patient demographics were analyzed to understand the hospital's major patient segments.
- City and age-group analysis can help identify areas and patient groups with higher healthcare demand.
- Doctor-wise appointment analysis helps identify high-demand doctors and workload distribution.
- Appointment status analysis helps evaluate scheduling and operational efficiency.
- Diagnosis analysis helps identify commonly occurring medical conditions.
- Length-of-stay analysis provides insights into hospitalization duration and resource utilization.
- Department-wise revenue analysis helps identify departments with higher financial contribution.
- Treatment-cost analysis highlights differences in healthcare expenses across diagnoses and departments.
- Insurance analysis helps understand the relationship between treatment costs, insurance coverage, and patient payments.
- Payment-method analysis provides insights into patient payment preferences.
- High-spending patient analysis helps identify patients with significant healthcare utilization.

---

🧠 SQL Concepts Used

SELECT
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
COUNT()
SUM()
AVG()
MIN()
MAX()
INNER JOIN
LEFT JOIN
CASE
DATE_FORMAT()
DATEDIFF()
TIMESTAMPDIFF()

---

📁 Project Structure

hospital-patient-healthcare-analysis-sql/
│
├── dataset/
│   ├── patients.csv
│   ├── doctors.csv
│   ├── departments.csv
│   ├── appointments.csv
│   └── admissions.csv
│
├── sql/
│   └── hospital_analysis.sql
│
├── screenshots/
│   ├── patient_analysis.png
│   ├── appointment_analysis.png
│   ├── admission_analysis.png
│   └── revenue_analysis.png
│
└── README.md

---

🚀 Conclusion

This project demonstrates how SQL and MySQL can be used to analyze healthcare data and transform raw hospital records into meaningful business insights.

The analysis can help healthcare organizations understand patient demand, doctor workload, hospital admissions, resource utilization, treatment costs, and revenue performance.

---

👨‍💻 Author

Jatin Kaundal

Aspiring Data Analyst

Skills: SQL | MySQL | Excel | Python | Power BI
