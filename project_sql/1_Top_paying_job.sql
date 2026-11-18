
--Q1. What are the Top paying data analyst jobs?
-- Identify the top 10 Highest paying Data Analyst roles that are available remotely
-- Focuses on job postings with specified salaries (remove nulls)
-- Why? Highlight the top-paying opportunities for Data Analyst, offering insights into 

SELECT
    job_id,
    company.name as company_name,
    job_title,
    job_schedule_type,
    job_location,
    job_posted_date,
    salary_year_avg
from
    job_postings_fact
LEFT JOIN
    company_dim as company
ON
    company.company_id = job_postings_fact.company_id
where
    job_title_short = 'Data Analyst'
    and
    job_work_from_home = True
    AND
    salary_year_avg is not NULL
ORDER BY
    salary_year_avg desc
limit 10