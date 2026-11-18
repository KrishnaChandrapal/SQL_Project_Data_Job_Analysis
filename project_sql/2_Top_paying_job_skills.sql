
--Q2. What skills are required for the top-paying data analyst jobs?
-- Why? it provides a detailed look at which high paying jobs demands certain skills,
-- helping job seekers understand which skills to develop that align with top salaries

with top_paying_jobs as (
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
limit 10    )

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
Inner join
    skills_job_dim
ON
    skills_job_dim.job_id = top_paying_jobs.job_id
Inner join
    skills_dim
ON
    skills_dim.skill_id = skills_job_dim.skill_id
order BY
    top_paying_jobs.salary_year_avg desc