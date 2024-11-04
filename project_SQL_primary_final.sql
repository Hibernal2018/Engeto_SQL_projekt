/*
 * vytvoření view z tabulky czechia_payroll
*/

CREATE OR REPLACE 
VIEW v_milan_novak_czechia_payroll AS
SELECT
	industry_branch_code,
	value_type_code,
	calculation_code,
	payroll_year,
	AVG(value) AS avg_wages
FROM 
	czechia_payroll AS cp 
WHERE 
	value_type_code = 5958
	AND 
	calculation_code = 100
GROUP BY 
	industry_branch_code,
	payroll_year 
ORDER BY 
	industry_branch_code,
	payroll_year;

/*
 * vytvoření view z tabulky czechia_price 
*/

CREATE OR REPLACE 
VIEW v_milan_novak_czechia_price AS 
SELECT 
	category_code,
	YEAR(date_from) AS price_year,
	ROUND(AVG(value), 2) AS avg_price
FROM 
	czechia_price AS cp 
GROUP BY 
	category_code,
	price_year 
ORDER BY 
	category_code,
	price_year; 

/*
 * vytvoření view z tabulky economies
*/

CREATE OR REPLACE 
VIEW v_milan_novak_economies AS
SELECT 
	`year`,
	GDP,
	population,
	gini
FROM 
	economies AS e 
WHERE 
	country = "Czech Republic"
ORDER BY 
	`year`;

/*
 * vytvoření tabulky SQL_primary_final
*/

CREATE TABLE t_milan_novak_project_SQL_primary_final AS
SELECT 
	vmncp.industry_branch_code,
	cpib.name AS branch_name,
	vmncp.value_type_code,
	cpvt.name AS value_name,
	vmncp.calculation_code,
	cpc2.name AS calculation_name,
	vmncp.payroll_year,
	vmncp.avg_wages,
	vmncp2.price_year,
	vmncp2.avg_price,
	vmncp2.category_code,
	cpc.name AS category_name,
	vmne.`year`,
	vmne.GDP,
	vmne.population,
	vmne.gini
FROM v_milan_novak_czechia_payroll AS vmncp 
LEFT JOIN czechia_payroll_industry_branch AS cpib 
	ON
	vmncp.industry_branch_code = cpib.code
LEFT JOIN czechia_payroll_value_type AS cpvt 
	ON
	vmncp.value_type_code = cpvt.code
LEFT JOIN czechia_payroll_calculation AS cpc2 
	ON 
	vmncp.calculation_code = cpc2.code
LEFT JOIN v_milan_novak_czechia_price AS vmncp2
	ON
	vmncp.payroll_year = vmncp2.price_year 
LEFT JOIN czechia_price_category AS cpc 
	ON 
	vmncp2.category_code = cpc.code
LEFT JOIN v_milan_novak_economies AS vmne 
	ON 
	vmncp.payroll_year = vmne.`year`;