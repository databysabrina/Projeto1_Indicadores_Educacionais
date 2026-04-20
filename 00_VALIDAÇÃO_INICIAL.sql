/*
PROJETO: Indicadores Educacionais 
ETAPA: Verificação de Integridade 
OBJETIVO: Validar se os dados estão prontos para criação de métricas e relacionamentos
no Power BI

===============================================================================
TABELA: TURMAS
===============================================================================
Nota: Devido ao volume reduzido (4 linhas), a inspeção visual foi complementada 
com queries de integridade para garantir que a tabela esteja limpa.
*/

-- 1. Teste de Unicidade (Para garantir que cada turma seja única)
SELECT 
    "ID_TURMA" , 
    COUNT(*) as repeticoes
FROM "Avalia - Estudo de Caso"."TURMAS"
GROUP BY "ID_TURMA"
HAVING COUNT(*) > 1;

-- 2. Teste de Nulidade (Para garantir que não existam campos essenciais vazios)
SELECT * 
FROM "Avalia - Estudo de Caso"."TURMAS"
WHERE "ID_TURMA"  IS NULL 
   OR "NOME_TURMA"  IS NULL;

-- 3. Teste de Consistência de Domínio
-- Para verificar se o turno não possui valores fora do padrão (Ex: 'Noite' quando só deveria haver Manhã/Tarde)
SELECT DISTINCT "TURNO" 
FROM "Avalia - Estudo de Caso"."TURMAS";

/* CONCLUSÃO: 
Nenhuma inconsistência detectada. 
Tabela Turmas pronta para criação de novas métricas e relacionamentos no Power BI.

===============================================================================
TABELA: PROFICIENCIA 
===============================================================================
Nota: Esta também apresenta volume reduzido, então utilizei as mesmas queries de integridade 
da tabela anterior para garantir que esteja limpa.
*/

-- 1. Teste de Unicidade (Para garantir que cada proficiencia seja única)
SELECT 
    "ID_PROFICIENCIA", 
    COUNT(*) as repeticoes
FROM "Avalia - Estudo de Caso"."PROFICIENCIA"
GROUP BY "ID_PROFICIENCIA"
HAVING COUNT(*) > 1;

-- 2. Teste de Nulidade (Para garantir que não existam campos essenciais vazios)
SELECT * 
FROM "Avalia - Estudo de Caso"."PROFICIENCIA"
WHERE "ID_PROFICIENCIA"  IS NULL 
   OR "NÍVEL_ORDEM"  IS NULL;

-- 3. Teste de Consistência de Domínio
-- Para verificar se a faixa de proficiência tem valores fora do esperado, entre Abaixo do Básico e Avançado
SELECT DISTINCT "FAIXA_DE_PROFICIENCIA" 
FROM "Avalia - Estudo de Caso"."PROFICIENCIA";

/* CONCLUSÃO: 
Nenhuma inconsistência detectada. Tabela Proficiencia pronta para criação de novas métricas e relacionamentos no Power BI.
*/

