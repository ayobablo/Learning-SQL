-- Data Cleaning

-- Total Records = 541909
-- 135080 records have no customerID
-- 406829 records have customerID

;WITH Online_Retail AS
(
	SELECT [InvoiceNo]
		  ,[StockCode]
		  ,[Description]
		  ,[Quantity]
		  ,[InvoiceDate]
		  ,[UnitPrice]
		  ,[CustomerID]
		  ,[Country]
	  FROM [Advanced_Practice].[dbo].[Online_Retail]
	  WHERE CustomerID != 0
)
, quantity_unit_price AS
(
	-- 397882 records with quantity and unit price greater than 0
	SELECT *
	FROM Online_Retail
	WHERE Quantity > 0 and UnitPrice > 0
)
, dup_check AS
(
	-- check for duplicate
	SELECT *, ROW_NUMBER() OVER (PARTITION BY InvoiceNo, StockCode, Quantity ORDER BY InvoiceDate) duplicate_flag
	FROM quantity_unit_price
)
-- 5215 duplicate records
-- 392,667 clean data

SELECT * 
INTO #online_retail_new
FROM dup_check
WHERE duplicate_flag = 1

-- begin cohort analysis
SELECT * 
FROM #online_retail_new;

-- unique identifier (customer ID)
-- initial start date (invoice date)
-- revenue data

SELECT CustomerID, min(InvoiceDate) first_purchase_date,
	DATEFROMPARTS(year(min(InvoiceDate)), month(min(InvoiceDate)), 1) Cohort_Date
INTO #cohort_table
FROM #online_retail_new
GROUP BY CustomerID

SELECT *
FROM #cohort_table;

-- create cohort index
SELECT tab2.*,
	cohort_index = year_diff * 12 + month_diff + 1
INTO #cohort_retentionTable
FROM (
	SELECT tab1.*,
		year_diff = invoice_year - cohort_year,
		month_diff = invoice_month - cohort_month
	FROM (
		SELECT m.*, 
			c.Cohort_Date, 
			year(m.InvoiceDate) invoice_year, 
			month(m.InvoiceDate) invoice_month,
			-- datename(month, m.InvoiceDate) invoice_month, 
			year(c.Cohort_Date) cohort_year,
			month(c.Cohort_Date) cohort_month
			-- datename(month, c.Cohort_Date) cohort_month
		FROM #online_retail_new m
		LEFT JOIN #cohort_table c
		ON m.CustomerID = c.CustomerID
	) tab1
) tab2

-- pivot data to see the cohort table
SELECT *
INTO #Cohort_pivot
FROM (
	SELECT DISTINCT CustomerID, Cohort_Date, cohort_index
	FROM #cohort_retentionTable
	-- ORDER BY 1,3
) tab3
pivot (
	Count(CustomerID) 
	for Cohort_Index In 
		([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13]) 
) as pivot_table

-- check for index number
--SELECT DISTINCT cohort_index
--FROM #cohort_retentionTable
--ORDER BY 1

SELECT *
FROM #Cohort_pivot
ORDER BY Cohort_Date

SELECT Cohort_Date,
	1.0 * [1]/[1] * 100 as [1],
	1.0 * [2]/[1] * 100 as [2],
	1.0 * [3]/[1] * 100 as [3],
	1.0 * [4]/[1] * 100 as [4],
	1.0 * [5]/[1] * 100 as [5],
	1.0 * [6]/[1] * 100 as [6],
	1.0 * [7]/[1] * 100 as [7],
	1.0 * [8]/[1] * 100 as [8],
	1.0 * [9]/[1] * 100 as [9],
	1.0 * [10]/[1] * 100 as [10],
	1.0 * [11]/[1] * 100 as [11],
	1.0 * [12]/[1] * 100 as [12],
	1.0 * [13]/[1] * 100 as [13]
FROM #Cohort_pivot
ORDER BY Cohort_Date


