-- Qual destino de alta gera mais readmissões?
SELECT
dd.discharge_destination,
ROUND(
SUM(CASE WHEN fr.readmitted_30_days = true THEN 1 ELSE 0 END) * 100 /
COUNT(*), 2 ) AS tax_readmission
FROM dim_discharge dd
JOIN fact_readmission fr
ON fr.patient_id = dd.patient_id
GROUP BY dd.discharge_destination;

-- Quem vai para casa ou para reabilitação retorna mais?
SELECT
dd.discharge_destination,
ROUND(AVG(CASE WHEN fr.readmitted_30_days = true THEN 1 ELSE 0 END) * 100, 2) AS tax_readmission
FROM dim_discharge dd
JOIN fact_readmission fr
ON fr.patient_id = dd.patient_id
WHERE dd.discharge_destination IN ('Home', 'Rehab')
GROUP BY dd.discharge_destination
ORDER BY tax_readmission DESC;
