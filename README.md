# Hospital Readmission Data Engineering Pipeline

Pipeline de engenharia de dados desenvolvido para ingestão,
transformação, modelagem e análise de dados clínicos relacionados à
readmissão hospitalar. O projeto segue a arquitetura Medallion (Bronze,
Silver, Gold) e demonstra práticas comuns em pipelines de dados
utilizados em ambientes analíticos.

## Objetivo

Construir um pipeline de dados completo capaz de:

- Ingerir dados clínicos brutos
- Limpar e transformar os dados
- Modelar os dados para análise
- Armazenar os dados em banco relacional
- Permitir consultas analíticas utilizando SQL

O objetivo analítico do projeto é investigar fatores associados à
readmissão hospitalar, como condições clínicas, perfil do paciente e
tempo de internação.

---

## Arquitetura do Projeto

O pipeline segue a arquitetura Medallion.

### Bronze Layer

Camada de ingestão de dados brutos.

- Dados originais são armazenados sem transformação significativa
- Mantém fidelidade ao dataset original
- Serve como fonte de rastreabilidade

Local:

data/bronze

---

### Silver Layer

Camada de limpeza e padronização.

Transformações realizadas:

- Tratamento de valores ausentes
- Padronização de tipos de dados
- Criação de variáveis derivadas
- Preparação para modelagem analítica

Local:

data/silver

---

### Gold Layer

Camada analítica otimizada para consultas.

Foi implementada modelagem dimensional com tabelas fato e dimensão.

#### Tabelas Dimensão

dim_patient\
Informações demográficas do paciente.

dim_clinical\
Informações clínicas relevantes como pressão arterial, colesterol e
condições metabólicas.

dim_discharge\
Informações relacionadas à alta hospitalar.

#### Tabela Fato

fact_readmission

Tabela central contendo eventos de internação.

Principais métricas:

- tempo de internação
- número de medicações
- readmissão em até 30 dias

---

## Estrutura do Projeto

hospital-readmission-data-engineering

data/ bronze/ silver/ gold/

notebooks/ 01_bronze_ingestion.ipynb 02_silver_transformation.ipynb
03_gold_modeling.ipynb

pipelines/ load_gold_to_mysql.py

sql/ dim_clinical.sql dim_discharge.sql dim_patient.sql
fact_readmission.sql

README.md requirements.txt

---

## Tecnologias Utilizadas

Linguagens - Python - SQL

Processamento de Dados - Pandas

Armazenamento - Parquet

Banco de Dados - MySQL

Ferramentas - Jupyter Notebook - VS Code - Git

---

## Pipeline de Dados

Fluxo do processamento:

1.  Ingestão dos dados brutos
2.  Transformação e limpeza
3.  Modelagem dimensional
4.  Armazenamento em Parquet
5.  Carregamento das tabelas analíticas no MySQL
6.  Execução de consultas analíticas em SQL

Script responsável pelo carregamento:

pipelines/load_gold_to_mysql.py

---

## Exemplos de Análises SQL

Perguntas exploradas:

- Qual estágio de pressão apresenta maior taxa de readmissão?
- Pacientes com maior número de medicações ficam mais tempo
  internados?
- Existe correlação entre condições clínicas e readmissão hospitalar?
- Qual perfil de paciente possui maior risco de retorno em 30 dias?

Consultas disponíveis na pasta:

sql/

---

## Como Executar o Projeto

### 1. Instalar dependências

pip install -r requirements.txt

### 2. Executar notebooks

Executar na ordem:

01_bronze_ingestion.ipynb\
02_silver_transformation.ipynb\
03_gold_modeling.ipynb

### 3. Carregar dados no MySQL

python pipelines/load_gold_to_mysql.py

---

## Melhorias Futuras

Possíveis evoluções:

- Orquestração com Airflow
- Dashboards analíticos
- Testes de qualidade de dados
- Deploy em ambiente cloud
- Containerização com Docker

---
