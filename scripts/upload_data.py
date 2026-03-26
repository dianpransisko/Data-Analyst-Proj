import pandas as pd
from database import get_engine, execute_query # Import dari file database.py

def upload_to_postgres():
    try:
        # 1. Gunakan fungsi dari database.py untuk hapus tabel lama
        print("--- Membersihkan dependensi tabel lama ---")
        execute_query("DROP TABLE IF EXISTS raw_online_retail CASCADE", commit=True)

        # 2. Baca file Excel
        print("--- Membaca file Excel ---")
        df = pd.read_excel('data/Online Retail.xlsx')
        
        # 3. Ambil engine dan upload
        engine = get_engine()
        print(f"--- Mengunggah {len(df)} baris ke PostgreSQL ---")
        df.to_sql('raw_online_retail', engine, if_exists='replace', index=False, chunksize=10000)
        
        print("--- BERHASIL! ---")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    upload_to_postgres()