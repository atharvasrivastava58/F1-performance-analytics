-- Which teams have the fastest average pit stop times? (2010-2024)
SELECT
    con.name AS team_name,
    ROUND(AVG(ps.milliseconds) / 1000, 2) AS avg_pit_stop_seconds,
    ROUND(MIN(ps.milliseconds) / 1000, 2) AS fastest_pit_stop_seconds,
    COUNT(*) AS total_pit_stops
FROM `motorsports-analysis-project.F1_analysis.pit_stops` ps
JOIN `motorsports-analysis-project.F1_analysis.results` r
    ON ps.raceId = r.raceId
    AND ps.driverId = r.driverId
JOIN `motorsports-analysis-project.F1_analysis.constructors` con
    ON SAFE_CAST(r.constructorId AS INT64) = SAFE_CAST(con.constructorId AS INT64)
JOIN `motorsports-analysis-project.F1_analysis.races` ra
    ON ps.raceId = ra.raceId
WHERE 
    ra.year BETWEEN 2010 AND 2024
    AND ps.milliseconds BETWEEN 12000 AND 120000
GROUP BY 
    con.name
ORDER BY 
    avg_pit_stop_seconds ASC
LIMIT 15;
