"""
Bulk-load 4 CSV files into SQL-Server.

pip install pandas sqlalchemy pyodbc
ODBC Driver 17 (or 18) for SQL-Server must be installed.

If a CSV has *extra* columns they are dropped.
If the SQL table has *extra* columns they are added back to the
DataFrame as NULLs – so the column set & order always match.
"""

import os, sys, textwrap
import pandas as pd
from urllib.parse import quote_plus
from sqlalchemy import create_engine, text, event

# ────────────────────────────────────────────
### CONFIG – EDIT ME ###
USER     = "cool_user"
PASSWORD = "cool_pass"
SERVER   = r"localhost"          # e.g. localhost  OR  localhost\\SQLEXPRESS
PORT     = 1433                  # TCP port of the instance
DATABASE = "global_development"
CSV_DIR  = r"..\dbt"             # folder that contains the CSV files
DRIVER   = "ODBC Driver 17 for SQL Server"
# ────────────────────────────────────────────

TABLES = {
    "countries"                              : "countries.csv",
    "gdi2"                                   : "gdi2.csv",
    "Global_Development_Indicators_2000_2020": "Global_Development_Indicators_2000_2020.csv",
    "world_tourism_economy_data"             : "world_tourism_economy_data.csv",
}

# optional header fixes → SQL column names
RENAMES = {
    "alpha-2"  : "alpha_2",
    "alpha-3"  : "alpha_3",
    "iso_3166-2": "iso_3166_2",
    "country-cc": "country_cc",
    "sub-region": "sub_region",
    "intermedia_region_cod": "intermediate_region_code",
    "sub-region-cod": "sub_region_code",
    "region-cod": "region_code",
    "intermedia region": "intermediate_region",
}

# ── build & test connection ─────────────────
odbc = (
    f"DRIVER={DRIVER};"
    f"SERVER={SERVER},{PORT};"
    f"DATABASE={DATABASE};"
    f"UID={USER};PWD={PASSWORD};"
    "TrustServerCertificate=yes;"
)
CONN_STR = f"mssql+pyodbc:///?odbc_connect={quote_plus(odbc)}"
print("Connecting with:", CONN_STR)

engine = create_engine(CONN_STR, fast_executemany=True)

@event.listens_for(engine, "before_cursor_execute")
def _set_fast_executemany(conn, cursor, stmt, params, ctx, executemany):
    cursor.fast_executemany = True

# test
with engine.connect() as c:
    print("✅ Connected to:", c.execute(text("SELECT @@VERSION")).scalar(), "\n")

# ── helper: get column list from SQL table ──
def sql_columns(table_name: str):
    sql = """
    SELECT name
    FROM   sys.columns
    WHERE  object_id = OBJECT_ID(:t)
    ORDER  BY column_id"""
    with engine.connect() as c:
        return [row[0] for row in c.execute(text(sql), {"t": f"dbo.{table_name}"})]

# ── main loop ───────────────────────────────
for tbl, csv_file in TABLES.items():
    path = os.path.join(CSV_DIR, csv_file)
    if not os.path.isfile(path):
        print(f"❌ {csv_file} not found in {CSV_DIR}")
        continue

    print(f"⏳ Reading {csv_file} …")
    df = pd.read_csv(path)

    # tidy headers
    df.columns = (
        df.columns.str.strip()
                  .str.replace(" ", "_")
                  .str.replace("-", "_")
    )
    df.rename(columns=RENAMES, inplace=True)

    # align with SQL schema
    target_cols = sql_columns(tbl)
    if not target_cols:
        print(f"⚠️  Table {tbl} not found, skipping")
        continue

    # add any missing columns (fill with NULLs)
    for col in target_cols:
        if col not in df.columns:
            df[col] = pd.NA

    # drop extra columns
    extra = [c for c in df.columns if c not in target_cols]
    if extra:
        print("   • dropping extra columns:", ", ".join(extra))
        df = df.drop(columns=extra)

    # reorder
    df = df[target_cols]

    print(f"⬆️  Uploading {tbl} ({len(df):,} rows) …")
    df.to_sql(tbl,
              con=engine,
              if_exists="replace",   # change to "append" if desired
              index=False,
              chunksize=10_000)      # big chunks + fast_executemany == fast

    print(f"✅ {tbl} done\n")

print("🏁 All tables loaded successfully.")
