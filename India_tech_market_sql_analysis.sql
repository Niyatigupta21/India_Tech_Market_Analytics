CREATE TABLE tech_jobs (
    title TEXT,
    jobId BIGINT,
    currency TEXT,
    jobUploaded TEXT,
    companyName TEXT,
    tagsAndSkills TEXT,
    experience TEXT,
    salary TEXT,
    location TEXT,
    companyId BIGINT,
    ReviewsCount DOUBLE PRECISION,
    AggregateRating DOUBLE PRECISION,
    jobDescription TEXT,
    minimumSalary DOUBLE PRECISION,
    maximumSalary DOUBLE PRECISION,
    minimumExperience DOUBLE PRECISION,
    maximumExperience DOUBLE PRECISION,
    row_id BIGINT,
    minimum_salary_clean DOUBLE PRECISION,
    maximum_salary_clean DOUBLE PRECISION,
    salary_status TEXT,
    salary_midpoint DOUBLE PRECISION,
    is_unpaid_internship INTEGER,
    is_stipend_role INTEGER,
    currency_note TEXT,
    minimum_experience_clean DOUBLE PRECISION,
    maximum_experience_clean DOUBLE PRECISION,
    experience_midpoint DOUBLE PRECISION,
    is_fresher_friendly INTEGER,
    city TEXT,
    work_location_type TEXT,
    is_remote INTEGER,
    is_multi_city INTEGER,
    state TEXT,
    job_recency_bucket TEXT,
    is_future_start INTEGER,
    start_date TEXT,
    skill_count INTEGER,
    is_tech_job TEXT,
    tech_role_category TEXT,
    classification_reason TEXT
);
SELECT COUNT(*) AS total_rows
FROM tech_jobs;


-- Business Problems

-- =====================================================
-- Project: Indian Tech Job Market Analysis
-- Database: PostgreSQL
-- Author: Niyati
-- =====================================================

-- Table Creation Check
SELECT COUNT(*) AS total_rows FROM tech_jobs;
SELECT * FROM tech_jobs LIMIT 10;

-- -----------------------------------------------------
-- Q1. How many jobs are Tech, Non-Tech, and Borderline?
-- -----------------------------------------------------
SELECT
    is_tech_job,
    COUNT(*) AS job_count
FROM tech_jobs
GROUP BY is_tech_job
ORDER BY job_count DESC;

-- -----------------------------------------------------
-- Q2. Technology roles distribution in Indian tech market
-- -----------------------------------------------------
SELECT
    tech_role_category,
    COUNT(*) AS job_count
FROM tech_jobs
WHERE is_tech_job = 'Yes'
GROUP BY tech_role_category
ORDER BY job_count DESC;

-- -----------------------------------------------------
-- Q3. Top Non-Tech job titles by volume
-- -----------------------------------------------------
SELECT
    title,
    is_tech_job,
    COUNT(*) AS job_count
FROM tech_jobs
WHERE is_tech_job IN ('No', 'Borderline')
GROUP BY title, is_tech_job
ORDER BY job_count DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q4. Borderline jobs related to technology/tech-adjacent
-- -----------------------------------------------------
SELECT
    title,
    COUNT(*) AS job_count
FROM tech_jobs
WHERE is_tech_job = 'Borderline'
GROUP BY title
ORDER BY job_count DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q5. Most common skills in Borderline roles
-- -----------------------------------------------------
SELECT
    UPPER(TRIM(skill)) AS skill,
    COUNT(*) AS job_count
FROM tech_jobs,
LATERAL unnest(string_to_array(tagsAndSkills, ',')) AS skill
WHERE is_tech_job = 'Borderline'
  AND TRIM(skill) <> ''
GROUP BY UPPER(TRIM(skill))
ORDER BY job_count DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q6. Fresher-friendly opportunities in Borderline roles
-- -----------------------------------------------------
SELECT
    COUNT(*) AS fresher_friendly_tech_adjacent_jobs
FROM tech_jobs
WHERE is_tech_job = 'Borderline'
  AND is_fresher_friendly = 1;

-- -----------------------------------------------------
-- Q7. Tech roles with highest fresher-friendly opportunities
-- -----------------------------------------------------
SELECT
    tech_role_category,
    COUNT(*) AS fresher_friendly_jobs
FROM tech_jobs
WHERE is_tech_job = 'Yes'
  AND is_fresher_friendly = 1
GROUP BY tech_role_category
ORDER BY fresher_friendly_jobs DESC;

-- -----------------------------------------------------
-- Q8. Top cities for fresher-friendly tech jobs
-- -----------------------------------------------------
SELECT
    city,
    COUNT(*) AS fresher_friendly_jobs
FROM tech_jobs
WHERE is_tech_job = 'Yes'
  AND is_fresher_friendly = 1
  AND city IS NOT NULL
  AND city <> ''
GROUP BY city
ORDER BY fresher_friendly_jobs DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q9. Work mode distribution in fresher-friendly tech jobs
-- -----------------------------------------------------
SELECT
    work_location_type,
    COUNT(*) AS fresher_friendly_jobs
FROM tech_jobs
WHERE is_tech_job = 'Yes'
  AND is_fresher_friendly = 1
GROUP BY work_location_type
ORDER BY fresher_friendly_jobs DESC;

