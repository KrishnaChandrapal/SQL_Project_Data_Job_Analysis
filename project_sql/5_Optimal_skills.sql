
--Q5. What are the most optimal skills to learn(skills that are in high demand and also high paying)

with high_demand_skills as (
    select
        skill.skill_id,
        skill.skills as skill_name,
        count(jobs.job_id) as demand_count
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
        job_title_short = 'Data Analyst' and
        job_work_from_home = True and
        jobs.salary_year_avg is not null
    group by
        skill.skill_id
), high_paying_skills as (
    select
        skill.skill_id,
        Round(Avg(jobs.salary_year_avg),2) as avg_salary
    FROM    
        skills_dim as skill
    Inner JOIN
        skills_job_dim as skills_job
    ON
        skills_job.skill_id = skill.skill_id
    Inner join
        job_postings_fact as jobs
    ON
        jobs.job_id = skills_job.job_id
    WHERE
        jobs.salary_year_avg is not null
    GROUP BY
        skill.skill_id
)

select 
    high_demand_skills.skill_id,
    high_demand_skills.skill_name,
    demand_count,
    avg_salary
FROM
    high_demand_skills
Inner join
    high_paying_skills 
ON
    high_demand_skills.skill_id = high_paying_skills.skill_id
WHERE
    demand_count>10
ORDER BY
    avg_salary desc, demand_count desc
limit 25