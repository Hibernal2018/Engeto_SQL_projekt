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
	) 
SELECT
	gd.`year`,
	ROUND(gd.GDP, 2),
	gd.GDP_diff_per_cent,
	pd.price_year,
	pd.avg_annual_price,
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
				avg_wages - LAG(avg_wages) OVER 
				(ORDER BY payroll_year)
			) 
				/ LAG(avg_wages) OVER 
				(ORDER BY payroll_year) 
				* 100, 2
		 ) AS avg_annual_wages_diff_per_cent
FROM 
	GDP_differences AS gd
JOIN
	price_differences AS pd
ON
	gd.`year` = pd.price_year
JOIN 
	t_milan_novak_project_sql_primary_final AS tmnpspf
ON 
	gd.`year` = tmnpspf.payroll_year
WHERE gd.GDP_diff_per_cent != 0
GROUP BY 
	gd.`year`,
	gd.`year`,
	gd.GDP,
	gd.GDP_diff_per_cent,
	pd.price_year,
	pd.avg_annual_price;