/*
* Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států 
* ve stejném období, jako primární přehled pro ČR.
*/
CREATE TABLE t_milan_novak_project_SQL_secondary_final AS 
SELECT 
	`year`,
	country AS name_of_country,
	population,
	ROUND(GDP, 2) AS GDP_rounded,
	gini
FROM
	economies AS e
WHERE 
	`year` BETWEEN 2006 AND 2018
	AND 
	country != "Czech Republic"
	AND
	country IN 
		(
			SELECT 
				country
			FROM 
				countries AS c 
			WHERE 
				continent = "Europe"
		)
ORDER BY 
	country,
	`year`;