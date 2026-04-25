--Find the age of your dataset
SELECT 
      MIN(year),
      MAX(year)
FROM
    `motorsports-analysis-project.F1_analysis.races`
