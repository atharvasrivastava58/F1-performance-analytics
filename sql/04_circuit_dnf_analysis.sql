-- Which circuits produce the most retirements and DNFs?
SELECT 
    ra.name AS circuit_name,
    COUNT(*) AS total_entries,
    SUM(CASE WHEN SAFE_CAST(r.position AS INT64) IS NULL THEN 1 ELSE 0 END) AS total_dnfs,
    ROUND(
        SUM(CASE WHEN SAFE_CAST(r.position AS INT64) IS NULL THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 1
    ) AS dnf_percentage
FROM 
    `motorsports-analysis-project.F1_analysis.results` r
JOIN 
    `motorsports-analysis-project.F1_analysis.races` ra 
    ON SAFE_CAST(r.raceId AS INT64) = SAFE_CAST(ra.raceId AS INT64)
WHERE 
    ra.year BETWEEN 2010 AND 2024
GROUP BY 
    ra.name
HAVING 
    COUNT(*) >= 100
ORDER BY 
    dnf_percentage DESC
LIMIT 15;
