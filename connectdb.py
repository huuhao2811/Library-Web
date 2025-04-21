import pyodbc

conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=172.21.192.1,1433;"
    "DATABASE=Assignment_DatabaseSystem;"
    "UID=dh;"
    "PWD=123456;"
    "TrustServerCertificate=yes;"
    "Encrypt=no;"
)

try:
    conn = pyodbc.connect(conn_str, timeout=5)
    print("✅ Kết nối thành công!")
    conn.close()
except Exception as e:
    print("❌ Lỗi kết nối:", e)