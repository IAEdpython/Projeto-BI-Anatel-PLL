/* =============================================================================
PROJETO: DESAFIO ANALISTA DE BI - GRUPO PLL
CANDIDATO: EDIVALDO PEREIRA DOS SANTOS
OBJETIVO: ESTRUTURAÇÃO DE DADOS TELEFONIA MÓVEL (ANATEL)
=============================================================================
*/

-- 1. CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS projeto_bi_pll;
USE projeto_bi_pll;

-- 2. CRIAÇÃO DA TABELA DE STAGING (INGESTÃO BRUTA)
-- Esta tabela recebe os dados do CSV/BigQuery para saneamento
CREATE TABLE IF NOT EXISTS staging_acessos (
    ano INT,
    mes INT,
    sigla_uf VARCHAR(2),
    razao_social VARCHAR(150),
    cnpj VARCHAR(20),
    tecnologia VARCHAR(50),
    modalidade VARCHAR(50),
    acessos INT
);

-- 3. CRIAÇÃO DAS TABELAS DE DIMENSÃO (MODELO STAR SCHEMA)

-- Dimensão de Estados
CREATE TABLE IF NOT EXISTS dim_estado (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    sigla_uf VARCHAR(2) UNIQUE NOT NULL
);

-- Dimensão de Tecnologia e Produto
CREATE TABLE IF NOT EXISTS dim_tecnologia (
    id_tecnologia INT AUTO_INCREMENT PRIMARY KEY,
    tecnologia VARCHAR(50),
    tipo_produto VARCHAR(50)
);

-- Dimensão de Empresas (Operadoras)
CREATE TABLE IF NOT EXISTS dim_empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    cnpj VARCHAR(20),
    razao_social VARCHAR(150)
);

-- 4. CRIAÇÃO DA TABELA FATO
CREATE TABLE IF NOT EXISTS fato_acessos (
    id_fato INT AUTO_INCREMENT PRIMARY KEY,
    id_estado INT,
    id_tecnologia INT,
    id_empresa INT,
    quantidade_acessos INT,
    data_referencia DATE,
    CONSTRAINT fk_estado FOREIGN KEY (id_estado) REFERENCES dim_estado(id_estado),
    CONSTRAINT fk_tecnologia FOREIGN KEY (id_tecnologia) REFERENCES dim_tecnologia(id_tecnologia),
    CONSTRAINT fk_empresa FOREIGN KEY (id_empresa) REFERENCES dim_empresa(id_empresa)
);

-- 5. PROCEDIMENTO DE CARGA (LOGICA DE ETL)

/* NOTA PARA O AVALIADOR: 
   Após a ingestão na staging_acessos, os comandos abaixo 
   populam o Star Schema garantindo a integridade referencial.
*/

-- Popular Dimensão Estado
INSERT INTO dim_estado (sigla_uf)
SELECT DISTINCT sigla_uf FROM staging_acessos 
WHERE sigla_uf IS NOT NULL;

-- Popular Dimensão Tecnologia
INSERT INTO dim_tecnologia (tecnologia, tipo_produto)
SELECT DISTINCT tecnologia, modalidade FROM staging_acessos;

-- Popular Dimensão Empresa (Tratando Razão Social para Maiúsculo)
INSERT INTO dim_empresa (cnpj, razao_social)
SELECT DISTINCT cnpj, UPPER(razao_social) FROM staging_acessos;

-- Popular Tabela Fato relacionando as chaves
INSERT INTO fato_acessos (id_estado, id_tecnologia, id_empresa, quantidade_acessos, data_referencia)
SELECT 
    e.id_estado,
    t.id_tecnologia,
    emp.id_empresa,
    s.acessos,
    STR_TO_DATE(CONCAT(s.ano, '-', s.mes, '-01'), '%Y-%m-%d')
FROM staging_acessos s
JOIN dim_estado e ON s.sigla_uf = e.sigla_uf
JOIN dim_tecnologia t ON s.tecnologia = t.tecnologia AND s.modalidade = t.tipo_produto
JOIN dim_empresa emp ON s.cnpj = emp.cnpj;

-- 6. CONSULTA DE VALIDAÇÃO (KPI DASHBOARD)
-- Verificação do volume total (deve bater com os 5 Bilhões do dashboard)
SELECT SUM(quantidade_acessos) AS total_acessos_processados FROM fato_acessos;