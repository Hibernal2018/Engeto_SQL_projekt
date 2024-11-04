/*
 * Otázka č.1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
*/

WITH yearly_wages_industry AS
	(
	SELECT 
		industry_branch_code,
		branch_name,
		value_type_code,
		value_name,
		calculation_code,
		calculation_name,
		payroll_year,
		avg_wages,
		ROUND(AVG(avg_wages), 2) AS avg_wages_per_year
	FROM 
		t_milan_novak_project_sql_primary_final AS tmnpspf 
	WHERE 
		payroll_year < 2021
		AND 
		industry_branch_code IS NOT NULL
	GROUP BY 
		industry_branch_code,
		payroll_year
	)
SELECT 
	industry_branch_code,
	branch_name,
	value_type_code,
	value_name,
	calculation_code,
	calculation_name,
	payroll_year,
	avg_wages_per_year,
	ROUND(
			(
				avg_wages_per_year - LAG(avg_wages_per_year) OVER
				(PARTITION BY industry_branch_code ORDER BY payroll_year)
			) 
				/ LAG(avg_wages_per_year) OVER 
				(PARTITION BY industry_branch_code ORDER BY payroll_year)
				* 100, 2
		  ) AS wage_diff_per_cent 
FROM 
	yearly_wages_industry
GROUP BY 
	industry_branch_code,
	payroll_year;