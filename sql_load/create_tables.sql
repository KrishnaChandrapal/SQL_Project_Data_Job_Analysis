create table public.company_dim(
        company_id int primary key,
        name TEXT,
        link TEXT,
        link_google TEXT ,
        thumbnail TEXT
);

create table public.skills_dim(
    skill_id int primary key,
    skills TEXT,
    type TEXT
);

create table public.job_postings_fact(
    job_id int primary key,
    company_id int,
    job_title_short varchar(255),
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home boolean,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES public.company_dim(company_id)
);

create table public.skills_job_dim(
    job_id int,
    skill_id int,
    primary key(job_id, skill_id),
    FOREIGN KEY(job_id) REFERENCES public.job_postings_fact(job_id),
    FOREIGN KEY(skill_id) REFERENCES public.skills_dim(skill_id)
);

CREATE INDEX idx_company_id 
on public.job_postings_fact (company_id);

CREATE INDEX idx_skill_id
on public.skills_job_dim (skill_id);

CREATE INDEX idx_job_id
on public.skills_job_dim (job_id);