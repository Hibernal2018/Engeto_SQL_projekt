/*
 * /Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
*/

WITH average_wages AS	
(
	SELECT 
		ROUND(AVG(avg_wages), 2) AS avg_wages_per_year,
		payroll_year
	FROM
		t_milan_novak_project_sql_primary_final AS tmnpspf
	WHERE 
		payroll_year = 2006
		OR 
		payroll_year = 2018
	GROUP BY 
		payroll_year
),
average_prices AS
(
	SELECT 
		avg_price,
		category_code,
		category_name,
		price_year
	FROM
		t_milan_novak_project_sql_primary_final AS tmnpspf
	WHERE 
		(category_code = 114201
		OR 
		category_code = 111301)
		AND 
		(price_year = 2006
		OR 
		price_year = 2018)
	GROUP BY
		category_code,
		price_year
)
SELECT 
	ap.price_year,
	ap.category_code,
	ap.category_name,
	ap.avg_price,
	aw.avg_wages_per_year,
	FLOOR ((aw.avg_wages_per_year / ap.avg_price)) AS units_for_wages
FROM
	average_prices AS ap
JOIN average_wages AS aw
	ON
	ap.price_year = aw.payroll_year;	