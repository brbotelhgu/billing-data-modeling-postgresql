CREATE TABLE project.bq_type_silver (
    bq_query_type text,
    id_serial integer NOT NULL
);


CREATE TABLE project.business_units_silver (
    business_unit text,
    id_serial integer NOT NULL,
    country text,
    state text,
    city text
);


CREATE TABLE project.main_silverold (
    billing_account_id text,
    invoice_month date,
    usage_start_time timestamp without time zone,
    usage_end_time timestamp without time zone,
    project_id integer,
    project_name text,
    business_unit_id integer,
    team_id integer,
    service_id integer,
    sku_id integer,
    region_id integer,
    usage_amount numeric(15,3),
    usage_unit text,
    cost numeric(10,4),
    currency text,
    is_bigquery boolean,
    bq_type_id integer,
    bq_query_text_id integer,
    id_line integer CONSTRAINT main_silver_id_line_not_null NOT NULL
);


CREATE TABLE project.main_silver (
    billing_account_id text,
    invoice_month date CONSTRAINT main_silver_2_invoice_month_not_null NOT NULL,
    usage_start_time timestamp without time zone,
    usage_end_time timestamp without time zone,
    project_id integer,
    project_name text,
    business_unit_id integer,
    team_id integer,
    service_id integer,
    sku_id integer,
    region_id integer,
    usage_amount numeric(15,3),
    usage_unit text,
    cost numeric(10,4),
    currency text,
    is_bigquery boolean,
    bq_type_id integer,
    bq_query_text_id integer,
    id_line integer DEFAULT nextval('project.main_silver_id_line_seq'::regclass) NOT NULL
)
PARTITION BY RANGE (invoice_month);


CREATE TABLE project.teams_silver (
    team_name text,
    id_team integer CONSTRAINT teams_silver_id_serial_not_null NOT NULL,
    acc_responsable text,
    senior_manager text,
    branch_country text,
    branch_state text,
    branch_qty_employess integer,
    branch_budget numeric(10,2),
    tech_lead text
);


CREATE TABLE project.percentiles_silver (
    query_type text,
    p50_gb bigint,
    p50_tb numeric,
    p75_gb bigint,
    p75_tb numeric,
    p90_gb bigint,
    p90_tb numeric
);


CREATE TABLE project.projects_silver (
    project_name text,
    id_serial integer NOT NULL,
    tech_responsable text
);


CREATE TABLE project.region_silver (
    region text,
    id_serial integer NOT NULL
);


CREATE TABLE project.service_description_silver (
    service text,
    service_description text,
    id_serial integer CONSTRAINT service_description_id_serial_not_null NOT NULL
);


CREATE TABLE project.sku_description_silver (
    sku_description text
);


CREATE TABLE public.main_silver_2_202510 (
    billing_account_id text,
    invoice_month date CONSTRAINT main_silver_2_invoice_month_not_null NOT NULL,
    usage_start_time timestamp without time zone,
    usage_end_time timestamp without time zone,
    project_id integer,
    project_name text,
    business_unit_id integer,
    team_id integer,
    service_id integer,
    sku_id integer,
    region_id integer,
    usage_amount numeric(15,3),
    usage_unit text,
    cost numeric(10,4),
    currency text,
    is_bigquery boolean,
    bq_type_id integer,
    bq_query_text_id integer,
    id_line integer DEFAULT nextval('project.main_silver_id_line_seq'::regclass) CONSTRAINT main_silver_id_line_not_null NOT NULL
);


CREATE TABLE public.main_silver_2_202511 (
    billing_account_id text,
    invoice_month date CONSTRAINT main_silver_2_invoice_month_not_null NOT NULL,
    usage_start_time timestamp without time zone,
    usage_end_time timestamp without time zone,
    project_id integer,
    project_name text,
    business_unit_id integer,
    team_id integer,
    service_id integer,
    sku_id integer,
    region_id integer,
    usage_amount numeric(15,3),
    usage_unit text,
    cost numeric(10,4),
    currency text,
    is_bigquery boolean,
    bq_type_id integer,
    bq_query_text_id integer,
    id_line integer DEFAULT nextval('project.main_silver_id_line_seq'::regclass) CONSTRAINT main_silver_id_line_not_null NOT NULL
);


CREATE TABLE public.main_silver_2_202512 (
    billing_account_id text,
    invoice_month date CONSTRAINT main_silver_2_invoice_month_not_null NOT NULL,
    usage_start_time timestamp without time zone,
    usage_end_time timestamp without time zone,
    project_id integer,
    project_name text,
    business_unit_id integer,
    team_id integer,
    service_id integer,
    sku_id integer,
    region_id integer,
    usage_amount numeric(15,3),
    usage_unit text,
    cost numeric(10,4),
    currency text,
    is_bigquery boolean,
    bq_type_id integer,
    bq_query_text_id integer,
    id_line integer DEFAULT nextval('project.main_silver_id_line_seq'::regclass) CONSTRAINT main_silver_id_line_not_null NOT NULL
);


CREATE TABLE public.main_silver_2_202601 (
    billing_account_id text,
    invoice_month date CONSTRAINT main_silver_2_invoice_month_not_null NOT NULL,
    usage_start_time timestamp without time zone,
    usage_end_time timestamp without time zone,
    project_id integer,
    project_name text,
    business_unit_id integer,
    team_id integer,
    service_id integer,
    sku_id integer,
    region_id integer,
    usage_amount numeric(15,3),
    usage_unit text,
    cost numeric(10,4),
    currency text,
    is_bigquery boolean,
    bq_type_id integer,
    bq_query_text_id integer,
    id_line integer DEFAULT nextval('project.main_silver_id_line_seq'::regclass) CONSTRAINT main_silver_id_line_not_null NOT NULL
);
