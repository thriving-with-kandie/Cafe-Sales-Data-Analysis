
-- Cafe Sales Data Cleaning Project

-- 1. Handling Missing Items
UPDATE cafe_sales
SET Item = 'Unknown'
WHERE Item IS NULL OR Item = '';

-- 2. Fixing Total Spent
UPDATE cafe_sales
SET Total_Spent = 0
WHERE Total_Spent IS NULL OR Total_Spent = '' OR Total_Spent = 'N/A';

-- 3. Standardizing Payment Method
UPDATE cafe_sales
SET Payment_Method = 'Unknown'
WHERE Payment_Method IS NULL OR Payment_Method = '' OR Payment_Method = 'Error';

UPDATE cafe_sales
SET Payment_Method = 'Cash'
WHERE Payment_Method LIKE '%cash%';

UPDATE cafe_sales
SET Payment_Method = 'Visa'
WHERE Payment_Method LIKE '%visa%';

UPDATE cafe_sales
SET Payment_Method = 'Mastercard'
WHERE Payment_Method LIKE '%master%';

-- 4. Standardizing Locations
UPDATE cafe_sales
SET Location = 'Unknown'
WHERE Location IS NULL OR Location = '';

-- 5. Fixing Transaction Date
UPDATE cafe_sales
SET Transaction_Date = 'Unknown'
WHERE Transaction_Date IS NULL OR Transaction_Date = '' OR Transaction_Date = 'Error';

-- 6. Removing Duplicates
DELETE FROM cafe_sales
WHERE Transaction_ID IN (
    SELECT Transaction_ID
    FROM (
        SELECT Transaction_ID, ROW_NUMBER() OVER(PARTITION BY Transaction_ID ORDER BY Transaction_ID) AS row_num
        FROM cafe_sales
    ) AS temp_table
    WHERE row_num > 1
);
