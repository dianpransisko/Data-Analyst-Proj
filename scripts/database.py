import os
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

# Load variabel dari .env
load_dotenv()

def get_engine():
    """Membuat dan mengembalikan engine koneksi SQLAlchemy."""
    user = os.getenv('DB_USER')
    password = os.getenv('DB_PASS')
    host = os.getenv('DB_HOST')
    port = os.getenv('DB_PORT')
    db = os.getenv('DB_NAME')
    
    # Validasi jika variabel .env belum terisi
    if not all([user, password, host, port, db]):
        raise ValueError("Kredensial database di file .env belum lengkap!")

    connection_string = f"postgresql://{user}:{password}@{host}:{port}/{db}"
    return create_engine(connection_string)

def execute_query(query_string, commit=False):
    """Fungsi pembantu untuk mengeksekusi query SQL mentah."""
    engine = get_engine()
    with engine.connect() as conn:
        result = conn.execute(text(query_string))
        if commit:
            conn.commit()
        return result