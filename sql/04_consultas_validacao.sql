-- Consultas de validacao da carga + as 4 perguntas de negocio pedidas no teste.
-- Sintaxe SQL ANSI (JOIN/GROUP BY/ORDER BY/LIMIT padrao, compativel com SQLite/DuckDB).

-- ============================================================
-- 0. Validacao da carga (contagem de linhas por tabela)
-- ============================================================
SELECT 'dim_operadora' AS tabela, COUNT(*) AS linhas FROM dim_operadora
UNION ALL
SELECT 'dim_beneficiario', COUNT(*) FROM dim_beneficiario
UNION ALL
SELECT 'dim_especialidade', COUNT(*) FROM dim_especialidade
UNION ALL
SELECT 'dim_tempo', COUNT(*) FROM dim_tempo
UNION ALL
SELECT 'fato_atendimento', COUNT(*) FROM fato_atendimento;

-- ============================================================
-- 1. Quais sao as 10 especialidades com maior valor total de atendimentos?
-- ============================================================
SELECT
    e.especialidade,
    SUM(f.valor)   AS valor_total,
    COUNT(*)       AS qtd_atendimentos
FROM fato_atendimento f
JOIN dim_especialidade e ON e.id_especialidade = f.id_especialidade
GROUP BY e.especialidade
ORDER BY valor_total DESC
LIMIT 10;

-- ============================================================
-- 2. Qual e o valor medio dos atendimentos por operadora?
-- ============================================================
SELECT
    o.operadora,
    ROUND(AVG(f.valor), 2) AS valor_medio,
    COUNT(*)               AS qtd_atendimentos
FROM fato_atendimento f
JOIN dim_operadora o ON o.id_operadora = f.id_operadora
GROUP BY o.operadora
ORDER BY valor_medio DESC;

-- ============================================================
-- 3. Qual e a quantidade de atendimentos por UF?
-- ============================================================
SELECT
    b.uf,
    COUNT(*) AS qtd_atendimentos
FROM fato_atendimento f
JOIN dim_beneficiario b ON b.id_beneficiario = f.id_beneficiario
GROUP BY b.uf
ORDER BY qtd_atendimentos DESC;

-- ============================================================
-- 4. Quais beneficiarios possuem mais de 20 atendimentos?
-- ============================================================
SELECT
    f.id_beneficiario,
    COUNT(*) AS qtd_atendimentos
FROM fato_atendimento f
WHERE f.id_beneficiario <> -1  -- exclui o sentinela "Beneficiario Nao Identificado"
GROUP BY f.id_beneficiario
HAVING COUNT(*) > 20
ORDER BY qtd_atendimentos DESC;
