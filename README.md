# Introduction
This is my first SQL project, where I explored the data analyst job market using PostgreSQL. The main objective of this project was to understand job market trends, identify high-paying opportunities, analyse the most in-demand skills, and discover which skills can help aspiring Data Analysts become more competitive in the job market.

I used PostgreSQL to query and analyse job posting data, while Visual Studio Code (VS Code) served as my SQL development environment. Through this project, I applied SQL concepts such as filtering, joins, aggregations, subqueries, Common Table Expressions (CTEs), and sorting to extract meaningful insights from the dataset.
    SQL Queries?? Check them out here: [project_sql folder](/project_sql/)

# Background
The Data Analyst job market includes many career opportunities, but choosing the right career path requires an understanding of employer expectations, salary ranges, and the technical skills that are currently valued in the industry.

In this project, I used PostgreSQL to explore real-world job posting data and investigate the relationship between job salaries, required technical skills, and employment opportunities. My goal was to turn the available data into useful insights that can help aspiring Data Analysts make more informed career and learning decisions.

To structure the analysis, I developed five key questions:

### Q1. Which Data Analyst jobs offer the highest salaries?

Explore the 10 highest-paying remote Data Analyst positions with available salary information. This analysis helps highlight attractive remote job opportunities and gives an overview of the earning potential in the field.

### Q2. Which skills are associated with the highest-paying Data Analyst jobs?

Investigate the technical skills mentioned in top-paying Data Analyst job postings to understand which capabilities are associated with higher-salary positions.

### Q3. Which skills are most frequently requested in Data Analyst job postings?

Find the five most commonly requested skills across Data Analyst vacancies. This helps identify the technical knowledge that employers frequently look for when hiring candidates.

### Q4. Which technical skills are associated with higher salaries?

Compare average salaries across different skills to identify the technical capabilities that appear in better-paying job opportunities.

### Q5. Which skills provide the best combination of demand and salary?

Identify skills that are both frequently requested by employers and associated with attractive salary levels. The objective is to find skills worth prioritising when planning a Data Analyst learning path.

By investigating these five questions, I aimed to develop a better understanding of the current Data Analyst job market while applying SQL to practical data exploration and analysis. This project also gave me an opportunity to strengthen my PostgreSQL skills and gain hands-on experience working with a real-world dataset.

# Tools I Used
The following tools and technologies were used to complete this project:

- **PostgreSQL:** Used as the relational database management system to store, organise, and analyse job posting data.

- **Visual Studio Code (VS Code):** Used as the development environment to write, execute, and manage SQL queries.

- **SQL:** Used to retrieve, filter, join, aggregate, and analyse data across multiple tables.

- **Git & GitHub:** Used for version control, maintaining project files, and publishing the project as part of my Data Analyst portfolio.

# The Analysis
This project uses PostgreSQL to investigate different aspects of the Data Analyst job market. I developed SQL queries to explore salary opportunities, understand employer skill requirements, and examine how skill demand relates to earning potential.

The analysis is divided into five key areas:

### Q1. Top Paying Data Analyst Jobs
To answer this Q I used select, join, where and order by query to find top 10 paying data analyst jobs

#### SQL Concepts
- LEFT JOIN : to retrieve company names associated with job postings
- WHERE : to filter remote data analyst positions
- IS NOT NULL : to exclude job postings without salary information
- ORDER BY DESC : to rank jobs from highest to lowest salary
- LIMIT 10 : to retrieve only top 10 records 

#### My SQL Query : 
```sql
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
```

