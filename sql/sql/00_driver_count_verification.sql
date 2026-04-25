-- How many unique drivers have ever raced in F1?
SELECT COUNT(DISTINCT r.driverid) AS total_drivers
FROM `motorsports-analysis-project.F1_analysis.results` r
JOIN `motorsports-analysis-project.F1_analysis.races` ra
  ON r.raceid = ra.raceid
WHERE ra.year BETWEEN 1950 AND 2024
  AND ra.name != 'Indianapolis 500'
  AND r.grid IS NOT NULL
