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

## Modelagem assistida via MCP (powerbi-modeling-mcp)
Com o `.pbip` aberto no Power BI Desktop (ou direto na pasta do projeto via `ConnectFolder`, offline), o Claude pode criar/editar tabelas, relacionamentos, medidas DAX e grupos de cálculo diretamente no modelo semântico (TMDL) via `mcp__powerbi-modeling-mcp__*`, sem precisar repetir tudo manualmente na UI — acelera bastante a etapa de modelagem dentro do prazo de 4h.

- `connection_operations` (`ListLocalInstances` + `Connect`, ou `ConnectFolder` apontando para esta pasta) — conectar à instância.
- `table_operations` / `partition_operations` — criar tabelas e definir a fonte via expressão M.
- `relationship_operations` — criar os relacionamentos fato↔dimensão.
- `measure_operations` — criar as medidas DAX.
- `model_operations` (`ExportTMDL`) — conferir o modelo resultante.

**Importante:** essas ferramentas cobrem apenas o **modelo semântico** (tabelas/relacionamentos/medidas). O desenho dos **visuais e páginas do relatório** continua manual no Power BI Desktop.
