import pandas as pd
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="hospital"
)

def load_table(parquet_path, table_name):
    df = pd.read_parquet(parquet_path)

    cursor = conn.cursor()

    cursor.execute(f"DROP TABLE IF EXISTS {table_name}")

    cols = []
    for col, dtype in zip(df.columns, df.dtypes):
        if "int" in str(dtype):
            cols.append(f"{col} INT")
        elif "float" in str(dtype):
            cols.append(f"{col} FLOAT")
        elif "bool" in str(dtype):
            cols.append(f"{col} BOOLEAN")
        else:
            cols.append(f"{col} VARCHAR(255)")

    cursor.execute(f"CREATE TABLE {table_name} ({', '.join(cols)})")

    placeholders = ", ".join(["%s"] * len(df.columns))
    insert_sql = f"INSERT INTO {table_name} VALUES ({placeholders})"

    for row in df.itertuples(index=False):
        cursor.execute(insert_sql, tuple(row))

    conn.commit()
    print(f"{table_name} carregada com sucesso!")


load_table("data/gold/dim_clinical.parquet", "dim_clinical")
load_table("data/gold/dim_discharge.parquet", "dim_discharge")
load_table("data/gold/dim_patient.parquet", "dim_patient")
load_table("data/gold/fact_readmission.parquet", "fact_readmission")

conn.close()

