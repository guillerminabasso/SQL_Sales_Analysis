-- Schema check
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name IN ('sales', 'customer');

-- Null check on key columns
SELECT COUNT(*) FROM sales 
WHERE orderdate IS NULL OR customerkey IS NULL;

-- Orphan key check
SELECT COUNT(*) 
FROM sales s
LEFT JOIN customer c ON s.customerkey = c.customerkey
WHERE c.customerkey IS NULL;