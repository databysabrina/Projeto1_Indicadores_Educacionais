/*
PROJETO: Indicadores Educacionais 
ETAPA: Analise Exploratória
OBJETIVO: Trabalhar com os dados na criação de métricas que possam revelar padrões ou dados discrepantes
===============================================================================
TABELA: ANALISE_GERAL
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
   table_name = 'ANALISE_GERAL' 
   AND table_schema = 'Avalia - Estudo de Caso'; -- Nome do schema no banco de dados

-- Pensando nas métricas que serão criadas, os tipos de dados estão corretos no geral, mas a coluna IDADE está em VARCHAR (texto), fiz a alteração para possibilitar cálculos
ALTER TABLE "Avalia - Estudo de Caso"."ANALISE_GERAL"
ALTER COLUMN "IDADE" TYPE INTEGER
USING "IDADE"::INTEGER;


===============================================================================
-- [FASE 2] CRIAÇÃO DE COLUNAS/MÉTRICAS

-- 1. Coluna: Percentual de Acerto
-- Criada para explorar a quantidade de acertos dos estudantes em relação ao total, até então temos somente a faixa de proficiencia
ALTER TABLE "Avalia - Estudo de Caso"."ANALISE_GERAL"
ADD COLUMN "PORCENTAGEM_ACERTO" NUMERIC;

UPDATE "Avalia - Estudo de Caso"."ANALISE_GERAL"
-- Pela lógica do PostgreSQL, a ordem em que as operações são realizadas é importante. Logo, para evitar erros que desconsiderem casas decimais, primeiro multipliquei os ACERTOS por 100 e depois dividimos.
SET "PORCENTAGEM_ACERTO" = ("ACERTOS" * 100.0) / "TOTAL_QUESTOES";

----------------------------------------------------------------------------------
-- 2. Coluna: Status de Aproveitamento
-- Criada a partir das porcentagens de acertos. Cada intervalo de porcentagem representa um nível de desempenho, baseado em métricas de aprendizagem para o 1º ano EM
ALTER TABLE "Avalia - Estudo de Caso"."ANALISE_GERAL"
ADD COLUMN "STATUS_APROVEITAMENTO" VARCHAR(50);

UPDATE "Avalia - Estudo de Caso"."ANALISE_GERAL"
SET "STATUS_APROVEITAMENTO" = CASE -- utilizei o CASE para estabelecer os intervalos e os níveis de desempenho correspondentes
   WHEN "PORCENTAGEM_ACERTO" BETWEEN 0 AND 39.99 THEN 'Crítico' 
   WHEN "PORCENTAGEM_ACERTO" BETWEEN 40 AND 59.99 THEN 'Insuficiente'
   WHEN "PORCENTAGEM_ACERTO" BETWEEN 60 AND 79.99 THEN 'Bom'
   WHEN "PORCENTAGEM_ACERTO" >= 80 THEN 'Excelente'
   ELSE 'Não Avaliado'
END;

----------------------------------------------------------------------------------
-- 3. Coluna: ACERTOS_PROFICIENCIA
-- Criada para apontar inconsistências entre porcentagem de acerto e a proficiencia da avaliação. Identifica porcentagem baixa, proficiencia alta e vice-versa
ALTER TABLE "Avalia - Estudo de Caso"."ANALISE_GERAL"
ADD COLUMN "ACERTOS_PROFICIENCIA" VARCHAR(50);

UPDATE "Avalia - Estudo de Caso"."ANALISE_GERAL"
SET "ACERTOS_PROFICIENCIA" = CASE -- Aqui entra o '=' e o 'CASE'
  WHEN "PORCENTAGEM_ACERTO" >= 60 AND "ID_PROFICIENCIA" IN (1, 2) THEN 'Analisar Inconsistência'
  WHEN "PORCENTAGEM_ACERTO" <= 40 AND "ID_PROFICIENCIA" IN (3, 4) THEN 'Analisar Inconsistência'
  ELSE 'Resultado Coerente'
END;

----------------------------------------------------------------------------------
-- 4. Coluna: ALUNOS_EM_RISCO
-- Analisa se o estudante está fora da faixa etária adequada para o ano, ou sua proficiência na avaliação está baixa ou se o seu Status de Aproveitamento é crítico ou inconsistente
ALTER TABLE "Avalia - Estudo de Caso"."ANALISE_GERAL"
ADD COLUMN "ALUNOS_EM_RISCO" VARCHAR(50);

UPDATE "Avalia - Estudo de Caso"."ANALISE_GERAL"
SET "ALUNOS_EM_RISCO" =
   TRIM( -- Uso do TRIM para remover espaços extras no início/fim
       CASE WHEN "IDADE" >= 17 THEN 'Idade Alta; ' ELSE '' END ||
       CASE WHEN "ID_PROFICIENCIA" IN (1, 2) THEN 'Proficiência Baixa; ' ELSE '' END ||
       CASE WHEN "STATUS_APROVEITAMENTO" IN ('Crítico', 'Insuficiente') THEN 'Aproveitamento Baixo; ' ELSE '' END
   );

-- Caso o estudante não tenha nenhum indicador de risco o campo ficará vazio, para que isso não aconteça preencheremos o valor
UPDATE "Avalia - Estudo de Caso"."ANALISE_GERAL"
SET "ALUNOS_EM_RISCO" = 'Sem Risco'
WHERE "ALUNOS_EM_RISCO" = '';


-- Tabela ANALISE_GERAL pronta para visualização e criação de métricas no Power BI.