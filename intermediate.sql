#1 Write a query to count the number of non-null rows in the low column.

SELECT COUNT(low) AS low
  FROM tutorial.aapl_historical_stock_price

- it shows how many prices were considered in the low column, and "as low" changes the name of the column
from count to low since we're referencing the low column.

#2 Write a query that determines counts of every single column. Which column has the most null values?

SELECT COUNT(year) AS year,
       COUNT(month) AS month,
       COUNT(open) AS open,
       COUNT(high) AS high,
       COUNT(low) AS low,
       COUNT(close) AS close,
       COUNT(volume) AS volume
  FROM tutorial.aapl_historical_stock_price

- it shows each column, their counts, and labels each column to make it more organized. 

#3 Write a query to calculate the average opening price 
(hint: you will need to use both COUNT and SUM, as well as some simple arithmetic.).

SELECT COUNT(open) AS "opening price",
       SUM(open) AS "sum of opening price",
       AVG(open) AS "average of opening price"
  FROM tutorial.aapl_historical_stock_price

- it shows me how many columns are in the opening price, the sum of every column, and the average. 

#4 What was Apple's lowest stock price (at the time of this data collection)?

SELECT MIN(low)
  FROM tutorial.aapl_historical_stock_price

- it shows the minimun/lowest number in reference to the stock price. 

#5 What was the highest single-day increase in Apple's share value?

SELECT MAX(CLOSE - OPEN)
  FROM tutorial.aapl_historical_stock_price

- it shows the max increase from close to open of the entire day. 

#6 Write a query that calculates the average daily trade volume for Apple stock.

SELECT AVG(volume) as "average volume"
  FROM tutorial.aapl_historical_stock_price

- it calculates the average daily trade volume for the stock, and labels the column average volume for organization

#7 Calculate the total number of shares traded each month. Order your results chronologically.

SELECT year,
       month,
       SUM(volume) AS volume_sum
  FROM tutorial.aapl_historical_stock_price
 GROUP BY year, month
 ORDER BY year, month

- it orders the columns by year, month, then sum. Orders the year in chronological order, along with the month 
and volume sum accordingly. 

#8 Write a query to calculate the average daily price change in Apple stock, grouped by year.

SELECT year,
AVG(close-open) AS "average daily price change"
FROM tutorial.aapl_historical_stock_price
GROUP BY year
ORDER BY year

- it shows the average daily price change per year, from close to open, in chronological order. 

#9 Write a query that calculates the lowest and highest prices that Apple stock achieved each month.

SELECT year,
       month,
      MIN(low) as "lowest stock price",
      MAX(high) as "highest stock price"
FROM tutorial.aapl_historical_stock_price 
GROUP BY year, month
ORDER BY year, month

- it organizes the graph by year and month, along with the lowest and highest stock price associated with each year, and 
each month associated in each year.

#10 Write a query that includes a column that is flagged "yes" when a player is from California, 
and sort the results with those players first.

SELECT player_name,
       hometown,
       CASE WHEN state = 'CA' THEN 'yes'
            ELSE NULL END AS "Is Player From CA?"
  FROM benn.college_football_players
 ORDER BY 3

- so this code says yes when the player is from California/CA. If the player is not from CA, it will show a null value.
ORDER BY 3 allows all players to be shown first if they're from CA. 

#11 Write a query that includes players' names and a column that classifies them into four categories based on height. 
Keep in mind that the answer we provide is only one of many possible answers, since you could divide players' heights 
in many ways.

SELECT player_name,
       height,
       CASE WHEN height > 74 THEN 'over 74'
            WHEN height > 72  AND height <= 73 THEN '72-73'
            WHEN height > 70 AND height <= 72 THEN '70-71'
            ELSE 'under 70' END AS height_group
  FROM benn.college_football_players

- this code divides the height of all the football players into 4 categories. 

#12 Write a query that selects all columns from benn.college_football_players and 
adds an additional column that displays the player's name if that player is a junior or senior.

SELECT *,
CASE WHEN year = 'JR' OR year = 'SR' then player_name
ELSE NULL END AS "Upperclassmen"
FROM benn.college_football_players

- this code displays the top 100 players and their stats. It also adds on a category to display whether or not the player
is a junior or senior, or in other words an "Upperclassmen"

#13 Write a query that counts the number of 300lb+ players for each of the following regions: 
West Coast (CA, OR, WA), Texas, and Other (Everywhere else).

SELECT CASE WHEN state IN ('CA', 'OR', 'WA') THEN 'West Coast'
            WHEN state = 'TX' THEN 'Texas'
            ELSE 'Other' END AS "Regions",
            COUNT(1) AS "Players"
  FROM benn.college_football_players
 WHERE weight >= 300
 GROUP BY 1

