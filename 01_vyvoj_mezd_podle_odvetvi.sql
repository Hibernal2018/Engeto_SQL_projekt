/*
 * Otázka č.1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
*/

SELECT
	industry_branch_code,
	branch_name,
	value_type_code,
	value_name,
	calculation_code,
	calculation_name,
	payroll_year,
	avg_wages,
	ROUND(
			(
				avg_wages - LAG(avg_wages) OVER
				(PARTITION BY industry_branch_code ORDER BY payroll_year)
			) 
				/ LAG(avg_wages) OVER 
				(PARTITION BY industry_branch_code ORDER BY payroll_year)
				* 100, 2
		  ) AS wage_diff_per_cent 
FROM 
	t_milan_novak_project_sql_primary_final as tmnpspf
WHERE 
	payroll_year < 2021
	AND 
	industry_branch_code IS NOT NULL
GROUP BY 
	industry_branch_code,
	payroll_year,
	avg_wages,
	branch_name,
	value_type_code,
	value_name,
	calculation_code,
	calculation_name;
