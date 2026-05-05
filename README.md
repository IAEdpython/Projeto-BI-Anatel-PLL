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
   *   ****Importante:** É necessário ter o driver **MySQL 8.0.46** instalado na máquina
   *   **Segue o link para download:  https://dev.mysql.com/downloads/installer/
   *   Crie um novo schema (Database) no seu servidor MySQL.
   *   Importe e execute o arquivo `Banco_de_Dados_Projeto_PLL.sql` disponível neste repositório. Este arquivo contém toda a estrutura de tabelas e a carga de dados necessária.

3. **Dashboard (Power BI):**
   *   Certifique-se de ter o Power BI Desktop instalado.
   *   **Importante:** É necessário ter o driver **MySQL Connector/NET** instalado na máquina para que o Power BI consiga se comunicar com o banco de dados.
   *   **Segue o link: https://dev.mysql.com/downloads/connector/net/
   *   
   *   Abra o arquivo `Dashboard de Desempenho de Acessos.pbix`.
   *   Caso os dados não carreguem automaticamente, vá em *Transformar Dados* > *Configurações da Fonte de Dados* e aponte para o seu servidor MySQL local.

4. **Documentação Técnica:**
   *   Para detalhes sobre as métricas (DAX) e regras de negócio, consulte o arquivo `Projeto_BI_EdivaldoSantos.pdf`.

## 👤 Sobre o Autor
**Edivaldo Pereira dos Santos**
Especialista em Business Intelligence com mais de 23 anos de experiência em dados. Especialista em modelagem dimensional, automação de processos e criação de dashboards executivos.
