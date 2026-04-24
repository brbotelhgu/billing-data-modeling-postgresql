# 📊 GCP FinOps Data Warehouse

Projeto prático de **Engenharia de Dados** focado em análise de custos cloud (FinOps), utilizando  o SGBD **PostgreSQL** e com a simulação de um **Data Warehouse** com arquitetura **Medallion**.

---

## 🚀 Sobre o Projeto

Este projeto segue uma abordagem ELT com foco em SQL, priorizando a modelagem de dados, a qualidade dos dados e as transformações analíticas.
Todos os dados representam uma conta de faturamento fictícia do GCP, criada exclusivamente para fins de aprendizado.

## 📌 Objetivos

-Simular a análise de custos em nuvem sob a perspectiva de FinOps

-Aplicar a arquitetura Medallion como um padrão lógico de organização de dados

-Praticar a modelagem dimensional e tabelas de fatos particionadas

-Identificar valores atípicos de uso e padrões de custo

-Criar visualizações SQL analíticas para geração de relatórios e análises

---

## 🏗️ Arquitetura Medallion

Este projeto utiliza a arquitetura de medalhão como um padrão conceitual, não como um pipeline orquestrado.

| Camada | Objetivo |
|--------|----------|
| Bronze | dados de faturamento brutos e imutáveis ​​para rastreabilidade |
| Silver | limpeza, padronização, classificação e modelagem |
| Gold | visões analíticas e orientadas para negócios |


---
## 🗂️ Camadas

---

### 🥉 Bronze Layer — Dados Brutos

Armazena registros de faturamento brutos com transformação mínima.

- Sem junções ou agregações  
- Preserva a estrutura e valores originais  
- Serve como fonte de verdade para auditoria e reprocessamento  

**Tabela principal:** `project.raw_bronze`

#### 📋 Estrutura da Tabela

| Column | Type | Description |
|--------|------|-------------|
| billing_account_id | TEXT | GCP billing account ID |
| invoice_month | DATE | Billing period (month) |
| usage_start_time | TIMESTAMP | Usage/query start time |
| usage_end_time | TIMESTAMP | Usage/query end time |
| project_id | TEXT | GCP project ID |
| project_name | TEXT | Project display name |
| business_unit | TEXT | Business unit/division |
| team_name | TEXT | Owning team name |
| service_description | TEXT | GCP service |
| sku_description | TEXT | SKU details |
| region | TEXT | GCP region |
| usage_amount | NUMERIC(15,3) | Usage quantity |
| usage_unit | TEXT | Unit type |
| cost | NUMERIC(10,4) | Cost amount |
| currency | TEXT | Currency |
| is_bigquery | BOOLEAN | BigQuery service flag |
| bq_query_type | TEXT | BigQuery query type |
| bq_bad_bytes | NUMERIC(15,3) | Bad bytes processed |
| bq_query_text | TEXT | SQL query text |
| temp_id_line | SERIAL | Temporary line identifier |

**Volume amostral:** ~10k linhas em 4 meses (2025-10 a 2026-01)

---

### 🥈 Silver Layer — Limpeza e Modelagem

Camada responsável pela lógica central do processo **ELT**.

#### 🔧 Operações Principais

- Normalização de texto com `TRIM`, `INITCAP`, `COALESCE`
- Classificação baseada em regras com `REGEXP`
- Criação de 8 tabelas dimensão
- Tabela fato particionada: `main_silver`
- Cálculo de percentis de uso (`P50` / `P90`)
- Enriquecimento e padronização de dados

#### 🧠 Classificação de Queries BigQuery

O texto SQL é categorizado via expressões regulares:

| Padrão | Significado |
|--------|-------------|
| `INSERT\|MERGE` | Operações de gravação |
| `SELECT \s+\*` | Full table scan |
| `JOIN.*?JOIN` | Múltiplas junções |
| `GROUP BY\|ORDER BY` | Agregações |

#### 📦 Tabela Fato

**Tabela:** `main_silver`

- Particionada por `invoice_month`
- Otimizada para análises
- Suporte a Window Functions

---

### 🥇 Gold Layer — Visualizações Analíticas

Camada final com visões somente leitura para BI e análises ad-hoc.

#### 📊 Exemplos de Entregas

- Uso e custo mensal por equipe  
- Acumulado diário de custos  
- Distribuição de custos por time  
- Ranking mensal com `ROW_NUMBER()`  
- Detecção de outliers com base no `P90`

#### ⚡ Window Functions Utilizadas

- `SUM() OVER`
- `ROW_NUMBER() OVER`
- `RANK() OVER`
- `AVG() OVER`

---

## ⚙️ Tecnologias e Ferramentas

- PostgreSQL
- SQL
- Views
- CTEs
- Window Functions
- Star Schema
- Git

---

## 📂 Estrutura

```bash
schemas/
bronze/
silver/
gold/
views/
constraints/
README.md
```

### 📈 Amostra de Resultados
Uso e custo por mês


<img width="781" height="160" alt="image" src="https://github.com/user-attachments/assets/65332757-71f4-4ed9-9883-cb5f00d8e8bf" />

Registros que excedem o limite de utilização do P90


<img width="1211" height="157" alt="image" src="https://github.com/user-attachments/assets/b5b6af4a-83af-469e-8a04-358e913fd4f7" />

---

⚠️ Limitações

Sem orquestração

Ingestão manual

Protótipo local

---------------------------------------------------------
