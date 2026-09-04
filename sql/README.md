# Scripts SQL

**Motor escolhido:** SQLite — dialeto simples, sem necessidade de instalar/configurar um servidor, e compatível com o testador online usado neste teste.

**Ferramenta de teste/validação:** [sqliteonline.com](https://sqliteonline.com/) — selecionar o motor **SQLite** na interface, colar o script e executar para validar antes de salvar a versão final aqui no repositório.

## Convenção de nomes
Scripts numerados na ordem de execução:
- `01_ddl_dimensoes.sql` — criação das tabelas de dimensão
- `02_ddl_fatos.sql` — criação das tabelas de fato
- `03_carga.sql` — carga dos dados tratados (INSERT / import)
- `04_consultas_validacao.sql` — queries de validação/exemplo sobre o modelo

*(ajustar nomes/quantidade conforme o modelo dimensional definido após receber os dados)*