*Result of the query showing Top 10 Paying Data Analyst Jobs*
| Job ID | Company | Job Title | Job Schedule | Location | Posted Date | Yearly Salary ($) |
|---:|---|---|---|---|---|---:|
| 226942 | Mantys | Data Analyst | Full-time | Anywhere | 2023-02-20 | 650,000 |
| 547382 | Meta | Director of Analytics | Full-time | Anywhere | 2023-08-23 | 336,500 |
| 552322 | AT&T | Associate Director- Data Insights | Full-time | Anywhere | 2023-06-18 | 255,829.50 |
| 99305 | Pinterest Job Advertisements | Data Analyst, Marketing | Full-time | Anywhere | 2023-12-05 | 232,423 |
| 1021647 | Uclahealthcareers | Data Analyst (Hybrid/Remote) | Full-time | Anywhere | 2023-01-17 | 217,000 |
| 168310 | SmartAsset | Principal Data Analyst (Remote) | Full-time | Anywhere | 2023-08-09 | 205,000 |
| 731368 | Inclusively | Director, Data Analyst - HYBRID | Full-time | Anywhere | 2023-12-07 | 189,309 |
| 310660 | Motional | Principal Data Analyst, AV Performance Analysis | Full-time | Anywhere | 2023-01-05 | 189,000 |
| 1749593 | SmartAsset | Principal Data Analyst | Full-time | Anywhere | 2023-07-11 | 186,000 |
| 387860 | Get It Recruit - Information Technology | ERM Data Analyst | Full-time | Anywhere | 2023-06-09 | 184,000 |

#### Here's the breakdown of the Top data analyst jobs in 2023
- **Wide Salary Range :** Top 10 Data Analyst have salary range between $184,000 to $650,000
- **Diverse Employers :** Companies like Manties, Meta and AT & T are among those offering high salaries.
- **Job Title Variety** There is a high diversity in job titles from Data Analyst to Director of Analyst, reflecting varied roles and specializations within data analytics

### Q2. Top Paying Job Skills
To answer this question, I used a CTE, INNER JOIN, and ORDER BY to identify the skills required for the top 10 highest-paying remote Data Analyst jobs. This helps understand which technical skills are associated with high-paying opportunities and which skills job seekers can focus on developing.

#### SQL Concepts :
- **Common Table Expression (CTEs) :** Used to temporarily store the top 10 highest-paying remote Data Analyst jobs so they can be referenced in the main query. 
- **LEFT JOIN:** Used to retrieve company names from the `company_dim` table.
- **WHERE:** Used to filter remote Data Analyst jobs with available yearly salary information.
- **ORDER BY:** Used to sort jobs by yearly salary in descending order.
- **LIMIT:** Used to select only the top 10 highest-paying jobs.
- **INNER JOIN:** Used to connect the selected jobs with the skills tables to identify the skills required for each job.

#### My SQL Query :
```sql
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
```
*The visual graph showing the result we get Top paying job skills*
![Q2_Chart](/Images/Q2_Bar_Graph)   

#### Breakdown of the Top Paying Job Skills
- **SQL and Python** are the most frequently required skills, appearing in all 8 job postings. This shows that both are important technical skills for high-paying Data Analyst roles.
- **Tableau** is the third most common skill, appearing in 6 job postings, highlighting the importance of data visualization.
- **R, Pandas, Excel, and Snowflake** each appear in 3 job postings, showing the demand for programming, data manipulation, spreadsheet, and cloud data platform skills.
- **Azure, AWS, Oracle, Go, NumPy, Power BI, GitLab, Bitbucket, Atlassian, Jira, and Confluence** each appear in 2 job postings.
- Other skills, including **Databricks, PySpark, Jupyter, PowerPoint, Hadoop, Crystal, Flow, Git, SAP, and Jenkins**, appear in 1 job posting each.

**Conclusion:** SQL and Python are the most consistently required skills among the high-paying jobs analysed, followed by Tableau. Developing these skills, along with Excel, Power BI, and Python libraries such as Pandas and NumPy, can help aspiring Data Analysts build a stronger technical skill set.

###  Q3. Top Demanded Skills

To answer this question, I used **INNER JOIN, COUNT(), GROUP BY, ORDER BY, and LIMIT** to identify the top 5 most in-demand skills for Data Analyst positions. This analysis helps understand which skills are most frequently requested by employers and which technical skills aspiring Data Analysts should focus on learning.

