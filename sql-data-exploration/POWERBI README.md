# Power BI Capstone Project — Addy Monk PLC Employee Analysis

## About the Project
The CEO of Addy Monk PLC, Mrs. Adriana Monk, needed help analysing the company's 
employee data to guide decisions around gender gaps in the workplace. I was tasked 
with cleaning the data, analysing it and presenting the findings in a clear dashboard.

## Dataset
The dataset contained 1,015 employee records across 6 columns — Name, Gender, 
Department, Salary, Location and Rating.

## Data Cleaning (Power Query)
Before building anything I had to clean the data:
- Removed employees with no salary (they had left the company)
- Removed departments listed as NULL
- Fixed location spelling errors (California, Los Angeles, Mississippi)
- Relabelled undisclosed genders as Non-disclosed
- After cleaning, 946 rows remained

## Questions Answered

**1. Gender Distribution**
- 874 active employees — 430 Male, 406 Female, 38 Non-disclosed
- Males slightly dominate across most departments and regions
- Visualised through donut chart, and bar charts by department and region

**2. Ratings by Gender**
- Most employees across both genders fall under the Average rating
- Males earn slightly more than females at almost every rating level

**3. Gender Pay Gap**
- Company average salary: $73.7K
- Female average: $72.1K | Male average: $74.8K
- Pay gap: 3.5% in favour of males
- Largest departmental gaps: Business Development and Marketing
- Largest regional gap: California

**4. $90,000 Minimum Wage Regulation**
- Addy Monk does NOT fully meet the requirement
- A significant number of employees still fall below the $90K threshold
- Visualised through salary band distribution ($10K bands from $20K to $120K)

**5. Bonus and Total Compensation**
- Bonus = 10% of each employee's salary (calculated using DAX)
- Total Pay = Salary + Bonus
- Total company compensation: $76.70M
- Total bonus payout: $6.97M
- Average bonus per employee: $7.37K
- Broken down by region and department

## Recommendations
- **Address the gender pay gap** — particularly in Business Development, 
  Marketing and California where the gap is widest
- **Review salaries below $90K** to comply with the new manufacturing regulation
- **Investigate the rating distribution** — the majority of employees rated 
  Average suggests the rating system may need restructuring
- **Focus retention efforts** on Non-disclosed gender employees as their 
  smaller numbers may indicate disengagement

## Tools Used
- Power BI Desktop
- Power Query (data cleaning)
- DAX (calculated columns and measures)

## Author
**Ebuka Agwuegbo** — Aspiring Data Analyst
[GitHub Profile](https://github.com/Ebukaaa2002)
