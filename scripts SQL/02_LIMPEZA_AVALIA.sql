/*
PROJETO: Indicadores Educacionais 
ETAPA: Limpeza e Tratamento dos Dados 
OBJETIVO: Padronizar valores, tratar campos nulos em proficiência e remover duplicatas
===============================================================================
TABELA: AVALIA
===============================================================================
Nota: Para que seja possível realizar a limpeza com mais eficiência, foi realizada a conversão
dos dados para tipos mais adequados. A coluna PROFICIENCIA estava originalmente em VARCHAR(50),
sendo convertida para NUMERIC, tendo em vista os valores com casas decimais da coluna*/


-- [FASE 1] DIAGNÓSTICO INICIAL
-- Verificando ausência de dados e inconsistências
-- RESULTADO: Foram identificados campos inconsistentes na coluna ID_ALUNO, ID_TURMA e PROFICIENCIA; campos em branco na coluna ID_TURMA; campos nulos na coluna TOTAL_QUESTOES
SELECT 
    *
FROM "Avalia - Estudo de Caso"."AVALIA"
WHERE 
    -- Para verificar mais de uma coluna ao mesmo tempo
    COALESCE("ID_ALUNO", "ACERTOS", "PROFICIENCIA","ID_PROFICIENCIA") IS NULL 
    -- Coluna ID_TURMA é texto, tem que ter a string vazia ' ' também, para procurar células sem texto
    OR "ID_TURMA" IN (NULL, '')
    -- Utilizado a funções de tratamento de string (NOT IN) para identificar registros de turmas incoerentes
    OR "ID_TURMA" NOT IN ('1A', '1B', '1C', '1D')
    -- Para verificar ID_ALUNO fora da faixa esperada, de 1 a 120
    OR "ID_ALUNO" NOT BETWEEN 1 AND 120
    -- Coluna ACERTOS deve estar no intervalo de 0 a 32, que é o número total de questões
    OR "ACERTOS" NOT BETWEEN 0 AND 32
    -- A coluna ID_PROFICIENCIA deve conter somente números de 1 a 4, como indicado na tabela PROFICIENCIA
    OR "ID_PROFICIENCIA" NOT BETWEEN 1 AND 4
    OR "TOTAL_QUESTOES" IS NULL
    -- A coluna TOTAL_QUESTOES deve ter somente campos com o número 32
    OR "TOTAL_QUESTOES" <> 32;
    
-------------------------------------------------------------------------
-- [FASE 2] PADRONIZAÇÃO E CORREÇÃO MANUAL
-- 1. Enriquecimento de dados através de planilhas externas (ID 7 e ID 111 estavam sem as turmas correspondentes)
UPDATE "Avalia - Estudo de Caso"."AVALIA"
SET "ID_TURMA" = '1A' 
WHERE "ID_ALUNO" = 7;

UPDATE "Avalia - Estudo de Caso"."AVALIA"
SET "ID_TURMA" = '1D' 
WHERE "ID_ALUNO" = 111;

-- 2. Ajuste manual de dados (total de questões é padronizado como 32, correção dos IDs 21, 50 e 95)
UPDATE "Avalia - Estudo de Caso"."AVALIA"
SET "TOTAL_QUESTOES" = 32
WHERE "ID_ALUNO" = 21 or "ID_ALUNO" = 50 or "ID_ALUNO" = 95;

-- 3. Extração de linha com dados inconsistentes (ID 1000 e turma 9X)
DELETE FROM "Avalia - Estudo de Caso"."AVALIA"
WHERE "ID_ALUNO" = 1000;3

-- 4. Verificação final das correções realizadas
-- Utilizando script SELECT padrão e o script da FASE 1 (DIAGNÓSTICO INICIAL) para verificar existência de inconsistências

-------------------------------------------------------------------------
-- [FASE 3] CONSOLIDAÇÃO E DEDUPLICAÇÃO
-- 1. Verificar a existência de dados duplicados
-- RESULTADO: Foram identificados linhas completas duplicadas em alguns IDs
SELECT "ID_ALUNO", "ID_TURMA", "ACERTOS", "TOTAL_QUESTOES", "PROFICIENCIA", "ID_PROFICIENCIA", COUNT(*) as contagem_duplicatas
FROM "Avalia - Estudo de Caso"."AVALIA"
GROUP BY "ID_ALUNO", "ID_TURMA", "ACERTOS", "TOTAL_QUESTOES", "PROFICIENCIA", "ID_PROFICIENCIA"
HAVING COUNT(*) > 1;

-- 2. Criar a tabela final limpa, removendo espelhos gerados por inconsistências prévias
CREATE TABLE "Avalia - Estudo de Caso"."AVALIA_DADOS_LIMPOS" AS
SELECT DISTINCT
  "ID_ALUNO",
  "ID_TURMA",
  "ACERTOS",
  "TOTAL_QUESTOES",
  "PROFICIENCIA",
  "ID_PROFICIENCIA"
FROM "Avalia - Estudo de Caso"."AVALIA";

-------------------------------------------------------------------------
-- [FASE 4]  VALIDAÇÃO FINAL
-- Teste de Sanidade Final: Não deve retornar registros
SELECT "ID_ALUNO", COUNT(*)
FROM"Avalia - Estudo de Caso"."AVALIA_DADOS_LIMPOS"
GROUP BY "ID_ALUNO"
HAVING COUNT(*) > 1;

-- Tabela AVALIA_DADOS_LIMPOS estruturada e pronta para criação de métricas para uso no Power BI, com tipos de dados consistentes.


