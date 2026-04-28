SELECT *
FROM world_layoffs.layoffs;

CREATE TABLE layoffs_staging
LIKE world_layoffs.layoffs;

SELECT *
FROM world_layoffs.layoffs_staging;

INSERT world_layoffs.layoffs_staging
SELECT *
FROM world_layoffs.layoffs;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS num_of_rows
FROM world_layoffs.layoffs_staging;

WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS num_of_rows
FROM world_layoffs.layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE num_of_rows > 1;



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `num_of_rows` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM world_layoffs.layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, 
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS num_of_rows
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE num_of_rows > 1;

-- Turn off safe mode
SET SQL_SAFE_UPDATES = 0;

-- Delete duplicates
DELETE FROM layoffs_staging2
WHERE num_of_rows > 1;

SELECT *
FROM layoffs_staging2
WHERE num_of_rows > 1;

DELETE FROM layoffs_staging2
WHERE num_of_rows > 1;

SELECT *
FROM layoffs_staging2
WHERE num_of_rows > 1;


-- Check first
SELECT company, TRIM(company)
FROM layoffs_staging2;

-- Then update
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Check for inconsistencies
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Check for inconsistencies
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- Fix trailing periods e.g 'United States.'
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Check current format
SELECT `date`
FROM layoffs_staging2;

-- Convert from text to proper date format
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Change column type to DATE
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';
SELECT company, industry, LENGTH(industry), ISNULL(industry)
FROM layoffs_staging2
WHERE company = 'Airbnb';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry = ''
AND t2.industry IS NOT NULL
AND t2.industry != '';

SELECT company, industry, LENGTH(industry), ISNULL(industry)
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN num_of_rows;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT MAX(total_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company 
ORDER BY 2 DESC;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT SUBSTRING(`date`, 1, 7 ) AS 'Month' , SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7 ) IS NOT NULL
GROUP BY `Month`
ORDER BY 1 ASC;

WITH Rolling_total AS
(
    SELECT SUBSTRING(`date`, 1, 7) AS 'Month', SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `Month`
    ORDER BY 1 ASC
)
SELECT `Month`, total_off
,SUM(total_off)
OVER(ORDER BY `Month`) AS Rolling_total
FROM Rolling_total;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

With Company_Year(company, years, total_laid_off)
AS (
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
),
Company_Year_Rank
AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
) 
SELECT  *
FROM Company_Year_Rank
WHERE Ranking >= 5;


SELECT  *
FROM layoffs_staging2

