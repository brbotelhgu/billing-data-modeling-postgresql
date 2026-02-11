CREATE VIEW project.gold_accumulated_cost_per_day AS
 SELECT (usage_start_time)::date AS ref_date,
    sum(cost) OVER (PARTITION BY invoice_month ORDER BY usage_start_time) AS accumlated_cost_per_day
   FROM project.main_silver
  ORDER BY invoice_month, usage_start_time;


CREATE VIEW project.gold_most_expensive_months AS
 WITH cte AS (
         SELECT to_char((main_silver.invoice_month)::timestamp with time zone, 'YYYY-MM'::text) AS ref_month,
            sum(main_silver.cost) AS cost,
            sum(main_silver.usage_amount) AS usage_amount_gb
           FROM project.main_silver
          GROUP BY (to_char((main_silver.invoice_month)::timestamp with time zone, 'YYYY-MM'::text))
        )
 SELECT row_number() OVER (ORDER BY cost) AS rank,
    ref_month,
    cost,
    usage_amount_gb
   FROM cte;


CREATE VIEW project.gold_usageandcost_per_month AS
 SELECT m.invoice_month,
    t.team_name,
    sum(m.usage_amount) AS total_usage,
    m.usage_unit,
    round(sum(m.cost), 2) AS sum_cost,
    round((sum(m.cost) / NULLIF(sum(m.usage_amount), (0)::numeric)), 2) AS cost_per_usage_unit
   FROM (project.main_silver m
     LEFT JOIN project.teams_silver t ON ((m.team_id = t.id_team)))
  GROUP BY m.invoice_month, t.team_name, m.usage_unit
  ORDER BY t.team_name;
