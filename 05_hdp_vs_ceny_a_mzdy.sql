/*	
 * Má výška HDP vliv na změny ve mzdách a cenách potravin?
 * 
 * Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách 
 * ve stejném nebo následujícím roce výraznějším růstem? 
*/

WITH GDP_differences AS 
	(
		SELECT 
			`year`,
			GDP,
			ROUND(
					(
						GDP - LAG(GDP) OVER 
						(ORDER BY `year`)
					) 
						/ LAG(GDP) OVER 
						(ORDER BY `year`) 
						* 100, 2
				 ) AS GDP_diff_per_cent
		FROM 
			t_milan_novak_project_sql_primary_final AS tmnpspf 
	),
	price_differences AS 
	(
		SELECT 
			price_year,
			AVG(avg_price) AS avg_annual_price
		FROM 
			t_milan_novak_project_sql_primary_final AS tmnpspf 
		GROUP BY 
			price_year 
	),
	wage_differences AS 
	( 
		SELECT 
			payroll_year,
			AVG(avg_wages) AS avg_annual_wages 
		FROM 
			t_milan_novak_project_sql_primary_final AS tmnpspf 
		GROUP BY 
			payroll_year 
	),
	results AS 
	( 
		SELECT *
		FROM 
			GDP_differences AS gd
		JOIN
			price_differences AS pd
		ON
			gd.`year` = pd.price_year
		JOIN 
			wage_differences AS wd
		ON 
			gd.`year` = wd.payroll_year
		GROUP BY 
			`year`
	)		
SELECT 
	`year`,
	ROUND(GDP, 2) AS GDP,
	GDP_diff_per_cent,
	ROUND(
			(
				avg_annual_price - LAG(avg_annual_price) OVER 
				(ORDER BY price_year)
			) 
				/ LAG(avg_annual_price) OVER 
				(ORDER BY price_year) 
				* 100, 2
		 ) AS avg_annual_price_diff_per_cent,
	ROUND(
			(
				avg_annual_wages - LAG(avg_annual_wages) OVER 
				(ORDER BY payroll_year)
			) 
				/ LAG(avg_annual_wages) OVER 
				(ORDER BY payroll_year) 
				* 100, 2
		 ) AS avg_annual_wages_diff_per_cent
FROM results;