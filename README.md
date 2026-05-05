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

## 👤 Sobre o Autor
**Edivaldo Pereira dos Santos**
Especialista em Business Intelligence com mais de 23 anos de experiência em dados. Especialista em modelagem dimensional, automação de processos e criação de dashboards executivos.
