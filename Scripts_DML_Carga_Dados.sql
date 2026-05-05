/* 
=============================================================================
SCRIPT DML: CARGA E PROCESSAMENTO DE DADOS (ETL)
PROJETO: DESAFIO BI - GRUPO PLL
CANDIDATO: EDIVALDO PEREIRA DOS SANTOS
=============================================================================
*/

USE projeto_bi_pll;

-- 1. Povoando a Dimensão Empresa (apenas nomes únicos)
-- Padronizando para MAIÚSCULO para evitar duplicidade visual
INSERT INTO dim_empresa (razao_social)
SELECT DISTINCT UPPER(empresa) 
FROM staging_acessos;

-- 2. Povoando a Dimensão Estado (antiga localidade)
INSERT INTO dim_estado (sigla_uf)
SELECT DISTINCT sigla_uf 
FROM staging_acessos;

-- 3. Povoando a Dimensão Tecnologia (combinações únicas de Tecnologia e Produto)
INSERT INTO dim_tecnologia (tecnologia, tipo_produto)
SELECT DISTINCT tecnologia, modalidade 
FROM staging_acessos;

-- 4. Povoando a Tabela Fato (Conectando as dimensões e convertendo a data)
-- O uso de JOINs garante a integridade referencial do modelo Star Schema
INSERT INTO fato_acessos (id_estado, id_tecnologia, id_empresa, acessos, data_referencia)
SELECT 
    est.id_estado,
    tec.id_tecnologia,
    emp.id_empresa,
    s.total_acessos,
    STR_TO_DATE(CONCAT(s.ano, '-', s.mes, '-01'), '%Y-%m-%d')
FROM staging_acessos s
JOIN dim_estado est ON s.sigla_uf = est.sigla_uf
JOIN dim_tecnologia tec ON s.tecnologia = tec.tecnologia AND s.modalidade = tec.tipo_produto
JOIN dim_empresa emp ON UPPER(s.empresa) = emp.razao_social;

-- Verificação rápida da carga
SELECT COUNT(*) AS total_registros_fato FROM fato_acessos;