--Who are the most dominant drivers of the modern F1 era (2010-2024)?
SELECT
    d.forename,
    d.surname,
    COUNT(*) AS total_wins
FROM `motorsports-analysis-project.F1_analysis.results` r
JOIN `motorsports-analysis-project.F1_analysis.drivers` d
    ON SAFE_CAST(r.driverid AS INT64) = SAFE_CAST(d.driverid AS INT64)
JOIN `motorsports-analysis-project.F1_analysis.races` ra
    ON r.raceid = ra.raceId
WHERE
    SAFE_CAST(r.position AS INT64) = 1
    AND ra.year BETWEEN 2010 AND 2024
GROUP BY
    d.forename, d.surname
ORDER BY
    total_wins DESC
LIMIT 10;
