/*
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
*/

WITH price_differences_per_category AS 
(
	SELECT 
		category_code,
		category_name,
		price_year,
		avg_price,
		ROUND(
				(
					avg_price - LAG(avg_price) OVER
			   		(PARTITION BY category_code 
					ORDER BY price_year)
				) 
					/ LAG(avg_price) OVER 
					(PARTITION BY category_code 
					ORDER BY price_year)
					* 100, 2
			  ) AS price_diff_per_cent_category
	FROM
		t_milan_novak_project_sql_primary_final AS tmnpspf
	WHERE 
		category_code IS NOT NULL
	GROUP BY 
		category_code,
		price_year
)
SELECT
	category_code,
	category_name,
	ROUND(AVG(price_diff_per_cent_category), 2) AS total_price_diff_per_cent
FROM
	price_differences_per_category
WHERE
	price_diff_per_cent_category IS NOT NULL
GROUP BY
	category_code
ORDER BY
	total_price_diff_per_cent;