/*
 * 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
*/

WITH price_differences AS
	(
		SELECT 
			price_year,
			AVG(avg_price) AS overall_avg_price
		FROM
			t_milan_novak_project_sql_primary_final
		GROUP BY 
			price_year
	),
	wage_differences AS
	(
		SELECT 
			industry_branch_code,
			payroll_year,
			AVG(avg_wages) AS overall_avg_wages 
		FROM 
			t_milan_novak_project_sql_primary_final
		GROUP BY 
			payroll_year
	),
	price_wage_differences AS 
	(
		SELECT 
			payroll_year,
			(
				overall_avg_price - LAG(overall_avg_price) OVER
				(ORDER BY price_year)
			) 
				/ LAG(overall_avg_price) OVER
				(ORDER BY price_year) 
				* 100 
			AS price_diff_per_cent,
			(
				overall_avg_wages - LAG(overall_avg_wages) OVER
				(ORDER BY payroll_year)
			) 
				/ LAG(overall_avg_wages) OVER
				(ORDER BY payroll_year) 
				* 100 
			AS wage_diff_per_cent			
		FROM
			price_differences AS pd
		JOIN 
			wage_differences AS wd
		ON
			pd.price_year = wd.payroll_year
	)
SELECT 
	payroll_year,
	ROUND(price_diff_per_cent - wage_diff_per_cent, 2) AS price_wage_diff
FROM 
	price_wage_differences 
GROUP BY 
	payroll_year 
ORDER BY 
	(price_diff_per_cent - wage_diff_per_cent) DESC;