-- -----------------------------------------------------
-- Q10. Most frequently listed skills across all tech jobs
-- -----------------------------------------------------
SELECT
    UPPER(TRIM(skill)) AS skill,
    COUNT(*) AS job_count
FROM tech_jobs,
LATERAL unnest(string_to_array(tagsAndSkills, ',')) AS skill
WHERE is_tech_job = 'Yes'
  AND TRIM(skill) <> ''
GROUP BY UPPER(TRIM(skill))
ORDER BY job_count DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q11. Top skills demanded in Data Analytics roles
-- -----------------------------------------------------
SELECT
    UPPER(TRIM(skill)) AS skill,
    COUNT(*) AS job_count
FROM tech_jobs,
LATERAL unnest(string_to_array(tagsAndSkills, ',')) AS skill
WHERE tech_role_category = 'Data Analytics'
  AND TRIM(skill) <> ''
GROUP BY UPPER(TRIM(skill))
ORDER BY job_count DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q12. Top skills demanded in Software Development roles
-- -----------------------------------------------------
SELECT
    UPPER(TRIM(skill)) AS skill,
    COUNT(*) AS job_count
FROM tech_jobs,
LATERAL unnest(string_to_array(tagsAndSkills, ',')) AS skill
WHERE tech_role_category = 'Software Development'
  AND TRIM(skill) <> ''
GROUP BY UPPER(TRIM(skill))
ORDER BY job_count DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q13. Technical skills associated with higher average salary
-- -----------------------------------------------------
SELECT
    UPPER(TRIM(skill)) AS skill,
    COUNT(*) AS job_count,
    ROUND(AVG(salary_midpoint)::numeric, 0) AS avg_salary_inr
FROM tech_jobs,
LATERAL unnest(string_to_array(tagsAndSkills, ',')) AS skill
WHERE is_tech_job = 'Yes'
  AND salary_status = 'Disclosed'
  AND currency = 'INR'
  AND salary_midpoint IS NOT NULL
  AND salary_midpoint > 0
  AND TRIM(skill) <> ''
GROUP BY UPPER(TRIM(skill))
HAVING COUNT(*) >= 20
ORDER BY avg_salary_inr DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q14. Salary range across tech role categories (INR)
-- -----------------------------------------------------
SELECT
    tech_role_category,
    ROUND(MIN(minimum_salary_clean)::numeric, 0) AS min_salary_inr,
    ROUND(MAX(maximum_salary_clean)::numeric, 0) AS max_salary_inr
FROM tech_jobs
WHERE is_tech_job = 'Yes'
  AND salary_status = 'Disclosed'
  AND currency = 'INR'
  AND minimum_salary_clean > 0
  AND maximum_salary_clean > 0
GROUP BY tech_role_category
ORDER BY min_salary_inr DESC;

-- -----------------------------------------------------
-- Q15. Tech roles with highest median salary (INR)
-- -----------------------------------------------------
SELECT
    tech_role_category,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY salary_midpoint)::numeric,
        0
    ) AS median_salary_inr
FROM tech_jobs
WHERE is_tech_job = 'Yes'
  AND salary_status = 'Disclosed'
  AND currency = 'INR'
  AND salary_midpoint > 0
GROUP BY tech_role_category
ORDER BY median_salary_inr DESC;

-- -----------------------------------------------------
-- Q16. Salary comparison: Fresher-Friendly vs Experienced (INR)
-- -----------------------------------------------------
SELECT
    CASE
        WHEN is_fresher_friendly = 1 THEN 'Fresher-Friendly'
        ELSE 'Non-Fresher-Friendly'
    END AS experience_group,
    COUNT(*) AS job_count,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY salary_midpoint)::numeric,
        0
    ) AS median_salary_inr
FROM tech_jobs
WHERE is_tech_job = 'Yes'
  AND salary_status = 'Disclosed'
  AND currency = 'INR'
  AND salary_midpoint > 0
GROUP BY experience_group
ORDER BY median_salary_inr DESC;

-- -----------------------------------------------------
-- Q17. Top cities by total tech job count
-- -----------------------------------------------------
SELECT
    city,
    COUNT(*) AS tech_job_count
FROM tech_jobs
WHERE is_tech_job = 'Yes'
  AND city IS NOT NULL
  AND city <> ''
GROUP BY city
ORDER BY tech_job_count DESC
LIMIT 20;

-- -----------------------------------------------------
-- Q18. Top 3 dominant tech roles in each major tech hub (Window Function)
-- -----------------------------------------------------
WITH city_role_summary AS (
    SELECT
        city,
        tech_role_category,
        COUNT(*) AS total_openings,
        DENSE_RANK() OVER (
            PARTITION BY city 
            ORDER BY COUNT(*) DESC
        ) AS rank_in_city
    FROM tech_jobs
    WHERE is_tech_job = 'Yes'
      AND city IN ('Bengaluru', 'Hyderabad', 'Pune', 'Chennai', 'Mumbai', 'Noida', 'Gurugram')
    GROUP BY city, tech_role_category
)
SELECT
    city,
    rank_in_city,
    tech_role_category,
    total_openings
FROM city_role_summary
WHERE rank_in_city <= 3
ORDER BY city, rank_in_city; 

