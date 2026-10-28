
CREATE DATABASE IF NOT EXISTS german_job_market;

USE german_job_market;

CREATE TABLE IF NOT EXISTS job_postings (
    id VARCHAR(100) PRIMARY KEY,
    title VARCHAR(255),
    employer VARCHAR(255),
    region VARCHAR(100),
    posted_date DATE,
    seniority VARCHAR(50),
    salary_range VARCHAR(100),
    source VARCHAR(100),
    source_url TEXT
);


SELECT COUNT(*) AS total_rows FROM job_postings;

SELECT *FROM job_postings LIMIT 10;

-- Query 1:job postings by region
SELECT region,COUNT(*) AS total_postings 
FROM job_postings GROUP BY region ORDER BY total_postings DESC;

-- Query 2: Count job postings by seniority level

SELECT seniority,COUNT(*) AS total_postings FROM job_postings
GROUP BY seniority ORDER BY total_postings DESC;


-- Query 3: Find the top 10 employers by job postings

SELECT employer,COUNT(*) AS total_postings FROM job_postings
WHERE employer IS NOT NULL   AND employer <> ''
GROUP BY employer ORDER BY total_postings DESC LIMIT 10;


-- Query 4: Analyse job postings by month

SELECT YEAR(posted_date) AS posting_year,
    MONTH(posted_date) AS posting_month,
    COUNT(*) AS total_postings
FROM job_postings 
WHERE posted_date IS NOT NULL
GROUP BY YEAR(posted_date),MONTH(posted_date)
ORDER BY posting_year,posting_month;


-- Query 5: Find the most frequently listed skills

SELECT
    skill, COUNT(*) AS skill_frequency
FROM analyst_job_skills
WHERE skill IS NOT NULL
  AND skill <> ''
GROUP BY skill
ORDER BY skill_frequency DESC
LIMIT 10;

-- Query 6: Analyse job postings by region and seniority

SELECT region, seniority,
    COUNT(*) AS total_postings
FROM job_postings
GROUP BY
    region,
    seniority
ORDER BY
    region,
    total_postings DESC;


-- Query 8: Display the 10 most recently posted jobs

SELECT id,title,employer,region,posted_date,seniority
FROM job_postings
WHERE posted_date IS NOT NULL
ORDER BY posted_date DESC
LIMIT 10;

-- Query 9: Find junior and entry-level opportunities

SELECT title,employer,region,posted_date,seniority
FROM job_postings
WHERE LOWER(seniority) IN ('junior', 'entry')
ORDER BY posted_date DESC;

-- Query 10: Employers with junior and entry-level postings

SELECT employer,region,
    COUNT(*) AS total_postings
FROM job_postings
WHERE LOWER(seniority) IN ('junior', 'entry')
  AND employer IS NOT NULL
  AND employer <> ''
GROUP BY
    employer,
    region
ORDER BY total_postings DESC;

-- Query 11: Check missing values in important columns

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN title IS NULL OR TRIM(title) = '' THEN 1 ELSE 0 END) AS missing_titles,
    SUM(CASE WHEN employer IS NULL OR TRIM(employer) = '' THEN 1 ELSE 0 END) AS missing_employers,
    SUM(CASE WHEN region IS NULL OR TRIM(region) = '' THEN 1 ELSE 0 END) AS missing_regions,
    SUM(CASE WHEN posted_date IS NULL THEN 1 ELSE 0 END) AS missing_dates
FROM job_postings;

-- Query 12: Count distinct employers

SELECT
    COUNT(DISTINCT employer) AS unique_employers
FROM job_postings
WHERE employer IS NOT NULL
  AND TRIM(employer) <> '';

-- Query 13: Rank employers by number of job postings

WITH EmployerCounts AS (
    SELECT
        employer,
        COUNT(*) AS total_postings
    FROM job_postings
    WHERE employer IS NOT NULL
      AND TRIM(employer) <> ''
    GROUP BY employer
)
SELECT
    employer,
    total_postings,
    DENSE_RANK() OVER (
        ORDER BY total_postings DESC
    ) AS employer_rank
FROM EmployerCounts
ORDER BY employer_rank, employer;

-- Query 14: Group postings into seniority categories

SELECT
    CASE
        WHEN LOWER(seniority) = 'junior' THEN 'Junior'
        WHEN LOWER(seniority) = 'entry' THEN 'Entry-Level'
        WHEN LOWER(seniority) = 'senior' THEN 'Senior'
        WHEN LOWER(seniority) = 'lead' THEN 'Lead'
        ELSE 'Unknown'
    END AS seniority_category,
    COUNT(*) AS total_postings
FROM job_postings
GROUP BY seniority_category
ORDER BY total_postings DESC;


-- Query 15: Month-over-month job posting comparison

WITH monthly_counts AS (
    SELECT
        DATE_FORMAT(posted_date, '%Y-%m') AS posting_month,
        COUNT(*) AS total_postings
    FROM job_postings
    WHERE posted_date IS NOT NULL
    GROUP BY DATE_FORMAT(posted_date, '%Y-%m')
),
monthly_comparison AS (
    SELECT
        posting_month,
        total_postings,
        LAG(total_postings) OVER (
            ORDER BY posting_month
        ) AS previous_month
    FROM monthly_counts
)
SELECT
    posting_month,
    total_postings,
    previous_month,
    total_postings - previous_month AS absolute_change,
    ROUND(
        100.0 * (total_postings - previous_month)
        / NULLIF(previous_month, 0),
        2
    ) AS percentage_change
FROM monthly_comparison
ORDER BY posting_month;
-- Query 16: Identify the Top 5 Regions by Job Postings
-- Purpose: Find the five regions with the highest number of job postings
-- Business insight: Identify regions with the greatest representation
-- in this filtered German job-market dataset

SELECT
    region,
    COUNT(*) AS total_postings
FROM job_postings
WHERE region IS NOT NULL
  AND TRIM(region) <> ''
GROUP BY region
ORDER BY total_postings DESC
LIMIT 5;

-- Query 17: Identify Duplicate Job Postings
-- Purpose: Find job IDs that appear more than once
-- Business insight: Detect potential duplicate records
-- that could inflate job-posting counts

SELECT
    id,
    COUNT(*) AS duplicate_count
FROM job_postings
GROUP BY id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Query 18: Find the Month with the Highest Number of Job Postings
-- Purpose: Identify the month with the maximum number of postings
-- Business insight: Discover periods with the highest recruitment activity

WITH MonthlyCounts AS (
    SELECT
        DATE_FORMAT(posted_date, '%Y-%m') AS posting_month,
        COUNT(*) AS total_postings
    FROM job_postings
    WHERE posted_date IS NOT NULL
    GROUP BY DATE_FORMAT(posted_date, '%Y-%m')
)
SELECT
    posting_month,
    total_postings
FROM MonthlyCounts
WHERE total_postings = (
    SELECT MAX(total_postings)
    FROM MonthlyCounts
)
ORDER BY posting_month;

-- Query 19: Identify Regions with Above-Average Job Postings
-- Purpose: Compare each region's posting count with the regional average
-- Business insight: Identify regions with a higher-than-average
-- representation in the filtered job-market dataset

WITH RegionCounts AS (
    SELECT
        region,
        COUNT(*) AS total_postings
    FROM job_postings
    WHERE region IS NOT NULL
      AND TRIM(region) <> ''
    GROUP BY region
)
SELECT
    region,
    total_postings
FROM RegionCounts
WHERE total_postings > (
    SELECT AVG(total_postings)
    FROM RegionCounts
)
ORDER BY total_postings DESC;