
--Q3. What are the most in demand skills for data analysts?
-- Identify the top 5 in demand skills for a data analyst

SELECT 
    skill.skills,
    count(jobs.job_id) as job_count
from
    skills_dim as skill
Inner join
    skills_job_dim as skills_jobs
on
    skills_jobs.skill_id = skill.skill_id
Inner join
    job_postings_fact as jobs
on
    jobs.job_id = skills_jobs.job_id
WHERE
    jobs.job_title_short = 'Data Analyst'
group by
    skill.skills
order by
    job_count desc
limit 5;