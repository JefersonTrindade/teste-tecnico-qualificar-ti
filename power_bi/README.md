# Dashboard Power BI

**Formato escolhido:** [Power BI Project (.pbip)](https://learn.microsoft.com/power-bi/developer/projects/projects-overview) em vez de `.pbix` binário — gera arquivos texto/JSON versionáveis (pastas `*.Report/` e `*.SemanticModel/`), permitindo acompanhar a evolução do dashboard no histórico do Git (um dos entregáveis do teste). Power BI Desktop já instalado nesta máquina (Microsoft Store, v2.157).

**Fonte de dados:** importar diretamente os arquivos tratados em `../dados/tratados/` (Get Data → Pasta/Excel/CSV), evitando depender de driver ODBC para o SQLite usado nos scripts em `../sql/`.

## Passos ao construir o dashboard
1. Abrir o Power BI Desktop.
2. **Arquivo → Salvar como** → escolher formato **Power BI Project (.pbip)**, salvando dentro desta pasta (`power_bi/`).
3. Get Data → apontar para os arquivos em `../dados/tratados/`.
4. Modelar os relacionamentos conforme o [modelo dimensional](../modelagem/modelo_dimensional.md).
5. Construir as visualizações.
6. Salvar — os arquivos `.pbip`/`.Report`/`.SemanticModel` ficam prontos para commit.
