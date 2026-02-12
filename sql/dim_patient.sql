-- Qual a taxa de readmissão por faixa etária e sexo?
SELECT p.age_group, p.gender,
ROUND(SUM(CASE WHEN readmitted_30_days = true THEN 1 ELSE 0 END) * 100 / COUNT(*),0) AS tax_readmission
FROM fact_readmission f
JOIN dim_patient p
ON p.patient_id = f.patient_id
GROUP BY p.age_group, p.gender;

-- Pacientes idosos são mais readmitidos que adultos?
-- Qual grupo etário tem maior média de tempo de internação?