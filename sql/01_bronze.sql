CREATE TABLE project.raw_bronze (
    billing_account_id TEXT,
    invoice_month DATE,
    usage_start_time TIMESTAMP,
    usage_end_time TIMESTAMP,
    project_id TEXT,
    project_name TEXT,
    business_unit TEXT,
    team_name TEXT,
    service_description TEXT,
    sku_description TEXT,
    region TEXT,
    usage_amount NUMERIC(15,3),
    usage_unit TEXT,
    cost NUMERIC(10,4),
    currency TEXT,
    is_bigquery BOOLEAN,
    bq_query_type TEXT,
    bq_bad_bytes NUMERIC(15,3),
    bq_query_text TEXT
);

--Also, we need to load the .csv avaliable in readme.md
