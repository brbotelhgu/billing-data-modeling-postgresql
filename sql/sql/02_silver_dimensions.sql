
-- Silver Layer: Dimension Tables
-- Responsible for data standardization and surrogate key generation

DROP TABLE IF EXISTS project.teams_silver;

CREATE TABLE project.teams_silver AS
(SELECT DISTINCT
  COALESCE(INITCAP(NULLIF(TRIM(team_name), '')), 'UNKNOWN') AS team_name
FROM project.raw_bronze
WHERE team_name IS NOT NULL);

ALTER TABLE project.teams_silver
ADD COLUMN id_team SERIAL PRIMARY KEY,
ADD COLUMN acc_responsable TEXT,
ADD COLUMN senior_manager TEXT,
ADD COLUMN branch_country TEXT,
ADD COLUMN branch_state TEXT,
ADD COLUMN branch_qty_employees INT,
ADD COLUMN branch_budget NUMERIC(10,2),
ADD COLUMN tech_lead TEXT;

INSERT INTO project.teams_silver
(team_name, acc_responsable, senior_manager, branch_country, branch_state, branch_qty_employees, branch_budget, tech_lead)
VALUES
('UNKNOWN','UNKNOWN','UNKNOWN','UNKNOWN','UNKNOWN',0,0,'UNKNOWN'); 

--------------------------------------------------------------------

DROP TABLE IF EXISTS project.projects_silver;

CREATE TABLE project.projects_silver AS
(SELECT DISTINCT
  COALESCE(INITCAP(NULLIF(TRIM(project_id), '')), 'UNKNOWN') AS project_name
FROM project.raw_bronze);

ALTER TABLE project.projects_silver
ADD COLUMN id_serial SERIAL PRIMARY KEY,
ADD COLUMN tech_responsable TEXT;

INSERT INTO project.projects_silver (project_name, tech_responsable)
VALUES ('UNKNOWN', 'UNKNOWN');

--------------------------------------------------------------------

DROP TABLE IF EXISTS project.business_units_silver;

CREATE TABLE project.business_units_silver AS
(SELECT DISTINCT
  COALESCE(INITCAP(NULLIF(TRIM(business_unit), '')), 'UNKNOWN') AS business_unit
FROM project.raw_bronze);

ALTER TABLE project.business_units_silver
ADD COLUMN id_serial SERIAL PRIMARY KEY,
ADD COLUMN country TEXT,
ADD COLUMN state TEXT,
ADD COLUMN city TEXT;

INSERT INTO project.business_units_silver (business_unit, country, state, city)
VALUES ('UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN');

--------------------------------------------------------------------

DROP TABLE IF EXISTS project.service_description_silver;

CREATE TABLE project.service_description_silver AS
(SELECT DISTINCT
  COALESCE(INITCAP(NULLIF(TRIM(service_description), '')), 'UNKNOWN') AS service
FROM project.raw_bronze);

ALTER TABLE project.service_description_silver
ADD COLUMN id_serial SERIAL PRIMARY KEY,
ADD COLUMN service_description TEXT;

INSERT INTO project.service_description_silver (service, service_description)
VALUES ('UNKNOWN', 'UNKNOWN');

--------------------------------------------------------------------

DROP TABLE IF EXISTS project.sku_description_silver;

CREATE TABLE project.sku_description_silver AS
(SELECT DISTINCT
  COALESCE(INITCAP(NULLIF(TRIM(sku_description), '')), 'UNKNOWN') AS sku_description
FROM project.raw_bronze);

ALTER TABLE project.sku_description_silver
ADD COLUMN id_serial SERIAL PRIMARY KEY,
ADD COLUMN service_description TEXT;

INSERT INTO project.sku_description_silver (sku_description, service_description)
VALUES ('UNKNOWN', 'UNKNOWN');

--------------------------------------------------------------------

DROP TABLE IF EXISTS project.region_silver;

CREATE TABLE project.region_silver AS
(SELECT DISTINCT
  COALESCE(INITCAP(NULLIF(TRIM(region), '')), 'UNKNOWN') AS region
FROM project.raw_bronze);

ALTER TABLE project.region_silver
ADD COLUMN id_serial SERIAL PRIMARY KEY;

INSERT INTO project.region_silver (region)
VALUES ('UNKNOWN');

--------------------------------------------------------------------


DROP TABLE IF EXISTS project.bq_type_silver;

CREATE TABLE project.bq_type_silver AS
(SELECT DISTINCT
  COALESCE(INITCAP(NULLIF(TRIM(bq_query_type), '')), 'UNKNOWN') AS bq_query_type
FROM project.raw_bronze);

ALTER TABLE project.bq_type_silver
ADD COLUMN id_serial SERIAL PRIMARY KEY,
ADD COLUMN service TEXT;

INSERT INTO project.bq_type_silver (bq_query_type, service)
VALUES ('UNKNOWN', 'UNKNOWN');

--------------------------------------------------------------------

DROP TABLE IF EXISTS project.bq_text_classification;

CREATE TABLE project.bq_text_classification AS
SELECT DISTINCT
  CASE
    WHEN bq_query_text ~* 'INSERT|MERGE' THEN 'INSERT'
    WHEN bq_query_text ~* 'SELECT\\s+\\*' THEN 'SELECT_SCAN'
    WHEN bq_query_text ~* 'JOIN.*?JOIN' THEN 'MULTI_JOIN'
    WHEN bq_query_text ~* 'GROUP\\s+BY|ORDER\\s+BY' THEN 'AGGREGATION'
    ELSE 'OTHERS'
  END AS query_type
FROM project.raw_bronze;

ALTER TABLE project.bq_text_classification
ADD COLUMN id_serial SERIAL PRIMARY KEY;

INSERT INTO project.bq_text_classification (query_type)
VALUES ('AGGREGATION');