- this code shows how many players in each location weigh over 300 lbs. 

#14 Write a query that calculates the combined weight of all underclass players (FR/SO) in California 
as well as the combined weight of all upperclass players (JR/SR) in California.

SELECT CASE WHEN year IN ('FR', 'SO') THEN 'underclass'
            WHEN year IN ('JR', 'SR') THEN 'upperclass'
            ELSE NULL END AS class_group,
       SUM(weight) AS combined_player_weight
  FROM benn.college_football_players
 WHERE state = 'CA'
 GROUP BY 1

-it shows the combined weight for all the players, based on whether they're an underclassmen or an upperclassmen. 

#15 Write a query that displays the number of players in each state, with FR, SO, JR, and SR players in separate columns and another column for the total number of players. 
Order results such that states with the most players come first.

SELECT state,
       COUNT(CASE WHEN year = 'FR' THEN 1 ELSE NULL END) AS fr_count,
       COUNT(CASE WHEN year = 'SO' THEN 1 ELSE NULL END) AS so_count,
       COUNT(CASE WHEN year = 'JR' THEN 1 ELSE NULL END) AS jr_count,
       COUNT(CASE WHEN year = 'SR' THEN 1 ELSE NULL END) AS sr_count,
       COUNT(1) AS total_players
  FROM benn.college_football_players
 GROUP BY state
 ORDER BY total_players DESC

- this code displays the code in a horizontal way rather than the typical vertical way. It also shows how many players
are freshmen, sophmores, juniors, and seniors based off their state. Also shows the total players combined, in each state.

#16 Write a query that shows the number of players at schools with names that start with A through M, 
and the number at schools with names starting with N - Z.

SELECT CASE WHEN school_name < 'n' THEN 'A-M'
            WHEN school_name >= 'n' THEN 'N-Z'
            ELSE NULL END AS school_name_group,
       COUNT(1) AS players
  FROM benn.college_football_players
 GROUP BY 1
 ORDER BY 1

- this code shows school names in two categories, those that fall between A-M, and those that fall between 'N-Z'.
It also shows how many players go to schools with names that fall into either of the two categories.

#17 Write a query that returns the unique values in the year column, in chronological order.

SELECT DISTINCT year
  FROM tutorial.aapl_historical_stock_price
  ORDER BY year

- it shows only the year in chronological order 

#18 Write a query that counts the number of unique values in the month column for each year

SELECT year,
      COUNT(DISTINCT month) as unique_month_values
FROM tutorial.aapl_historical_stock_price
GROUP BY year

- it shows the unique values in the month column, based off the year. 

#19 Write a query that separately counts the number of unique values in the month column and 
the number of unique values in the `year` column.

SELECT COUNT(DISTINCT month) as unique_month_values,
       COUNT(DISTINCT year) as unique_year_values
FROM tutorial.aapl_historical_stock_price

- this code displayst he number of month and year values in seperate columns, horizontally. 

#20 Write a query that selects the school name, player name, position, and weight for every player in Georgia, 
ordered by weight (heaviest to lightest). Be sure to make an alias for the table, and to reference all column names 
in relation to the alias.

SELECT players.player_name,
       players.school_name,
      players.position,
      players.weight
FROM benn.college_football_players players
WHERE players.state = 'GA'
ORDER BY players.weight DESC

- this code selects 4 specific columns from the data set, and gives the data set an alias by putting a space in between
the data set name and the alias of your preference. Once you have your alias, you put it before the column name following
a period. It also shows the weight from all players from Georgia, in descending order.

#21 Write a query that displays player names, school names and conferences for schools in the 
"FBS (Division I-A Teams)" division.

SELECT players.player_name,
       players.school_name,
       teams.conference
  FROM benn.college_football_players players
  JOIN benn.college_football_teams teams
    ON teams.school_name = players.school_name
 WHERE teams.division = 'FBS (Division I-A Teams)'

- this code uses a previous alias from both data sets to display school names BOTH teams have in common. Which are 
referred to as INNER JOINS aka an intersection of two tables. 

#22 Write a query that performs an inner join between the tutorial.crunchbase_acquisitions table and 
the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of 
non-null rows in each table.

SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

- this code joins two data sets together, and displays/counts what each data set has in common. But in this case, 
it counts how many non null rows each data set equally has.

#23 Modify the query above to be a LEFT JOIN. Note the difference in results.

SELECT COUNT(companies.permalink) AS companies_rowcount,
       COUNT(acquisitions.company_permalink) AS acquisitions_rowcount
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink

- this code displays the results of a left join, compared to an inner join from the previous code. The difference is 
there's MORE values in acquisitions than companies. That is because in a left join it retuns unmatched values from the 
LEFT table(acquisitions).  