#### SQL Concepts

- **INNER JOIN:** Used to connect the `skills_dim`, `skills_job_dim`, and `job_postings_fact` tables to retrieve skills associated with job postings.
- **WHERE:** Used to filter the data and include only Data Analyst job postings.
- **COUNT():** Used to count the number of job postings associated with each skill.
- **GROUP BY:** Used to group job postings by individual skills.
- **ORDER BY:** Used to sort skills based on the number of job postings in descending order.
- **LIMIT:** Used to display only the top 5 most in-demand skills.

#### My SQL Query
```sql
SELECT 
    skill.skills,
    COUNT(jobs.job_id) AS job_count
FROM skills_dim AS skill
INNER JOIN skills_job_dim AS skills_jobs
    ON skills_jobs.skill_id = skill.skill_id
INNER JOIN job_postings_fact AS jobs
    ON jobs.job_id = skills_jobs.job_id
WHERE
    jobs.job_title_short = 'Data Analyst'
GROUP BY
    skill.skills
ORDER BY
    job_count DESC
LIMIT 5;
```

*Top 5 demanded skills*
| Skill | Job Count |
|---|---:|
| SQL | 92,628 |
| Excel | 67,031 |
| Python | 57,326 |
| Tableau | 46,554 |
| Power BI | 39,468 |

#### Breakdown of the Top 5 demanded skills

- **SQL** is the most in-demand skill, appearing in 92,628 Data Analyst job postings. This highlights the importance of SQL for querying, managing, and analysing data.
- **Excel** ranks second with 67,031 job postings, showing that spreadsheet skills remain highly valuable for data analysis.
- **Python** ranks third with 57,326 job postings, demonstrating the demand for programming and data manipulation skills.
- **Tableau** appears in 46,554 job postings, highlighting the importance of data visualization and dashboard creation.
- **Power BI** ranks fifth with 39,468 job postings, showing strong demand for business intelligence and reporting skills.

**Conclusion:** SQL, Excel, and Python are the top three most in-demand skills for Data Analysts. Tableau and Power BI also have significant demand, making data visualization an important skill area. These results suggest that aspiring Data Analysts should build a strong foundation in SQL, Excel, Python, and at least one business intelligence tool.

### Q4. Top Paying Skills

To answer this question, I used a **subquery, INNER JOIN, AVG(), ROUND(), GROUP BY, ORDER BY, and LIMIT** to identify the top 10 skills associated with the highest average yearly salaries for Data Analyst positions. This analysis helps identify which skills are linked to higher-paying opportunities and can guide job seekers in prioritising valuable skills.

#### SQL Concepts

- **Subquery:** Used to join `skills_job_dim` with `skills_dim` and retrieve the skills associated with each job posting.
- **INNER JOIN:** Used to connect job postings with their required skills.
- **WHERE:** Used to include only Data Analyst job postings with available yearly salary information.
- **AVG():** Used to calculate the average yearly salary for each skill.
- **ROUND():** Used to round the average salary to two decimal places.
- **GROUP BY:** Used to group job postings by individual skills.
- **ORDER BY:** Used to sort skills by average yearly salary in descending order.
- **LIMIT:** Used to display only the top 10 skills with the highest average salaries.

#### My SQL Query

```sql
SELECT
    skills.skills,
    ROUND(AVG(jobs.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact AS jobs
INNER JOIN (
    SELECT
        skills_job.*,
        skills
    FROM skills_job_dim AS skills_job
    INNER JOIN skills_dim AS skills
        ON skills.skill_id = skills_job.skill_id
) AS skills
    ON skills.job_id = jobs.job_id
WHERE
    jobs.job_title_short = 'Data Analyst'
    AND jobs.salary_year_avg IS NOT NULL
GROUP BY
    skills.skills
ORDER BY
    avg_salary DESC
LIMIT 10;
```
*The visual representation of Top 10 highest paying skills*
![Q4_Graph](/Images/Q4_Graph)

#### Breakdown of the Top 10 Highest paying skills

