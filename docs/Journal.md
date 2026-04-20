# 📓 Diário do Projeto: Indicadores de Desempenho Educacional

#### 📅 Etapa 1: Entendimento do Desafio e Definição de Escopo
* **Objetivo Inicial:** Transformar dados brutos de avaliações externas em informações acionáveis para a gestão escolar. Antes de qualquer limpeza, realizei um Diagnóstico de Integridade via SQL.
* **Validação de Unicidade:** Utilizei 'GROUP BY' e 'HAVING COUNT(*) > 1' para identificar duplicatas nas diferentes tabelas.
* **Mapeamento de Nulos:** Através do 'COALESCE' e filtros de 'IS NULL', identifiquei campos críticos vazios em colunas como 'ID_TURMA' e 'TOTAL_QUESTOES'.
* *Resultado do Diagnóstico:* Existiam inconsistências de diferentes dados e divergências entre o número de acertos e o nível de proficiência atribuído.
> [!NOTE]
> Veja mais detalhes sobre os **diagnósticos iniciais** nos seguintes scripts:
> * Tabelas Turmas e Proficiencia: [00_VALIDAÇÃO_INICIAL.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/28b4a74631bb00c445c0c981331ea70d5227fd99/scripts%20SQL/00_VALIDA%C3%87%C3%83O_INICIAL.sql)
> * Tabela Alunos: [01_LIMPEZA_ALUNOS.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/e7456a8497daed56ab0be8dc4e86d3972f11fb8e/scripts%20SQL/01_LIMPEZA_ALUNOS.sql)
> * Tabela Avalia: [02_LIMPEZA_AVALIA.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/9e53e8f507940aedce6f25a110ce1040c1d9196d/scripts%20SQL/02_LIMPEZA_AVALIA.sql)  
>


#### 📅 Etapa 2: Limpeza e Tratamento de Dados (ETL)
Nesta fase, o foco foi a integridade técnica. Utilizou-se SQL (PostgreSQL) para aplicar as regras de ouro, dividindo em scripts modulares para garantir a rastreabilidade:
* **Normalização:** Notas originalmente em 'VARCHAR' foram convertidas para 'NUMERIC' via 'ALTER COLUMN' com 'USING::integer/numeric', permitindo cálculos de média com precisão decimal.
* **Tratamento de Inconsistências:** Implementei lógicas de 'CASE WHEN' para filtrar idades fora da faixa escolar (14-17 anos) e corrigi erros de digitação em IDs.
* **Deduplicação:** Criei tabelas de "Dados Limpos" utilizando 'SELECT DISTINCT' para isolar registros únicos após o saneamento.
> [!NOTE]
> Veja mais detalhes da **limpeza e do tratamento** das tabelas nos seguintes scripts:
> * Tabela Alunos: [01_LIMPEZA_ALUNOS.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/e7456a8497daed56ab0be8dc4e86d3972f11fb8e/scripts%20SQL/01_LIMPEZA_ALUNOS.sql)
> * Tabela Avalia: [02_LIMPEZA_AVALIA.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/9e53e8f507940aedce6f25a110ce1040c1d9196d/scripts%20SQL/02_LIMPEZA_AVALIA.sql)  
>


#### 📅 Etapa 3: Arquitetura e Modelagem Estrela
* **Arquitetura:** Os dados foram organizados em um esquema de tabelas dimensões e fato (Avalia), facilitando o relacionamento e a performance.
* **Relacionamentos:** Utilizei 'LEFT JOIN' para conectar a tabela fato 'AVALIA' com as dimensões 'ALUNOS' e 'TURMAS', garantindo que nenhum resultado de avaliação fosse perdido mesmo em casos de inconsistência cadastral.
* *Tabelas Analíticas:* Desenvolvi as tabelas 'ANALISE_GERAL' e 'ANALISE_TURMAS' via SQL para centralizar métricas complexas e reduzir o esforço de processamento do Dashboard.
> [!NOTE]
> Veja mais detalhes da **modelagem e da criação de tabelas** no seguinte script: [03_NOVAS_TABELAS.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/f7218b69d376d1c6925453dc4a2e53fbd4f601b9/scripts%20SQL/03_NOVAS_TABELAS.sql)


#### 📅 Etapa 4: Desenvolvimento de Métricas de Inteligência
* **Matriz de Coerência:** Foi criada uma métrica 'ACERTOS_PROFICIENCIA' usando lógicas condicionais para flagar alunos com alto acerto e baixa proficiência (e vice-versa), garantindo a confiabilidade da avaliação.
* **Status de Aproveitamento:** Implementou-se uma classificação qualitativa (Crítico a Excelente) baseada no percentual de acertos.
* **Identificador de Risco:** Utilizei a função 'TRIM' e concatenação de strings para criar um status detalhado de risco, unindo critérios de idade, aproveitamento e proficiência.
* **Ranking de Performance:** Apliquei a Window Function 'RANK() OVER (ORDER BY MEDIA_ACERTO DESC)' para gerar um ranking dinâmico entre as turmas.
> [!NOTE]
> Veja mais detalhes do **desenvolvimento de métricas** nos seguintes scripts:
> * Tabela Analise Geral: [04_EXPLORAÇÃO_ANALISE_GERAL.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/27fb5a59fee354a597d77b5ae86f56b593ff8b01/scripts%20SQL/04_EXPLORA%C3%87%C3%83O_ANALISE_GERAL.sql)
> * Tabela Analise Turmas: [05_EXPLORAÇÃO_ANALISE_TURMAS.sql](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/4e31982c305d3b805723afea0748d00ef8c54947/scripts%20SQL/05_EXPLORA%C3%87%C3%83O_ANALISE_TURMAS.sql)  
>

#### 📅 Etapa 5: Visualização de Dados e UX (Power BI & Canva)
* **Hierarquia Visual:** Utilizou-se cores semafóricas (roxo, amarelo, azul) para distinguir rapidamente as faixas de proficiência.
* **Comparabilidade:** Criou-se um ranking de turmas baseado na média de proficiência para gerar insights competitivos, mas para fins pedagógicos.
> [!NOTE]
> Veja mais detalhes da visualização nos arquivos das seguintes pastas:
> * [Assets](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/tree/38a57f2c3608db330256314daa9e8bcb50a7830f/assets)
> * [Power BI](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/tree/d1f49f951a1587baa6e8619946d75e00c543649c/power%20bi)
>

#### 📅 Etapa 6:Conclusão e Resultados Obtidos
O projeto resultou em um ambiente de dados auditado e transparente.
* **Impacto:** A gestão agora possui uma ferramenta de auditoria que aponta inconsistências e alunos que precisam de atenção imediata.
* **Ferramentas:** O ciclo foi fechado integrando SQL limpeza, processamento e cálculos, DAX criação de métricas adicionais e Power BI para a visualização dos dados.

[⬅️ Voltar para o README Principal](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/main/README.md)


