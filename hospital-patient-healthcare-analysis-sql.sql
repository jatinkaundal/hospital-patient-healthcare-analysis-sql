-- DEPARTMENTS
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- DOCTORS
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    specialization VARCHAR(100),
    department_id INT,
    experience_years INT,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

-- PATIENTS
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    date_of_birth DATE,
    city VARCHAR(50),
    blood_group VARCHAR(5),
    registration_date DATE
);

-- APPOINTMENTS
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    appointment_type VARCHAR(50),
    status VARCHAR(20),

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);

-- ADMISSIONS
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    admission_date DATE,
    discharge_date DATE,
    room_type VARCHAR(50),
    diagnosis VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    insurance_amount DECIMAL(10,2),
    payment_method VARCHAR(50),

    FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);

-- RECORD COUNTS
SELECT COUNT(*) AS total_departments
FROM departments;

SELECT COUNT(*) AS total_doctors
FROM doctors;

SELECT COUNT(*) AS total_patients
FROM patients;

SELECT COUNT(*) AS total_appointments
FROM appointments;

SELECT COUNT(*) AS total_admissions
FROM admissions;

-- DATA QUALITY ANALYSIS
-- MISSING VALUES
SELECT
    COUNT(*) AS total_patients,
    SUM(patient_id IS NULL) AS missing_patient_id,
    SUM(gender IS NULL) AS missing_gender,
    SUM(city IS NULL) AS missing_city,
    SUM(blood_group IS NULL) AS missing_blood_group
FROM patients;

-- DOCTORS
SELECT
    COUNT(*) AS total_doctors,
    SUM(doctor_name IS NULL) AS missing_names,
    SUM(department_id IS NULL) AS missing_departments
FROM doctors;

-- APPOINTMENTS
SELECT
    COUNT(*) AS total_appointments,
    SUM(patient_id IS NULL) AS missing_patients,
    SUM(doctor_id IS NULL) AS missing_doctors,
    SUM(status IS NULL) AS missing_status
FROM appointments;

-- ADMISSION
SELECT
    COUNT(*) AS total_admissions,
    SUM(treatment_cost IS NULL) AS missing_cost,
    SUM(insurance_amount IS NULL) AS missing_insurance
FROM admissions;

-- BASIC PATIENT ANALYSIS
-- TOTAL PATIENTS
SELECT COUNT(*) AS patient_count
FROM patients;

-- GENDER DISTRIBUTION
SELECT gender, COUNT(*) AS patient_count
FROM patients
GROUP BY gender
ORDER BY patient_count DESC;

-- CITY-WISE PATIENTS
SELECT city, COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC;

-- BLOOD GROUP DISTRIBUTION
SELECT blood_group, COUNT(*) AS patient_count
FROM patients
GROUP BY blood_group
ORDER BY patient_count DESC;

-- PATIENT AGE ANALYSIS
SELECT 
	patient_id,
    first_name,
    last_name,
    date_of_birth,
    TIMESTAMPDIFF(
		YEAR,
        date_of_birth,
        CURDATE()
	) AS age
FROM patients;

-- AGE GROUPS
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 18
            THEN 'Under 18'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 18 AND 30
            THEN '18-30'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 31 AND 45
            THEN '31-45'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 46 AND 60
            THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY age_group
ORDER BY patient_count DESC;

-- DOCTOR ANALYSIS
SELECT COUNT(*) AS total_doctors 
FROM doctors;

-- DOCTORS BY DEPARTMENTS
SELECT
    d.department_name,
    COUNT(dr.doctor_id) AS doctor_count
FROM departments d
LEFT JOIN doctors dr
    ON d.department_id = dr.department_id
GROUP BY d.department_name
ORDER BY doctor_count DESC;

-- DOCTOR EXPERIENCE
SELECT
	doctor_name,
    specialization,
    experience_yearS
FROM doctors
ORDER BY experience_yearS DESC;

-- DOCTORS + DEPARTMENTS
SELECT
    dr.doctor_id,
    dr.doctor_name,
    dr.specialization,
    d.department_name,
    dr.experience_years
FROM doctors dr
JOIN departments d
    ON dr.department_id = d.department_id
ORDER BY dr.experience_years DESC;

-- APPOINTMENT ANALYSIS
SELECT COUNT(*) AS 
total_appointments
FROM appointments;

-- APPOINTMENT STATUS
SELECT 
	status, COUNT(*) AS appointment_count
FROM appointments
GROUP BY status
ORDER BY appointment_count;

-- APPOINTMENT TYPE
SELECT appointment_type,
	COUNT(*) AS appointment_count
FROM appointments
GROUP BY appointment_type
ORDER BY appointment_count DESC;

-- MONTHLY APPOINTMENT TREND
SELECT
    YEAR(appointment_date) AS year,
    MONTH(appointment_date) AS month,
    COUNT(*) AS total_appointments
FROM appointments
GROUP BY
    YEAR(appointment_date),
    MONTH(appointment_date)
ORDER BY year, month;

-- DOCTOR-WISE APPOINTMENT
SELECT
    dr.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors dr
LEFT JOIN appointments a
    ON dr.doctor_id = a.doctor_id
GROUP BY dr.doctor_id, dr.doctor_name
ORDER BY total_appointments DESC;

-- TOP 5 DOCTORS
SELECT
    dr.doctor_name,
    COUNT(a.appointment_id) AS total_appointments
FROM doctors dr
JOIN appointments a
    ON dr.doctor_id = a.doctor_id
GROUP BY dr.doctor_id, dr.doctor_name
ORDER BY total_appointments DESC
LIMIT 5;

