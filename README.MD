# 📊 E-Commerce Customer Segmentation (RFM Analysis)

Proyek ini bertujuan untuk mentransformasi data transaksi mentah dari retail online non-toko berbasis di Inggris menjadi strategi pemasaran yang terukur dengan metode **RFM (Recency, Frequency, Monetary)**.
---
<image src="https://github.com/dianpransisko/Data-Analyst-Proj/blob/main/bi.png" >

### 🚀 Problem Statement
* **Identifikasi Loyalitas:** Manajemen kesulitan membedakan pelanggan setia dari pelanggan pasif.
* **Optimasi Produk:** Ketidakjelasan produk yang memberikan kontribusi pendapatan terbesar.
* **Efisiensi Anggaran:** Strategi pemasaran "pukul rata" (general) mengakibatkan pemborosan budget.

---

### 🛠️ Tools & Technologies
* **Database:** PostgreSQL (Data Cleaning & Audit)
* **Programming:** Python 3.x (Pandas, SQLAlchemy, Scipy)
* **Visualization:** Power BI (Interactive Dashboard)
* **Environment:** `.env` for secure database credentials

---

### 📋 Data Pipeline Workflow

1. **Data Cleaning & Audit (SQL)**
   * **Data Awal:** 406.829 baris.
   * **Data Bersih:** 391.286 baris.
   * **Transformasi:** Penghapusan CustomerID NULL, pembersihan Quantity & UnitPrice ≤ 0, dan penanganan retur.

2. **RFM Processing (Python)**
   * **Recency:** Hari sejak transaksi terakhir.
   * **Frequency:** Jumlah transaksi unik per pelanggan.
   * **Monetary:** Total nilai belanja per pelanggan.
   * **Segments:** Champions, Loyal, At Risk, Lost, New Customers, Others.

3. **Business Intelligence (Power BI)**
   * Menghubungkan tabel SQL dan hasil Python untuk visualisasi interaktif.

---

### 💡 Key Insights & Findings

* **The Power of Champions:** **1.136 pelanggan (26%)** mendominasi pendapatan. Mereka adalah prioritas utama program loyalitas.
* **Retention Alert:** Terdeteksi **637 pelanggan At Risk**. Intervensi segera diperlukan sebelum mereka menjadi segmen **Lost (1.068 pelanggan)**.
* **Top Profit Driver:** **Regency Cakestand 3 Tier** adalah produk fisik dengan pendapatan tertinggi (£165K).
* **Seasonality:** Penjualan memuncak drastis pada bulan **November** (Holiday Season).

---

### 🎯 Actionable Recommendations
* **Targeted Marketing:** Fokuskan budget retensi khusus untuk 637 pelanggan *At Risk*.
* **VIP Program:** Berikan akses eksklusif untuk segmen *Champions* guna menjaga margin tanpa diskon berlebih.
* **Win-Back Campaign:** Lakukan re-aktivasi pada segmen *Lost* melalui survei atau penawaran khusus.

---

### 📂 Project Structure
```text
├── data/                   # Dataset & RFM results
├── sql/                    # Scripts (Audit, Cleaning, EDA)
├── scripts/
│   ├── database.py         # DB Connection Module
│   ├── upload_data.py      # Data Ingestion
│   └── rfm_analysis.py     # RFM Logic
├── dashboard/              # Power BI (.pbix) file
└── README.md               # Project documentation

### 
---Note: Karena keterbatasan data harga pokok penjualan (HPP/COGS), indikator "Margin" didekati melalui nilai "Revenue".
