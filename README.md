# Engeto SQL projekt
SQL projekt Engeto datové akademie.

# Zadání projektu
Vytvořit dvě základní tabulky:<br>
**t_{jmeno}_{prijmeni}_project_SQL_primary_final,<br> 
t_{jmeno}_{prijmeni}_project_SQL_secondary_final**,<br>
<br>
ze kterých mají být získávány prostřednictvím sad SQL uískávány odpovědi na výzkumné otázky:
1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

# Soubory v repozitáři
**Průvodní zpráva k projektu**<br>
SQL_projekt_pruvodni_zprava.pdf

**Základní tabulky**<br>
project_SQL_primary_final.sql<br>
project_SQL_secondary_final.sql

**SQL soubory podle výzkumných otázek**<br>
01_vyvoj_mezd_podle_odvetvi.sql<br>
02_mleko_chleba_za_mzdu.sql<br>
03_nejmensi_mezirocni_narust_cen.sql<br>
04_ceny_vs_mzdy.sql<br>
05_hdp_vs_ceny_a_mzdy

# Spuštění projektu
Pro spuštění projektu je třeba nejprve otevřít soubor **project_SQL_primary_final.sql** a spustit v něm obsažené selecty. Tím se vytvoří základní tabulka, která obsahuje veškerá data potřebná pro soubory sql, které poskytují podklad pro zodpovězení výzkumných otázek.
