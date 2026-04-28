# World Layoffs — MySQL Data Cleaning & EDA Project

## What This Project Is About
I came across a dataset tracking company layoffs across the world between 2020 and 2023
and decided to use it to practice my SQL skills. The main goal was to clean up the raw 
data and then dig into it to find some interesting patterns.

## The Dataset
The database is called `world_layoffs` and it has three tables:
- `layoffs` — the original raw data. I never touched this one.
- `layoffs_staging` — my first working copy where I started cleaning.
- `layoffs_staging2` — the final cleaned version I used for analysis.

Keeping the raw table untouched was intentional — it's good practice so you always 
have something to go back to if things go wrong.

## Data Cleaning
The raw data had a lot of issues — duplicates, inconsistent formatting, blank fields, 
and dates stored as text. Here's what I did to fix it:
- Removed duplicate rows using ROW_NUMBER() inside a CTE
- Trimmed and standardized company names, industries, and country names
- Filled in or removed NULL and blank values where appropriate
- Converted the date column from text to an actual DATE type using STR_TO_DATE()
- Dropped helper columns that were only needed during the cleaning process

## Exploratory Data Analysis
Once the data was clean, I explored it to answer questions like:
- Which companies laid off the most people?
- Which industries and countries were hit hardest?
- How did layoffs trend month by month over time?
- Who were the top 5 companies with the most layoffs each year?

I used a rolling total to track cumulative layoffs over time and DENSE_RANK() 
to rank companies by year.

## SQL Skills Practiced
CTEs, Window Functions (ROW_NUMBER, DENSE_RANK, SUM OVER), aggregate functions, 
string functions, and multi-step staging for safe data cleaning.

## About Me
I'm Ebuka, an aspiring data analyst actively building my skills.
GitHub: https://github.com/Ebukaaa2002
