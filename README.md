# Teste Técnico — Qualificar TI

## 1. Visão geral
Descrição breve do problema proposto e do objetivo da solução.

*(preencher após receber o enunciado)*

## 2. Estrutura do repositório
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

## 3. Como executar
1. Abrir o Jupyter Lab (`abrir_jupyter.bat` ou `jupyter lab` no ambiente Anaconda).
2. Rodar `notebooks/tratamento_dados.ipynb` de ponta a ponta — gera os arquivos tratados em `dados/tratados/`.
3. Rodar os scripts em `sql/` (dialeto **SQLite**) para criar e carregar o modelo dimensional — validados em [sqliteonline.com](https://sqliteonline.com/) (selecionar motor SQLite).
4. Abrir o arquivo do Power BI em `power_bi/` (dados atualizados a partir de `dados/tratados/`).

## 4. Modelo dimensional
Diagrama e justificativa da modelagem (star schema / snowflake, granularidade dos fatos, dimensões escolhidas).

*(preencher durante a execução)*

## 5. Principais decisões e premissas adotadas
- ...

## 6. Observações relevantes sobre o tratamento dos dados
- ...

## 7. Itens não implementados / abordagem proposta
Registrar aqui qualquer decisão que não pôde ser implementada dentro do prazo de 4 horas, com a justificativa e a abordagem que seria seguida.

- ...

## 8. Entregáveis
- [ ] Notebook Python
- [ ] Código-fonte da solução
- [ ] Arquivos resultantes do ETL
- [ ] Diagrama do modelo dimensional
- [ ] Scripts SQL
- [ ] Arquivo/dashboard do Power BI
- [ ] README.md
- [ ] Repositório Git com histórico de desenvolvimento
