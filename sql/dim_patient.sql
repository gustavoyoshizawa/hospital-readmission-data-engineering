USE hospital

-- Qual a taxa de readmissão por faixa etária e sexo?
SELECT p.age_group, p.gender,
    ROUND(SUM(CASE WHEN readmitted_30_days = true THEN 1 ELSE 0 END) * 100 / COUNT(*),0) AS tax_readmission
    FROM fact_readmission f
    JOIN dim_patient p
    ON p.patient_id = f.patient_id
    GROUP BY p.age_group, p.gender;

-- Pacientes idosos são mais readmitidos que adultos?
SELECT 
    d.age_group,
    ROUND(
    SUM(CASE WHEN f.readmitted_30_days = true THEN 1 ELSE 0 END) * 100.0 /
    COUNT(*), 2) as tax_readmission
    FROM fact_readmission f
    JOIN dim_patient d
    ON d.patient_id = f.patient_id
    WHERE d.age_group IN ('adult', 'senior', 'very_senior')
    GROUP BY d.age_group
    ORDER BY tax_readmission DESC;

-- Qual grupo etário tem maior média de tempo de internação?
SELECT
    p.age_group,
    AVG(f.length_of_stay) as avg_days
    FROM fact_readmission f
    JOIN dim_patient p
    ON p.patient_id = f.patient_id
    GROUP by p.age_group
    ORDER BY avg_days
