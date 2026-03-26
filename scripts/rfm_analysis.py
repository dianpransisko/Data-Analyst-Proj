import pandas as pd
import datetime as dt
import os
from database import get_engine  # Mengambil koneksi dari file database.py

def run_rfm_analysis():
    try:
        # 1. Inisialisasi Koneksi
        engine = get_engine()
        
        # 2. Ambil Data Bersih (Silver Layer)
        print("--- Menarik data dari tabel cleaned_online_retail ---")
        query = "SELECT * FROM cleaned_online_retail"
        df = pd.read_sql(query, engine)
        
        # Pastikan tipe data tanggal benar
        df['InvoiceDate'] = pd.to_datetime(df['InvoiceDate'])
        
        print(f"Berhasil memuat {len(df)} baris data.")

        # 3. Hitung Metrik RFM
        print("--- Menghitung Recency, Frequency, & Monetary ---")
        # Tanggal patokan: 1 hari setelah transaksi terakhir di dataset
        snapshot_date = df['InvoiceDate'].max() + dt.timedelta(days=1)
        
        rfm = df.groupby('CustomerID').agg({
            'InvoiceDate': lambda x: (snapshot_date - x.max()).days, # Recency
            'InvoiceNo': 'nunique',                                  # Frequency
            'Revenue': 'sum'                                        # Monetary
        })
        
        # Ganti nama kolom agar jelas
        rfm.columns = ['Recency', 'Frequency', 'Monetary']

        # 4. Scoring (Bagi menjadi 5 kelompok/kuantil)
        print("--- Melakukan Scoring (1-5) ---")
        # R_score: Semakin kecil hari (baru belanja), semakin tinggi skornya (5)
        rfm['R_score'] = pd.qcut(rfm['Recency'], 5, labels=[5, 4, 3, 2, 1])
        
        # F & M_score: Semakin tinggi nilai, semakin tinggi skornya (5)
        # Menggunakan rank(method='first') untuk menangani nilai yang sama
        rfm['F_score'] = pd.qcut(rfm['Frequency'].rank(method='first'), 5, labels=[1, 2, 3, 4, 5])
        rfm['M_score'] = pd.qcut(rfm['Monetary'], 5, labels=[1, 2, 3, 4, 5])

        # 5. Segmentasi Pelanggan
        print("--- Mengelompokkan Segmen Pelanggan ---")
        def create_segments(df):
            r = int(df['R_score'])
            f = int(df['F_score'])
            
            if r >= 4 and f >= 4:
                return 'Champions'
            elif r >= 3 and f >= 3:
                return 'Loyal Customers'
            elif r >= 4 and f <= 2:
                return 'New Customers'
            elif r <= 2 and f >= 3:
                return 'At Risk'
            elif r <= 2 and f <= 2:
                return 'Lost'
            else:
                return 'Others'

        rfm['Segment'] = rfm.apply(create_segments, axis=1)

        # 6. Output: Simpan ke CSV & Kirim balik ke SQL
        print("--- Menyimpan Hasil Analisis ---")
        
        # A. Simpan ke CSV untuk backup/Power BI offline
        if not os.path.exists('data'):
            os.makedirs('data')
        rfm.to_csv('data/rfm_result.csv', sep=';')
        
        # B. Kirim balik ke SQL agar bisa ditarik langsung oleh Power BI
        rfm.to_sql('rfm_analysis_results', engine, if_exists='replace')
        
        print("\nSUKSES! Analisis RFM selesai.")
        print("Distribusi Segmen:")
        print(rfm['Segment'].value_counts())

    except Exception as e:
        print(f"Terjadi kesalahan: {e}")

if __name__ == "__main__":
    run_rfm_analysis()