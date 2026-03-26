-- =================================================================================
-- E-Commerce Customer Segmentation (RFM Analysis)
-- SCRIPT: 02_Data_Cleaning.sql
-- DESCRIPTION: Transformasi data mentah menjadi data bersih siap analisis (RFM)
-- =================================================================================

-- 1. Menghapus tabel jika sudah ada (untuk keperluan re-run script)
DROP TABLE IF EXISTS cleaned_online_retail;

-- 2. Membuat tabel baru 'cleaned_online_retail'
-- Menggunakan SELECT DISTINCT untuk menangani Deduplication secara otomatis
CREATE TABLE cleaned_online_retail AS
SELECT DISTINCT
    "InvoiceNo",
    "StockCode",
    UPPER(TRIM("Description")) AS "Description", -- Standardisasi: Menghapus spasi & Case Consistency
    "Quantity",
    CAST("InvoiceDate" AS TIMESTAMP) AS "InvoiceDate", -- Transformasi Tipe Data
    "UnitPrice",
    "CustomerID",
    "Country",
    ("Quantity" * "UnitPrice") AS "Revenue" -- Feature Engineering: Menambah kolom Revenue
FROM raw_online_retail
WHERE 
    -- Langkah A: Handling Missing Values
    "CustomerID" IS NOT NULL 
    
    -- Langkah B: Filtering Cancelled Orders & Anomalies
    -- Menghapus Invoice yang diawali 'C' dan Quantity/Price yang tidak valid (<= 0)
    AND "InvoiceNo" NOT LIKE 'C%'
    AND "Quantity" > 0 
    AND "UnitPrice" > 0
    
    -- Langkah C: Pembersihan Non-Produk
    -- Menghapus StockCode operasional yang bukan transaksi retail barang
    AND "StockCode" NOT IN ('POST', 'D', 'DOT', 'M', 'BANK CHARGES', 'AMAZONFEE', 'S');

-- 3. Verifikasi Hasil Akhir Pembersihan
-- Seharusnya menghasilkan angka sekitar 391.286 baris
SELECT 
    COUNT(*) AS total_clean_rows,
    MIN("Quantity") AS check_min_qty,
    MIN("UnitPrice") AS check_min_price,
    COUNT(DISTINCT "CustomerID") AS total_unique_customers
FROM cleaned_online_retail;

-- 4. Menambahkan Primary Key (Opsional - Untuk optimasi database)
-- Karena tidak ada kolom tunggal yang unik, kita bisa membuat ID serial jika diperlukan
-- ALTER TABLE cleaned_online_retail ADD COLUMN transaction_id SERIAL PRIMARY KEY;