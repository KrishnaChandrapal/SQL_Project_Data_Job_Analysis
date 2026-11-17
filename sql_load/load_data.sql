copy public.company_dim
FROM 'C:\Program Files\PostgreSQL\18\data\datasets\sql_project\company_dim.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    ENCODING 'UTF8'
);

COPY public.job_postings_fact (
    job_id,
    company_id,
    job_title_short,
    job_title,
    job_location,
    job_via,
    job_schedule_type,
    job_work_from_home,
    search_location,
    job_posted_date,
    job_no_degree_mention,
    job_health_insurance,
    job_country,
    salary_rate,
    salary_year_avg,
    salary_hour_avg
)
FROM 'C:/Program Files/PostgreSQL/18/data/Datasets/sql_project/job_postings_fact.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    ENCODING 'UTF8'
);

COPY public.skills_dim
FROM 'C:\Program Files\PostgreSQL\18\data\datasets\sql_project\skills_dim.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    ENCODING 'UTF8'
);

COPY public.skills_job_dim
FROM 'C:\Program Files\PostgreSQL\18\data\datasets\sql_project\skills_job_dim.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ',',
    ENCODING 'UTF8'
);
