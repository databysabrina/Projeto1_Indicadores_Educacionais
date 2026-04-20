/*
PROJETO: Indicadores Educacionais 
ETAPA: Analise Exploratória
OBJETIVO: Trabalhar com os dados na criação de métricas que possam revelar padrões ou dados discrepantes
===============================================================================
TABELA: ANALISE_TURMAS
===============================================================================
Nota: ... */


-- [FASE 1] VERIFICAÇÃO TIPOS DE DADOS
-- Identificar os tipos de dados da tabela, alterando caso necessário para criação das métricas posteriores
SELECT
   column_name, 
   data_type, 
   character_maximum_length
FROM
   information_schema.columns
WHERE
   table_name = 'ANALISE_TURMAS' 
   AND table_schema = 'Avalia - Estudo de Caso'; -- Nome do schema no banco de dados

-- Os tipos de dados estão adequados as métricas posteriores

===============================================================================
-- [FASE 2] CRIAÇÃO DE COLUNAS/MÉTRICAS
-- Pensando em melhorar a escrita de scripts do sql, criei primeiro todas as colunas para depois adicionar as métricas
ALTER TABLE "Avalia - Estudo de Caso"."ANALISE_TURMAS"
ADD COLUMN "MEDIA_ACERTO" NUMERIC,
ADD COLUMN "MEDIA_PROFICIENCIA" NUMERIC,
ADD COLUMN "RANKING_TURMA" INTEGER;

-- 1. Colunas: MÉDIA_ACERTO e MEDIA_PROFICIENCIA
-- Criadas para calcular as médias das turmas, possibilitando comparações
UPDATE "Avalia - Estudo de Caso"."ANALISE_TURMAS" rt -- renomeamos a tabela que será alterada para facilitar a referência
-- Definindo quais colunas vão receber os dados de uma tabela temporária que chamei de sub
SET
   "MEDIA_ACERTO" = sub.media_calculada, 
   "MEDIA_PROFICIENCIA" = sub.prof_calculada
FROM (
   -- Esta parte calcula os valores antes de enviar para a tabela que será alterada
   SELECT
       "NOME_TURMA",
       ROUND(AVG("ACERTOS"), 2) AS media_calculada, -- agrupa todos que são da mesma turma na tabela ANALISE_GERAL e calcula a média de acertos e depois de proficiência
       ROUND(AVG("PROFICIENCIA"), 2) AS prof_calculada
   FROM "Avalia - Estudo de Caso"."ANALISE_GERAL"
   GROUP BY "NOME_TURMA" -- Para garantir que seja criada apenas uma linha por turma com os resultados finais
) sub -- apelido da tabela temporária criada
WHERE rt."NOME_TURMA" = sub."NOME_TURMA"; -- relaciona o NOME_TURMA das duas tabelas, para garantir que os resultados sejam colocados nas linhas corretas


-- 2. Coluna: RANKING_TURMA
-- Criada para comparar mais diretamente a Média de Acertos entre as turmas
UPDATE "Avalia - Estudo de Caso"."ANALISE_TURMAS" rt
SET "RANKING_TURMA" = sub.posicao -- utilizei o mesmo processo, criando uma tabela temporária para realizar o ranking
FROM (
   SELECT
       "NOME_TURMA",
       RANK() OVER (ORDER BY "MEDIA_ACERTO" DESC) AS posicao -- ordem das posições de acordo com a média de acertos, as posições são adicionadas a coluna RANKING_TURMA
   FROM "Avalia - Estudo de Caso"."ANALISE_TURMAS"
) sub
WHERE rt."NOME_TURMA" = sub."NOME_TURMA";

-- Tabela ANALISE_TURMAS pronta para visualização e criação de métricas no Power BI.