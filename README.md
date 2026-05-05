# Projeto-BI-Anatel-PLL
# Projeto de Business Intelligence - Análise de Telefonia Móvel (Anatel)

## 🏗️ Arquitetura da Solução
A solução foi estruturada em camadas para garantir escalabilidade e integridade:
*   **Origem dos Dados:** Microdados brutos da ANATEL.
*   **Tratamento (ETL):** Utilização do **Google BigQuery** e SQL para limpeza e transformação.
*   **Armazenamento:** Implementação em **MySQL** utilizando a metodologia **Star Schema**.
*   **Visualização:** **Power BI** com métricas de Inteligência Temporal (DAX).

## 🔄 Fluxo de Dados
**ANATEL → BigQuery → Staging → Data Warehouse (MySQL) → Power BI**


## 🚀 Instruções para Reprodução do Ambiente

Para visualizar e testar o projeto localmente, siga os passos abaixo:

1. **Banco de Dados (MySQL):**
   *   Crie um novo schema (Database) no seu servidor MySQL.
   *   Importe e execute o arquivo `Banco_de_Dados_Projeto_PLL.sql` disponível neste repositório. Este arquivo contém toda a estrutura de tabelas e a carga de dados necessária.

2. **Dashboard (Power BI):**
   *   Certifique-se de ter o Power BI Desktop instalado.
   *   Abra o arquivo `Dashboard de Desempenho de Acessos.pbix`.
   *   Caso os dados não carreguem automaticamente, vá em *Transformar Dados* > *Configurações da Fonte de Dados* e aponte para o seu servidor MySQL local.

3. **Documentação Técnica:**
   *   Para detalhes sobre as métricas (DAX) e regras de negócio, consulte o arquivo `Projeto_BI_EdivaldoSantos.pdf`.

## 👤 Sobre o Autor
**Edivaldo Pereira dos Santos**
Especialista em Business Intelligence com mais de 23 anos de experiência em dados. Especialista em modelagem dimensional, automação de processos e criação de dashboards executivos.
