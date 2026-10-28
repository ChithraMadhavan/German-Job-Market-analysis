
# German Job Market Analysis & Skills Demand Dashboard

## Project Overview

This project analyzes German job postings related to Data Analyst, Business Analyst, Business Intelligence, BI Analyst, and Reporting Analyst roles. It uses Python, MySQL, and Power BI to explore job-posting patterns, regional distribution, seniority levels, employer activity, and frequently listed skills.

The goal is to turn raw job-posting data into meaningful insights through data cleaning, SQL analysis, and interactive visualization.

## Business Objectives

- Analyze the distribution of analyst-related job postings across German regions.
- Identify employers with the highest number of postings in the selected dataset.
- Examine the distribution of junior, entry-level, senior, and lead roles.
- Explore posting trends over time.
- Identify frequently occurring skill labels.
- Build an interactive dashboard with region and seniority filters.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data preparation and cleaning |
| Pandas | Data manipulation and analysis |
| MySQL | Data storage and SQL querying |
| SQL | Aggregation, ranking, filtering, and trend analysis |
| Power BI | Interactive dashboard and visualizations |
| DAX | KPI measures and calculations |
| GitHub | Project documentation and portfolio presentation |

## Dataset

**Source:** [German Job Postings — Hugging Face](https://huggingface.co/datasets/mischeiwiller/german-job-postings)

The original dataset contains 70,584 rows and 19 columns. The project filters it to analyst-related job titles for a focused analysis.

- Filtered job-posting records: **234**
- Skill records: **1,170**
- Data coverage: historical postings through **5 June 2026**

The cleaned job-postings table contains fields such as job ID, title, employer, region, posting date, seniority, salary range, source, and source URL.

## Data Preparation

The workflow includes:

1. Loading the original dataset using Python and Pandas.
2. Filtering job titles relevant to analyst and business intelligence roles.
3. Preparing a cleaned job-postings dataset.
4. Creating a separate skills dataset for skill-frequency analysis.
5. Importing the cleaned CSV files into MySQL.
6. Validating record counts and checking for missing values.
7. Connecting the prepared datasets to Power BI.

## SQL Analysis

SQL queries are used to investigate:

- Job postings by region and seniority.
- Top employers by posting count.
- Monthly posting trends.
- Frequently occurring skill labels.
- Junior and entry-level postings.
- Salary-data availability.
- Duplicate job IDs and missing values.
- Regional shares and employer rankings using window functions.

## Power BI Dashboard

The interactive dashboard includes:

- **KPI cards:** Total job postings, junior/entry postings, and skill records.
- **Job Postings by Region:** Regional distribution of analyst-related roles.
- **Top 10 Employers:** Employers with the highest posting counts.
- **Job Postings by Seniority:** Distribution across seniority categories.
- **Monthly Posting Trend:** Posting counts over time.
- **Top 10 Skills:** Most frequently occurring skill labels.
- **Interactive slicers:** Filter the report by region and seniority.

## Key Findings

- The filtered dataset contains **234 analyst-related job postings**.
- **19 postings** are classified as junior or entry-level.
- **Nordrhein-Westfalen** has the highest regional count, with 56 postings, followed by Hessen with 41.
- The seniority field is unknown for 196 postings, limiting conclusions about experience requirements.
- Skill labels related to data analysis and business analysis occur frequently in the extracted skills dataset.

These findings describe the selected dataset, not the entire German job market.

## Limitations

- The dataset is historical and is not a live feed of current vacancies.
- June 2026 contains data only through 5 June.
- The region field does not necessarily identify a specific city, such as Munich.
- Salary information is incomplete.
- Some extracted skill labels may be noisy or may not directly represent explicit job-advertisement requirements.
- Seniority is unknown for many postings.

## Project Workflow

**Data source → Python cleaning → CSV datasets → MySQL analysis → Power BI dashboard → Business insights**

## Skills Demonstrated

Python · Pandas · SQL · MySQL · Power BI · DAX · Data Cleaning · Exploratory Data Analysis · Data Visualization · Business Intelligence · Data Storytelling

## Conclusion

This project demonstrates an end-to-end data analytics workflow, from preparing raw data to analyzing it with SQL and presenting findings through an interactive Power BI dashboard. It showcases practical skills in data preparation, analytical querying, visualization, and communicating data limitations.