- **SVN** ranks first with the highest average yearly salary of **$400,000**, making it the top-paying skill in this analysis.
- **Solidity** ranks second with an average yearly salary of **$179,000**, followed by **Couchbase** at **$160,515**.
- **DataRobot** and **Golang** also offer high average salaries of **$155,485.50** and **$155,000**, respectively.
- Skills such as **MXNet, Dplyr, VMware, and Terraform** have average yearly salaries ranging between approximately **$146,733 and $149,000**.
- **Twilio** ranks tenth with an average yearly salary of **$138,500**.

**Conclusion:** The results show that specialised technical skills such as SVN, Solidity, Couchbase, and DataRobot are associated with higher average salaries in this dataset. Developing expertise in specialised technologies may help Data Analysts explore higher-paying opportunities.

### Q5. Optimal Skills

To answer this question, I used **two CTEs, INNER JOIN, COUNT(), AVG(), ROUND(), GROUP BY, and ORDER BY** to identify skills that offer a combination of high demand and high average yearly salaries for remote Data Analyst positions. This analysis helps identify skills that are not only frequently required by employers but are also associated with higher-paying opportunities.

#### SQL Concepts

- **CTE (Common Table Expression):** Used to create two temporary result sets: `high_demand_skills` and `high_paying_skills`.
- **INNER JOIN:** Used to connect the skills and job posting tables to retrieve skill demand and salary information.
- **COUNT():** Used to calculate how many job postings require each skill.
- **AVG():** Used to calculate the average yearly salary associated with each skill.
- **ROUND():** Used to round average salaries to two decimal places.
- **GROUP BY:** Used to group job postings by skill.
- **WHERE:** Used to filter remote Data Analyst jobs with available yearly salary information in the demand CTE, and job postings with available yearly salaries in the salary CTE.
- **ORDER BY:** Used to rank skills by average yearly salary in descending order, followed by demand count.
- **LIMIT:** Used to display the top 25 skills.