#24 Count the number of unique companies (don't double-count companies) and unique acquired companies by state. 
Do not include results for which there is no state data, and order by the number of acquired companies from highest 
to lowest.

SELECT companies.state_code,
       COUNT(DISTINCT companies.permalink) AS unique_companies,
       COUNT(DISTINCT acquisitions.company_permalink) AS acquired_companies
  FROM tutorial.crunchbase_acquisitions acquisitions
 LEFT JOIN tutorial.crunchbase_companies companies
    ON companies.permalink = acquisitions.company_permalink
 WHERE companies.state_code IS NOT NULL
 GROUP BY 1
 ORDER BY 3 DESC

- this code displays the state code, and the number of total and aquired companies each state has. 

#25 Rewrite the previous practice query in which you counted total and acquired companies by state, 
but with a RIGHT JOIN instead of a LEFT JOIN. The goal is to produce the exact same results.

SELECT companies.state_code,
       COUNT(DISTINCT companies.permalink) AS unique_companies,
       COUNT(DISTINCT acquisitions.company_permalink) AS unique_companies_acquired
  FROM tutorial.crunchbase_companies companies
  RIGHT JOIN tutorial.crunchbase_acquisitions acquisitions
    ON companies.permalink = acquisitions.company_permalink
 WHERE companies.state_code IS NOT NULL
 GROUP BY 1
 ORDER BY 3 DESC

- producing the same results as the left join.


#26 Write a query that shows a company's name, "status" (found in the Companies table), 
and the number of unique investors in that company. Order by the number of investors from most to fewest. 
Limit to only companies in the state of New York. 

SELECT companies.name AS company_name,
       companies.status,
       COUNT(DISTINCT investments.investor_name) AS unqiue_investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 WHERE companies.state_code = 'NY'
 GROUP BY 1,2
 ORDER BY 3 DESC

- this code shows the company name, its status, and the # of investors within the company ordered from most the fewest.
Based only in New York. 

#27 Write a query that lists investors based on the number of companies in which they are invested. 
Include a row for companies with no investor, and order from most companies to least.

SELECT CASE WHEN investments.investor_name IS NULL THEN 'No Investors'
            ELSE investments.investor_name END AS investor,
       COUNT(DISTINCT companies.permalink) AS companies_invested_in
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1
 ORDER BY 2 DESC

- this code displays investors categorized by how many companies they've invested in.. in descending order.

#28 Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 using a FULL JOIN. 
Count up the number of rows that are matched/unmatched as in the example above. 

    SELECT COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NULL
                      THEN companies.permalink ELSE NULL END) AS companies_only,
           COUNT(CASE WHEN companies.permalink IS NOT NULL AND investments.company_permalink IS NOT NULL
                      THEN companies.permalink ELSE NULL END) AS both_tables,
           COUNT(CASE WHEN companies.permalink IS NULL AND investments.company_permalink IS NOT NULL
                      THEN investments.company_permalink ELSE NULL END) AS investments_only
      FROM tutorial.crunchbase_companies companies
      FULL JOIN tutorial.crunchbase_investments_part1 investments
        ON companies.permalink = investments.company_permalink

- this code returns the unmatched rows from both tables.

#29 Write a query that appends the two crunchbase_investments datasets above (including duplicate values). 
Filter the first dataset to only companies with names that start with the letter "T", and 
filter the second to companies with names starting with "M" (both not case-sensitive). 
Only include the company_permalink, company_name, and investor_name columns.

SELECT company_permalink,
       company_name,
       investor_name
  FROM tutorial.crunchbase_investments_part1
 WHERE company_name ILIKE 'T%'
 
 UNION ALL

SELECT company_permalink,
       company_name,
       investor_name
  FROM tutorial.crunchbase_investments_part2
 WHERE company_name ILIKE 'M%'

- this code brings together two statements, one on top of the other. It displays the results of one statment in the
same table as the results of the other statement. 

#30 Write a query that shows 3 columns. The first indicates which dataset (part 1 or 2) the data comes from, 
the second shows company status, and the third is a count of the number of investors.

Hint: you will have to use the tutorial.crunchbase_companies table as well as the investments tables. 
And you'll want to group by status and dataset.

SELECT 'investments_part1' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part1 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

 UNION ALL
 
 SELECT 'investments_part2' AS dataset_name,
       companies.status,
       COUNT(DISTINCT investments.investor_permalink) AS investors
  FROM tutorial.crunchbase_companies companies
  LEFT JOIN tutorial.crunchbase_investments_part2 investments
    ON companies.permalink = investments.company_permalink
 GROUP BY 1,2

-
