# Teste Técnico — Qualificar TI

## 1. Visão geral
Descrição breve do problema proposto e do objetivo da solução.

*(preencher após receber o enunciado)*

## 2. Abordagem técnica e ferramentas utilizadas
Esta solução foi desenvolvida com apoio do **Claude Code** (Anthropic) como ferramenta de produtividade ao longo de todo o fluxo — ETL, modelagem, SQL, documentação e versionamento —, com as decisões técnicas, validações e justificativas de responsabilidade do candidato.

Um destaque específico da abordagem: a modelagem do banco semântico do Power BI (tabelas, relacionamentos e medidas DAX) foi construída via automação **MCP (Model Context Protocol)**, manipulando diretamente o modelo semântico (TMDL) do `.pbip` em vez de recriar tudo manualmente na interface — reduzindo trabalho repetitivo e erro humano na etapa de modelagem, dentro do prazo de 4 horas. Detalhes em [`power_bi/README.md`](power_bi/README.md#modelagem-assistida-via-mcp-powerbi-modeling-mcp).

Demais escolhas de ferramental:
- **Jupyter/Python (Anaconda)** para o ETL — pandas para tratamento e validação dos dados.
- **SQLite** como motor dos scripts SQL, validados em [sqliteonline.com](https://sqliteonline.com/).
- **Mermaid** para o diagrama do modelo dimensional, versionado como texto e renderizado nativamente no GitHub.
- **Power BI Project (.pbip)** em vez de `.pbix` binário, para permitir versionamento real do dashboard no Git.
- **Git com commits incrementais**, refletindo a evolução real do desenvolvimento (não um único commit final).

## 3. Estrutura do repositório
```
.
├── dados/
│   ├── brutos/        # planilhas originais recebidas
│   └── tratados/       # saídas do ETL
├── notebooks/
│   └── tratamento_dados.ipynb   # notebook Python com o ETL
├── sql/                # scripts SQL (SQLite) de criação/carga do modelo dimensional
├── modelagem/          # diagrama do modelo dimensional (Mermaid)
├── power_bi/           # dashboard Power BI (.pbip)
├── abrir_jupyter.bat   # atalho para abrir o Jupyter Lab
└── README.md
```

## 4. Como executar
1. Abrir o Jupyter Lab (`abrir_jupyter.bat` ou `jupyter lab` no ambiente Anaconda).
2. Rodar `notebooks/tratamento_dados.ipynb` de ponta a ponta — gera os arquivos tratados em `dados/tratados/`.
3. Rodar os scripts em `sql/` (dialeto **SQLite**) para criar e carregar o modelo dimensional — validados em [sqliteonline.com](https://sqliteonline.com/) (selecionar motor SQLite).
4. Abrir o arquivo do Power BI em `power_bi/` (dados atualizados a partir de `dados/tratados/`).

## 5. Modelo dimensional
Diagrama e justificativa da modelagem (star schema / snowflake, granularidade dos fatos, dimensões escolhidas).

*(preencher durante a execução)*

## 6. Principais decisões e premissas adotadas
- ...

## 7. Observações relevantes sobre o tratamento dos dados
- ...

## 8. Itens não implementados / abordagem proposta
Registrar aqui qualquer decisão que não pôde ser implementada dentro do prazo de 4 horas, com a justificativa e a abordagem que seria seguida.

- ...

## 9. Entregáveis
- [ ] Notebook Python
- [ ] Código-fonte da solução
- [ ] Arquivos resultantes do ETL
- [ ] Diagrama do modelo dimensional
- [ ] Scripts SQL
- [ ] Arquivo/dashboard do Power BI
- [ ] README.md
- [ ] Repositório Git com histórico de desenvolvimento