#### My SQL Query
```sql
WITH high_demand_skills AS (
    SELECT
        skill.skill_id,
        skill.skills AS skill_name,
        COUNT(jobs.job_id) AS demand_count
    FROM skills_dim AS skill
    INNER JOIN skills_job_dim AS skills_jobs
        ON skills_jobs.skill_id = skill.skill_id
    INNER JOIN job_postings_fact AS jobs
        ON jobs.job_id = skills_jobs.job_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND jobs.salary_year_avg IS NOT NULL
    GROUP BY
        skill.skill_id
),
high_paying_skills AS (
    SELECT
        skill.skill_id,
        ROUND(AVG(jobs.salary_year_avg), 2) AS avg_salary
    FROM skills_dim AS skill
    INNER JOIN skills_job_dim AS skills_job
        ON skills_job.skill_id = skill.skill_id
    INNER JOIN job_postings_fact AS jobs
        ON jobs.job_id = skills_job.job_id
    WHERE
        jobs.salary_year_avg IS NOT NULL
    GROUP BY
        skill.skill_id
)

SELECT
    high_demand_skills.skill_id,
    high_demand_skills.skill_name,
    demand_count,
    avg_salary
FROM high_demand_skills
INNER JOIN high_paying_skills
    ON high_demand_skills.skill_id = high_paying_skills.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

*Optimal Skill*
| Skill | Demand Count | Average Yearly Salary ($) |
|---|---:|---:|
| Spark | 13 | 141,733.54 |
| Redshift | 16 | 140,791.90 |
| Hadoop | 22 | 138,574.38 |
| Snowflake | 37 | 137,960.50 |
| NoSQL | 13 | 137,039.29 |
| AWS | 32 | 136,480.71 |
| Java | 17 | 136,210.03 |
| C++ | 11 | 133,733.17 |
| BigQuery | 13 | 133,648.61 |
| Python | 236 | 132,439.63 |
| Go | 27 | 131,689.02 |
| Azure | 34 | 130,432.96 |
| Looker | 49 | 129,005.84 |
| R | 148 | 127,115.43 |
| SQL | 398 | 124,934.98 |
| Jira | 20 | 124,154.14 |
| Confluence | 11 | 123,223.30 |
| Flow | 28 | 120,211.32 |
| Tableau | 230 | 116,795.70 |
| Oracle | 37 | 115,124.95 |
| Qlik | 13 | 115,039.91 |
| JavaScript | 20 | 114,837.07 |
| Alteryx | 17 | 112,907.29 |
| SAS | 63 | 112,788.33 |

#### Breakdown

- **Spark** has the highest average yearly salary of **$141,733.54**, but appears in only 13 job postings, indicating high salary potential with relatively low demand.
- **SQL** is the most in-demand skill, appearing in **398 job postings**, with an average yearly salary of **$124,934.98**. This makes it a strong skill to prioritise because of its high demand and competitive salary.
- **Python** appears in **236 job postings**, with an average yearly salary of **$132,439.63**, making it another valuable skill that combines strong demand with high earning potential.
- **Tableau** is required in **230 job postings**, with an average yearly salary of **$116,795.70**, highlighting the importance of data visualization.
- **R** appears in **148 job postings**, with an average yearly salary of **$127,115.43**, showing that statistical programming skills are also valuable.
- **Snowflake, AWS, and Azure** have relatively strong demand, with 37, 32, and 34 job postings respectively, and average yearly salaries above $130,000.
- **Looker** has 49 job postings and an average yearly salary of **$129,005.84**, making it another skill worth considering.

**Conclusion:** SQL, Python, and Tableau stand out because of their high demand, while specialised technologies such as Spark, Snowflake, AWS, and Azure are associated with higher average salaries. For aspiring Data Analysts, building a strong foundation in SQL and Python while developing skills in data visualization and cloud technologies can provide a good balance between job opportunities and earning potential.

# What I Learned
Through this project, I gained practical experience in using PostgreSQL to explore and analyse real-world Data Analyst job market data. I strengthened my understanding of SQL concepts and learned how to extract meaningful insights from large datasets.

Some of the key things I learned include:

- **SQL Fundamentals:** Improved my understanding of SELECT, WHERE, ORDER BY, GROUP BY, LIMIT, and filtering conditions.
- **Joins:** Learned how to combine data from multiple tables using INNER JOIN and LEFT JOIN.
- **Aggregate Functions:** Practised COUNT(), AVG(), and ROUND() to calculate job counts and average yearly salaries.
- **CTEs and Subqueries:** Learned how to break complex queries into smaller, manageable steps and perform more advanced analysis.
- **Data Analysis:** Learned how to identify the highest-paying jobs, most in-demand skills, and skills associated with higher salaries.
- **Job Market Insights:** Understood how technical skills such as SQL, Python, Excel, Tableau, and Power BI are valued in the Data Analyst job market.
- **Problem Solving:** Improved my ability to approach business questions, write SQL queries, and interpret query results.
- **Git and GitHub:** Gained experience in managing project files using Git and publishing my work on GitHub.

# Conclusions
## Conclusion

Through this project, I explored the Data Analyst job market using PostgreSQL and analysed job postings to understand salary trends, in-demand skills, and the relationship between technical skills and earning potential.

The analysis revealed that SQL, Excel, Python, Tableau, and Power BI are among the most in-demand skills for Data Analysts. It also highlighted that specialised technologies such as Spark, Snowflake, AWS, and Azure are associated with higher average salaries in the dataset.

One of the key takeaways from this project is that choosing the right skills involves looking beyond salary alone. Both job demand and earning potential are important factors when deciding which technical skills to develop.

Overall, this project gave me an opportunity to apply my SQL knowledge to a real-world dataset, strengthen my analytical and problem-solving abilities, and gain a better understanding of the skills required in the Data Analyst job market.

This is my first SQL portfolio project, and it marks an important step in my journey towards becoming a Data Analyst.