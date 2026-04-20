/*
PROJETO: Indicadores Educacionais 
ETAPA: Limpeza e Tratamento dos Dados 
OBJETIVO: Padronizar valores, tratar campos nulos em proficiência e remover duplicatas
===============================================================================
TABELA: ALUNOS
===============================================================================
*/

-- [FASE 1] DIAGNÓSTICO INICIAL
-- Verificando ausência de dados e inconsistências
-- RESULTADO: Foram identificados valores nulos na coluna NOME e valores fora do formato esperado na coluna IDADE, o que impediria cálculos e agregações.
SELECT * 
FROM "Avalia - Estudo de Caso"."ALUNOS"
WHERE
-- Busca por valores nulos nas três colunas da tabela 
    "ID_ALUNO" IS NULL
    OR "NOME" IS NULL 
    OR "NOME" = ''
    OR "IDADE" IS NULL 
    OR "IDADE" = ''
-- Busca por valores em formato incorreto para a as colunas IDADE
    OR "IDADE" NOT SIMILAR TO '[0-9]+'
-- Busca por valores fora da faixa esperada para a coluna IDADE. A base de dados deve conter apenas alunos em idade escolar regular (14 a 17 anos).
    OR (CASE 
            WHEN "IDADE" SIMILAR TO '[0-9]+' 
            -- Aplicação de filtro de exceção CAST para identificar registros fora do intervalo esperado
            THEN CAST("IDADE" AS INTEGER) < 14 OR CAST("IDADE" AS INTEGER) > 17 
            ELSE FALSE 
        END);

-------------------------------------------------------------------------
-- [FASE 2] PADRONIZAÇÃO E CORREÇÃO MANUAL
-- 1. Padronizar nomes para MAIÚSCULO e remover espaços residuais
UPDATE "Avalia - Estudo de Caso"."ALUNOS"
-- Aplicada a função UPPER e TRIM na coluna NOME para evitar duplicatas causadas por diferenças de caixa (alta/baixa) ou espaços.
SET "NOME" = UPPER(TRIM("NOME"))
WHERE "NOME" IS NOT NULL;

-- 2. Corrigindo inconsistência de tipo (Texto para Numeral)
UPDATE "Avalia - Estudo de Caso"."ALUNOS"
-- O valor textual 'catorze' na coluna IDADE foi convertido para o caractere '14', preparando a coluna para futura conversão em tipo Inteiro.
SET "IDADE" = '14'
WHERE "IDADE" = 'catorze';

-- 3. Enriquecimento de dados através de planilhas externas (ID 14 estava sem nome)
UPDATE "Avalia - Estudo de Caso"."ALUNOS"
SET "NOME" = 'CARLOS ALBERTO FERNANDES'
-- Para não alterar o nome de todos os alunos por engano, usarei como "âncora", o ID_ALUNO = 14. Que é o que está com nome faltando.
WHERE "ID_ALUNO" = 14;

-- 4. Ajuste manual de dado através de planilhas externas (Aluno fora da faixa etária escolar do 1º ano)
UPDATE "Avalia - Estudo de Caso"."ALUNOS"
SET "IDADE" = '15'
WHERE "ID_ALUNO" = 3 AND "IDADE" = '25';

-- 5. Verificação final das correções realizadas
-- Utilizando script SELECT padrão e o script da FASE 1 (DIAGNÓSTICO INICIAL) para verificar existência de inconsistências

-------------------------------------------------------------------------
-- [FASE 3] CONSOLIDAÇÃO E DEDUPLICAÇÃO
-- 1. Verificar a existência de dados duplicados
-- RESULTADO: Foram identificados linhas completas duplicadas em alguns IDs
SELECT "ID_ALUNO", "NOME", "IDADE", COUNT(*) as contagem_duplicatas
FROM "Avalia - Estudo de Caso"."ALUNOS"
GROUP BY "ID_ALUNO", "NOME", "IDADE"
HAVING COUNT(*) > 1;

-- 2. Criar a tabela final limpa, removendo espelhos gerados por inconsistências prévias
CREATE TABLE "Avalia - Estudo de Caso"."ALUNOS_DADOS_LIMPOS" AS
SELECT DISTINCT
   "ID_ALUNO",
   "NOME",
   "IDADE"
FROM "Avalia - Estudo de Caso"."ALUNOS";

-------------------------------------------------------------------------
-- [FASE 4] TIPAGEM FINAL E VALIDAÇÃO
-- 1. Converter IDADE para Inteiro para permitir cálculos no Dashboard
ALTER TABLE "Avalia - Estudo de Caso"."ALUNOS_DADOS_LIMPOS"
ALTER COLUMN "IDADE" TYPE INTEGER USING "IDADE"::integer;

-- 2. Teste de Sanidade Final: Não deve retornar registros
SELECT "ID_ALUNO", COUNT(*)
FROM "Avalia - Estudo de Caso"."ALUNOS_DADOS_LIMPOS"
GROUP BY "ID_ALUNO"
HAVING COUNT(*) > 1;

-- Tabela ALUNOS_DADOS_LIMPOS estruturada e pronta para criação de métricas para uso no Power BI, com tipos de dados consistentes.