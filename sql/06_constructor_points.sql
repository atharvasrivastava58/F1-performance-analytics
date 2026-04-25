-- Constructor Championship chart
SELECT 
    con.name AS team_name,
    SUM(SAFE_CAST(cr.points AS FLOAT64)) AS total_points
FROM 
    `motorsports-analysis-project.F1_analysis.constructor_results` cr
JOIN 
    `motorsports-analysis-project.F1_analysis.constructors` con 
    ON SAFE_CAST(cr.constructorId AS INT64) = SAFE_CAST(con.constructorId AS INT64)
JOIN 
    `motorsports-analysis-project.F1_analysis.races` ra 
    ON SAFE_CAST(cr.raceId AS INT64) = SAFE_CAST(ra.raceId AS INT64)
WHERE 
    ra.year BETWEEN 2010 AND 2024
GROUP BY 
    con.name
ORDER BY 
    total_points DESC
LIMIT 10;
