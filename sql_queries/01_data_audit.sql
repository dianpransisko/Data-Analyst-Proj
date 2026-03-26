-- =================================================================================
-- E-Commerce Customer Segmentation (RFM Analysis)
-- SCRIPT: 01_Data_Audit.sql
-- DESCRIPTION: Melakukan audit awal pada data mentah (raw_online_retail)
-- =================================================================================

-- 1. Cek Total Baris Data
-- Mengetahui skala dataset yang sedang ditangani
SELECT COUNT(*) AS total_records FROM raw_online_retail;

-- 2. Identifikasi Nilai yang Hilang (Missing Values)
-- Fokus pada CustomerID karena krusial untuk analisis RFM
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN "CustomerID" IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN "Description" IS NULL THEN 1 ELSE 0 END) AS missing_description,
    SUM(CASE WHEN "Country" IS NULL THEN 1 ELSE 0 END) AS missing_country
FROM raw_online_retail;

-- 3. Audit Statistik Deskriptif (Outlier Detection)
-- Mencari nilai negatif pada Quantity (Retur) dan UnitPrice (Anomali)
SELECT 
    MIN("Quantity") AS min_qty, 
    MAX("Quantity") AS max_qty, 
    AVG("Quantity") AS avg_qty,
    MIN("UnitPrice") AS min_price, 
    MAX("UnitPrice") AS max_price,
    AVG("UnitPrice") AS avg_price
FROM raw_online_retail;

-- 4. Audit Rentang Waktu Transaksi
-- Memastikan data mencakup periode satu tahun penuh
SELECT 
    MIN("InvoiceDate") AS first_transaction, 
    MAX("InvoiceDate") AS last_transaction 
FROM raw_online_retail;

-- 5. Cek Distribusi Data Unik
-- Memahami variasi produk, pelanggan, dan jangkauan pasar
SELECT 
    COUNT(DISTINCT "CustomerID") AS unique_customers,
    COUNT(DISTINCT "StockCode") AS unique_products,
    COUNT(DISTINCT "InvoiceNo") AS unique_invoices,
    COUNT(DISTINCT "Country") AS unique_countries
FROM raw_online_retail;

-- 6. Identifikasi Transaksi Pembatalan (Cancelled Orders)
-- Transaksi yang diawali huruf 'C' pada InvoiceNo
SELECT COUNT(*) AS total_cancelled_orders
FROM raw_online_retail
WHERE "InvoiceNo" LIKE 'C%';

-- 7. Cek Baris Duplikat Identik
-- Menghitung potensi redudansi data sebelum pembersihan
SELECT COUNT(*) - COUNT(DISTINCT raw_online_retail.*) AS total_duplicate_rows
FROM raw_online_retail;