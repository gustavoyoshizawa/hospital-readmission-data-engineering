-- Homens idosos com hipertensão têm maior taxa de retorno?
SELECT
dp.age_group,
ROUND(
AVG(CASE WHEN dc.hypertension = true THEN 1 ELSE 0 END) * 100, 2) 
AS tax_hyppertension,
ROUND(
AVG(CASE WHEN fr.readmitted_30_days = true THEN 1 ELSE 0 END) * 100, 2) 
AS tax_readmission
FROM dim_patient dp
JOIN dim_clinical dc
ON dc.patient_id = dp.patient_id
JOIN fact_readmission fr 
ON fr.patient_id = dp.patient_id
WHERE age > 60 and gender = 'MALE'
GROUP BY age_group

-- Pacientes com muitas medicações e alta pressão ficam mais dias internados e retornam mais?
SELECT 
dc.blood_pressure_stage,
CASE WHEN fr.medication_count >= 5 THEN 'many_medications'
ELSE 'few_medications'
END AS medication_group,
AVG(fr.length_of_stay) AS avg_length_of_stay,
AVG(CASE WHEN fr.readmitted_30_days = 1 THEN 1 ELSE 0 END) 
AS readmission_rate
FROM fact_readmission fr
JOIN dim_clinical dc 
ON fr.patient_id = dc.patient_id
GROUP BY dc.blood_pressure_stage, medication_group
ORDER BY readmission_rate DESC;

-- Qual perfil mais aparece entre os readmitidos?
SELECT
dp.age_group,
dp.gender,
dd.discharge_destination,
ROUND(
AVG(CASE WHEN fr.readmitted_30_days = true THEN 1 ELSE 0 END) * 100, 2) 
AS tax_readmission
FROM dim_patient dp
JOIN dim_discharge dd
ON dd.patient_id = dp.patient_id
JOIN fact_readmission fr
ON fr.patient_id = dp.patient_id
GROUP BY dp.age_group, dp.gender, dd.discharge_destination;