-- =================================================================================
-- E-Commerce Customer Segmentation (RFM Analysis)
-- SCRIPT: 03_EDA_Analysis.sql
-- DESCRIPTION: Exploratory Data Analysis untuk mendapatkan Business Insights
-- =================================================================================

-- 1. Analisis Tren Pendapatan Bulanan (Monthly Revenue)
-- Tujuan: Mengidentifikasi pola musiman (Seasonality)
SELECT 
    DATE_TRUNC('month', "InvoiceDate") AS Month,
    SUM("Revenue") AS Total_Revenue,
    COUNT(DISTINCT "InvoiceNo") AS Total_Transactions,
    COUNT(DISTINCT "CustomerID") AS Active_Customers
FROM cleaned_online_retail
GROUP BY 1
ORDER BY 1;

-- 2. Analisis Geografis: Top 5 Negara Berdasarkan Revenue (Excluding UK)
-- Tujuan: Melihat potensi pasar internasional selain pasar domestik
SELECT 
    "Country", 
    SUM("Revenue") AS Total_Revenue,
    COUNT(DISTINCT "CustomerID") AS Total_Customers,
    ROUND(SUM("Revenue") / COUNT(DISTINCT "CustomerID"), 2) AS Average_Spend_Per_Customer
FROM cleaned_online_retail
WHERE "Country" != 'United Kingdom'
GROUP BY 1
ORDER BY Total_Revenue DESC
LIMIT 5;

-- 3. Analisis Produk: Top 10 Produk Terlaris Berdasarkan Kuantitas
-- Tujuan: Mengetahui produk "Hero" yang paling diminati pasar
SELECT 
    "Description", 
    SUM("Quantity") AS Total_Quantity_Sold,
    COUNT(DISTINCT "InvoiceNo") AS Transaction_Count
FROM cleaned_online_retail
GROUP BY 1
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

-- 4. Analisis Perilaku Pelanggan: Average Order Value (AOV) per Bulan
-- Tujuan: Melihat apakah rata-rata nilai belanja per transaksi meningkat
SELECT 
    DATE_TRUNC('month', "InvoiceDate") AS Month,
    ROUND(SUM("Revenue") / COUNT(DISTINCT "InvoiceNo"), 2) AS Average_Order_Value
FROM cleaned_online_retail
GROUP BY 1
ORDER BY 1;

-- 5. Analisis Waktu: Penjualan Berdasarkan Jam (Hourly Sales)
-- Tujuan: Mengetahui jam operasional tersibuk untuk optimasi server/layanan pelanggan
SELECT 
    EXTRACT(HOUR FROM "InvoiceDate") AS Hour_Of_Day,
    COUNT("InvoiceNo") AS Total_Transactions,
    SUM("Revenue") AS Total_Revenue
FROM cleaned_online_retail
GROUP BY 1
ORDER BY 1;