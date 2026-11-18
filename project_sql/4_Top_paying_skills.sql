
--Q4. What are the top skills based on salary

select
    skills.skills,
    ROUND(avg(jobs.salary_year_avg), 2) as avg_salary
from
    job_postings_fact as jobs
Inner join (
    select
        skills_job.*,
        skills
    from
        skills_job_dim as skills_job
    Inner join
        skills_dim as skills
    on
        skills.skill_id = skills_job.skill_id
) as skills
on
    skills.job_id = jobs.job_id
WHERE
    jobs.job_title_short = 'Data Analyst' and
    jobs.salary_year_avg is not null
GROUP BY
    skills.skills
ORDER BY
    avg_salary desc
limit 10