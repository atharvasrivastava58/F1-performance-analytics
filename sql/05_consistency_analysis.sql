-- Which drivers are the most consistent lap-by-lap performers in 2023?
SELECT 
    d.forename,
    d.surname,
    COUNT(lt.lap) AS total_laps,
    ROUND(AVG(lt.milliseconds) / 1000, 3) AS avg_lap_seconds,
    ROUND(STDDEV(lt.milliseconds) / 1000, 3) AS lap_consistency_stddev,
    ROUND(MIN(lt.milliseconds) / 1000, 3) AS fastest_lap_seconds
FROM 
    `motorsports-analysis-project.F1_analysis.lap_times` lt
JOIN 
    `motorsports-analysis-project.F1_analysis.drivers` d 
    ON SAFE_CAST(lt.driverId AS INT64) = SAFE_CAST(d.driverId AS INT64)
JOIN 
    `motorsports-analysis-project.F1_analysis.races` ra 
    ON SAFE_CAST(lt.raceId AS INT64) = SAFE_CAST(ra.raceId AS INT64)
WHERE 
    ra.year = 2023
GROUP BY 
    d.forename, d.surname
HAVING 
    COUNT(lt.lap) >= 100
ORDER BY 
    lap_consistency_stddev ASC
LIMIT 15;
