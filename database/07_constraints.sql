ALTER TABLE project.bq_text_classification OWNER TO postgres;


ALTER TABLE project.bq_type_silver OWNER TO postgres;


ALTER TABLE project.business_units_silver OWNER TO postgres;


ALTER TABLE project.main_silverold OWNER TO postgres;


ALTER TABLE project.main_silver OWNER TO postgres;


ALTER TABLE project.teams_silver OWNER TO postgres;


ALTER TABLE project.percentiles_silver OWNER TO postgres;


ALTER TABLE project.projects_silver OWNER TO postgres;


ALTER TABLE project.raw_bronze OWNER TO postgres;


ALTER TABLE project.region_silver OWNER TO postgres;


ALTER TABLE project.service_description_silver OWNER TO postgres;


ALTER TABLE project.sku_description_silver OWNER TO postgres;


ALTER TABLE public.main_silver_2_202510 OWNER TO postgres;


ALTER TABLE public.main_silver_2_202511 OWNER TO postgres;


ALTER TABLE public.main_silver_2_202512 OWNER TO postgres;


ALTER TABLE public.main_silver_2_202601 OWNER TO postgres;


ALTER TABLE ONLY project.main_silver ATTACH PARTITION public.main_silver_2_202510 FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');


ALTER TABLE ONLY project.main_silver ATTACH PARTITION public.main_silver_2_202511 FOR VALUES FROM ('2025-11-01') TO ('2025-12-01');


ALTER TABLE ONLY project.main_silver ATTACH PARTITION public.main_silver_2_202512 FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');


ALTER TABLE ONLY project.main_silver ATTACH PARTITION public.main_silver_2_202601 FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');


ALTER TABLE ONLY project.bq_text_classification ALTER COLUMN id_serial SET DEFAULT nextval('project.bq_text_classification_id_serial_seq'::regclass);


ALTER TABLE ONLY project.bq_type_silver ALTER COLUMN id_serial SET DEFAULT nextval('project.bq_type_silver_id_serial_seq'::regclass);


ALTER TABLE ONLY project.business_units_silver ALTER COLUMN id_serial SET DEFAULT nextval('project.business_units_silver_id_serial_seq'::regclass);


ALTER TABLE ONLY project.main_silverold ALTER COLUMN id_line SET DEFAULT nextval('project.main_silver_id_line_seq'::regclass);


ALTER TABLE ONLY project.projects_silver ALTER COLUMN id_serial SET DEFAULT nextval('project.projects_silver_id_serial_seq'::regclass);


ALTER TABLE ONLY project.raw_bronze ALTER COLUMN temp_id_line SET DEFAULT nextval('project.raw_bronze_temp_id_line_seq'::regclass);


ALTER TABLE ONLY project.region_silver ALTER COLUMN id_serial SET DEFAULT nextval('project.region_silver_id_serial_seq'::regclass);


ALTER TABLE ONLY project.service_description_silver ALTER COLUMN id_serial SET DEFAULT nextval('project.service_description_id_serial_seq'::regclass);


ALTER TABLE ONLY project.teams_silver ALTER COLUMN id_team SET DEFAULT nextval('project.teams_silver_id_serial_seq'::regclass);


ALTER TABLE ONLY project.bq_type_silver
    ADD CONSTRAINT bq_type_silver_pkey PRIMARY KEY (id_serial);


ALTER TABLE ONLY project.business_units_silver
    ADD CONSTRAINT business_units_silver_pkey PRIMARY KEY (id_serial);


ALTER TABLE ONLY project.main_silverold
    ADD CONSTRAINT main_silver_pkey PRIMARY KEY (id_line);


ALTER TABLE ONLY project.main_silver
    ADD CONSTRAINT pk_main_silver_2 PRIMARY KEY (invoice_month, id_line);


ALTER TABLE ONLY project.projects_silver
    ADD CONSTRAINT projects_silver_pkey PRIMARY KEY (id_serial);


ALTER TABLE ONLY project.raw_bronze
    ADD CONSTRAINT raw_bronze_pkey PRIMARY KEY (temp_id_line);


ALTER TABLE ONLY project.region_silver
    ADD CONSTRAINT region_silver_pkey PRIMARY KEY (id_serial);


ALTER TABLE ONLY project.service_description_silver
    ADD CONSTRAINT service_description_silver_pkey PRIMARY KEY (id_serial);


ALTER TABLE ONLY project.teams_silver
    ADD CONSTRAINT teams_silver_pkey PRIMARY KEY (id_team);


ALTER TABLE ONLY public.main_silver_2_202510
    ADD CONSTRAINT main_silver_2_202510_pkey PRIMARY KEY (invoice_month, id_line);


ALTER TABLE ONLY public.main_silver_2_202511
    ADD CONSTRAINT main_silver_2_202511_pkey PRIMARY KEY (invoice_month, id_line);


ALTER TABLE ONLY public.main_silver_2_202512
    ADD CONSTRAINT main_silver_2_202512_pkey PRIMARY KEY (invoice_month, id_line);


ALTER TABLE ONLY public.main_silver_2_202601
    ADD CONSTRAINT main_silver_2_202601_pkey PRIMARY KEY (invoice_month, id_line);
