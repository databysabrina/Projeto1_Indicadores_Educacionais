/*
PROJETO: Indicadores Educacionais 
ETAPA: Criação de tabelas
OBJETIVO: Criação de novas tabelas, relacionando colunas para facilitar a exploração 
e modelagem dos dados
===============================================================================
Nota: Decidi criar as tabelas com as colunas que gostaria de explorar, antes de criar
as métricas. A ideia era fazer a criação desses cálculos com as tabelas limpas e organizadas.
*/

-- 1. Tabela ANALISE_GERAL
-- Criada a partir das tabelas AVALIA_DADOS_LIMPOS, ALUNOS_DADOS_LIMPOS e TURMAS, com o objetivo de criar métricas posteriormente como porcentagens de acertos ou colunas com alunos em risco
-- O enriquecimento de dados foi detalhado no arquivo "04_ANALISE_EXPLORATORIA.sql"

CREATE TABLE "Avalia - Estudo de Caso"."ANALISE_GERAL" AS
SELECT
   av."ID_ALUNO", -- O av se refere a tabela AVALIA, renomeada logo abaixo
   al."NOME" AS "NOME_ALUNO", -- O al se refere a tabela ALUNOS, o nome da coluna foi alterado para NOME_ALUNO
   al."IDADE",
   tu."NOME_TURMA", -- O tu se refere a tabela TURMAS
   tu."TURNO",
   av."ACERTOS",
   av."TOTAL_QUESTOES",
   av."PROFICIENCIA",
   av."ID_PROFICIENCIA"
FROM "Avalia - Estudo de Caso"."AVALIA_DADOS_LIMPOS" av -- renomeamos as tabelas a partir daqui para ficar mais resumido ao relacionar
-- Uso do LEFT JOIN para preservar os dados da tabela AVALIA_DADOS_LIMPOS, mesmo que algum não existam correspondências nas outras tabelas
LEFT JOIN "Avalia - Estudo de Caso"."ALUNOS_DADOS_LIMPOS" al ON av."ID_ALUNO" = al."ID_ALUNO" 
LEFT JOIN "Avalia - Estudo de Caso"."TURMAS" tu ON av."ID_TURMA" = tu."ID_TURMA";

-------------------------------------------------------------------------------------
-- 2. Tabela ANALISE_TURMAS
-- Criada a partir da tabela ANALISE_GERAL e da tabela TURMAS, para criar comparações resumidas entre as diferentes turmas 
-- O enriquecimento de dados foi detalhado no arquivo "04_ANALISE_EXPLORATORIA.sql"
CREATE TABLE "Avalia - Estudo de Caso"."ANALISE_TURMAS" AS
SELECT
   tu."ID_TURMA", -- O tu se refere a planilha TURMAS, renomeada logo abaixo
   an."NOME_TURMA", -- o an se refere a planilha ANALISE_GERAL
   an."TURNO",
   COUNT(an."ID_ALUNO") AS "TOTAL_ALUNOS"
FROM "Avalia - Estudo de Caso"."ANALISE_GERAL" an
LEFT JOIN "Avalia - Estudo de Caso"."TURMAS" tu ON an."NOME_TURMA" = tu."NOME_TURMA"
GROUP BY tu."ID_TURMA", an."NOME_TURMA", an."TURNO";

-- Tabelas ANALISE_GERAL e ANALISE_TURMAS prontas para a analise explroatória e para o enriquecimento de dados.