-- APPOINTMENT COMPLETION RATE 
SELECT
    COUNT(*) AS total_appointments,
    SUM(status = 'Completed') AS completed,
    SUM(status = 'Cancelled') AS cancelled,
    SUM(status = 'Pending') AS pending,

    ROUND(
        SUM(status = 'Completed') * 100.0 / COUNT(*),
        2
    ) AS completion_rate
FROM appointments;

-- OATIENT APPOINTMENT ANALYSIS
SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(a.appointment_id) AS total_appointments
FROM patients p
LEFT JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY
    p.patient_id,
    patient_name
ORDER BY total_appointments DESC;

-- REPEAT PATIENT
SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(a.appointment_id) AS appointment_count
FROM patients p
JOIN appointments a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, patient_name
HAVING COUNT(a.appointment_id) > 1
ORDER BY appointment_count DESC;

-- ADMISSION ANALYSIS
SELECT COUNT(*) AS total_asmissions
FROM admissions;

-- ROOM TYPE
SELECT
    room_type,
    COUNT(*) AS admissions
FROM admissions
GROUP BY room_type
ORDER BY admissions DESC;

-- DIAGNOSIS ANALYSIS
SELECT
    diagnosis,
    COUNT(*) AS cases
FROM admissions
GROUP BY diagnosis
ORDER BY cases DESC;

-- LENGTH OF STAY
SELECT
    admission_id,
    patient_id,
    admission_date,
    discharge_date,
    DATEDIFF(discharge_date, admission_date) AS length_of_stay
FROM admissions;

-- AVERAGE STAY
SELECT
    ROUND(
        AVG(DATEDIFF(discharge_date, admission_date)),
        2
    ) AS average_length_of_stay
FROM admissions;

-- LONGEST STAY
SELECT
    admission_id,
    patient_id,
    DATEDIFF(discharge_date, admission_date) AS length_of_stay
FROM admissions
ORDER BY length_of_stay DESC
LIMIT 10;

-- REVENUE ANALYSIS
-- TOTAL TREATMENT COST
SELECT
    SUM(treatment_cost) AS total_revenue
FROM admissions;

-- AVERAGE TREATMENT COST
SELECT
    ROUND(AVG(treatment_cost), 2) AS average_treatment_cost
FROM admissions;

-- HIGHEST TREATMENT COST
SELECT
    MAX(treatment_cost) AS highest_treatment_cost
FROM admissions;

-- LOWEST TREATMENT COST
SELECT
    MIN(treatment_cost) AS lowest_treatment_cost
FROM admissions;

-- INSURANCE ANALYSIS
SELECT
    SUM(treatment_cost) AS total_treatment_cost,
    SUM(insurance_amount) AS total_insurance,
    SUM(treatment_cost - insurance_amount) AS patient_payment
FROM admissions;

-- INSURANCE COVERAGE %
SELECT
    ROUND(
        SUM(insurance_amount) * 100.0 /
        SUM(treatment_cost),
        2
    ) AS insurance_coverage_percentage
FROM admissions;

-- PAYMENT METHOD ANALYSIS
SELECT
    payment_method,
    COUNT(*) AS transactions,
    SUM(treatment_cost) AS revenue
FROM admissions
GROUP BY payment_method
ORDER BY revenue DESC;

-- DEPARTMENT-WISE REVENUE
SELECT
    d.department_name,
    COUNT(a.admission_id) AS total_admissions,
    SUM(a.treatment_cost) AS total_revenue,
    ROUND(AVG(a.treatment_cost), 2) AS avg_treatment_cost
FROM admissions a
JOIN doctors dr
    ON a.doctor_id = dr.doctor_id
JOIN departments d
    ON dr.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_revenue DESC;

-- DOCTOR-WISE REVENUE
SELECT
    dr.doctor_name,
    d.department_name,
    COUNT(a.admission_id) AS total_admissions,
    SUM(a.treatment_cost) AS total_revenue
FROM doctors dr
JOIN departments d
    ON dr.department_id = d.department_id
LEFT JOIN admissions a
    ON dr.doctor_id = a.doctor_id
GROUP BY
    dr.doctor_id,
    dr.doctor_name,
    d.department_name
ORDER BY total_revenue DESC;

-- TOP 10 HIGHEST BILLING PATIENTS
SELECT
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    COUNT(a.admission_id) AS admissions,
    SUM(a.treatment_cost) AS total_spending
FROM patients p
JOIN admissions a
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id, patient_name
ORDER BY total_spending DESC
LIMIT 10;

-- DIAGNOSIS-WISE REVENUE
SELECT
    diagnosis,
    COUNT(*) AS cases,
    SUM(treatment_cost) AS total_revenue,
    ROUND(AVG(treatment_cost), 2) AS avg_cost
FROM admissions
GROUP BY diagnosis
ORDER BY total_revenue DESC;

-- ROOM-WISE REVENUE
SELECT
    room_type,
    COUNT(*) AS admissions,
    SUM(treatment_cost) AS revenue,
    ROUND(AVG(treatment_cost), 2) AS avg_cost
FROM admissions
GROUP BY room_type
ORDER BY revenue DESC;

-- MONTHLY REVENUE
SELECT
    DATE_FORMAT(admission_date, '%Y-%m') AS month,
    COUNT(*) AS admissions,
    SUM(treatment_cost) AS revenue
FROM admissions
GROUP BY DATE_FORMAT(admission_date, '%Y-%m')
ORDER BY month;

-- DOCTOR RANKING
WITH doctor_revenue AS (
    SELECT
        dr.doctor_id,
        dr.doctor_name,
        SUM(a.treatment_cost) AS revenue
    FROM doctors dr
    JOIN admissions a
        ON dr.doctor_id = a.doctor_id
    GROUP BY dr.doctor_id, dr.doctor_name
)

SELECT
    doctor_name,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS doctor_rank
FROM doctor_revenue;