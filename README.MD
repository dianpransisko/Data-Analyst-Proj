📊 E-Commerce Customer Segmentation (RFM Analysis)

![alt text](<Screenshot 2026-03-26 164343.png>)

## 📝 Project Overview
Proyek ini bertujuan untuk mentransformasi data transaksi mentah dari retail online non-toko berbasis di Inggris menjadi strategi pemasaran yang terukur. Dengan menggunakan metode RFM (Recency, Frequency, Monetary), proyek ini mengidentifikasi segmen pelanggan untuk mengoptimalkan anggaran pemasaran dan meningkatkan retensi pelanggan.


📌 Problem Statement
- Identifikasi Loyalitas: Manajemen kesulitan membedakan pelanggan setia dari pelanggan yang hanya berburu diskon.
- Optimasi Produk: Ketidakjelasan produk mana yang memberikan kontribusi pendapatan (proksi margin) terbesar.
- Pemborosan Anggaran: Strategi pemasaran bersifat "pukul rata" (general), menyebabkan rendahnya ROI dan tingginya angka churn pelanggan.

🛠️ Tools & Technologies
- Database: PostgreSQL (Data Cleaning & Audit)
- Programming: Python 3.x (Pandas, SQLAlchemy, Scipy)
- Visualization: Power BI (Interactive Dashboard)
- Environment: .env for secure database credentials

1. Data Cleaning & Audit (SQL)
Proses pembersihan dilakukan untuk memastikan metrik RFM tidak terdistorsi oleh data anomali.
- Data Awal: 406.829 baris.
- Data Bersih: 391.286 baris.
- Transformasi: Penghapusan CustomerID NULL, pembersihan Quantity & UnitPrice bernilai ≤ 0 (transaksi sampel/rusak), dan penanganan transaksi retur (Invoice berawalan 'C').

2. RFM Processing (Python)
Menghitung skor pelanggan berdasarkan perilaku transaksi terakhir (Dec 2010 - Dec 2011):
- Recency: Jumlah hari sejak transaksi terakhir pelanggan.
- Frequency: Jumlah unik InvoiceNo (transaksi) per pelanggan.
- Monetary: Total pendapatan yang dihasilkan per pelanggan.
- Segmentation: Pelanggan dibagi menjadi 6 segmen utama: Champions, Loyal, At Risk, Lost, New Customers, dan Others.

3. Business Intelligence (Power BI)
- Menghubungkan tabel transaksi (SQL) dengan hasil analisis RFM (Python) untuk menciptakan single source of truth.

📈 Key Insights & Business Findings
1. Customer Segmentation
The Power of Champions: Terdapat 1.136 pelanggan Champions (26%) yang mendominasi pendapatan. Mereka adalah prioritas utama untuk program eksklusif.
- Retention Alert: Terdeteksi 637 pelanggan At Risk. Tanpa intervensi, kelompok ini berisiko berpindah ke segmen Lost (1.068 pelanggan).
- Pareto Principle: Analisis menunjukkan bahwa minoritas pelanggan (Champions & Loyal) menyumbang mayoritas total pendapatan perusahaan.

2. Sales Performance
Top Profit Driver: Regency Cakestand 3 Tier merupakan produk fisik dengan performa pendapatan tertinggi (£165K).
- Operational Insight: Tingginya nilai Postage/Logistik (£206K) menyarankan perlunya negosiasi ulang kontrak vendor kurir untuk meningkatkan margin bersih.
- Seasonality: Penjualan mencapai puncak tertingginya pada bulan November, dipicu oleh persiapan musim liburan di Inggris.

🚀 Actionable Recommendations
- Targeted Marketing: Mengalihkan anggaran pemasaran dari promosi general ke program retensi khusus untuk 637 pelanggan At Risk.
- Loyalty Reward: Memberikan akses early-bird atau layanan prioritas bagi segmen Champions tanpa harus memberikan diskon besar guna menjaga margin.
- Win-Back Campaign: Mengirimkan survei kepuasan atau penawaran khusus kembali kepada segmen Lost untuk memahami penyebab churn.

📂 Project Structure

├── data/                   # Dataset (CSV) & RFM results
├── sql/                    # SQL Scripts (Audit, Cleaning, EDA)
├── scripts/
│   ├── database.py         # DB Connection Module
│   ├── upload_data.py      # Data Ingestion Script
│   └── rfm_analysis.py     # Main RFM Logic
├── dashboard/              # Power BI .pbix file
└── README.md               # Project documentation

Note: Karena keterbatasan data harga pokok penjualan (HPP/COGS), indikator "Margin" dalam analisis ini didekati melalui nilai "Revenue".