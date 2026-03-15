-- Qual estágio de pressão tem maior taxa de readmissão?
SELECT 
c.blood_pressure_stage,
ROUND(
SUM(CASE WHEN fr.readmitted_30_days = true THEN 1 ELSE 0 END) * 100 /
COUNT(*), 2 ) AS tax_readmission
FROM dim_clinical c
JOIN fact_readmission r ON fr.patient_id = c.patient_id
GROUP BY c.blood_pressure_stage;

-- Pacientes com risco metabólico voltam mais em 30 dias?
SELECT 
dc.metabolic_risk,
COUNT(*) AS total_pacientes,
SUM(CASE WHEN fr.readmitted_30_days = true THEN 1 ELSE 0 END) AS total_readmitidos,
AVG(CASE WHEN fr.readmitted_30_days = true THEN 1 ELSE 0 END) AS taxa_readmissao
FROM fact_readmission fr
JOIN dim_clinical dc 
ON fr.patient_id = dc.patient_id
GROUP BY dc.metabolic_risk;


-- Qual a média de colesterol de quem é readmitido vs quem não é?
SELECT
SELECT
fr.readmitted_30_days,
AVG(dc.cholesterol) as avg_cholesterol
FROM fact_readmission fr
JOIN dim_clinical dc
ON fr.patient_id = dc.patient_id
GROUP BY fr.readmitted_30_days;
