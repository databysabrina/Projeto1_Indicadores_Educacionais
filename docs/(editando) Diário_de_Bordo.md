# 📓 Diário do Projeto: Indicadores de Desempenho Educacional

#### 📅 Etapa 1: Entendimento do Desafio e Definição de Escopo
* **Objetivo Inicial:** Transformar dados brutos de avaliações externas em informações acionáveis para a gestão escolar. Antes de qualquer limpeza, realizei um Diagnóstico de Integridade via SQL.
* **Validação de Unicidade:** Utilizei 'GROUP BY' e 'HAVING COUNT(*) > 1' para identificar duplicatas nas diferentes tabelas.
* **Mapeamento de Nulos:** Através do 'COALESCE' e filtros de 'IS NULL', identifiquei campos críticos vazios em colunas como 'ID_TURMA' e 'TOTAL_QUESTOES'.
* *Resultado do Diagnóstico:* Existiam inconsistências de diferentes dados e divergências entre o número de acertos e o nível de proficiência atribuído.
> [!NOTE]
> Veja os detalhes no script 01_LIMPEZA_ALUNOS.sql
> 

#### 📅 Etapa 2: Limpeza e Modelagem de Dados (ETL)
Nesta fase, o foco foi a integridade técnica. Utilizou-se SQL (PostgreSQL) para aplicar as regras de ouro, dividindo em scripts modulares para garantir a rastreabilidade:
* **Normalização:** Notas originalmente em 'VARCHAR' foram convertidas para 'NUMERIC' via 'ALTER COLUMN' com 'USING::integer/numeric', permitindo cálculos de média com precisão decimal.
* **Tratamento de Inconsistências:** Implementei lógicas de 'CASE WHEN' para filtrar idades fora da faixa escolar (14-17 anos) e corrigi erros de digitação em IDs.
* **Deduplicação:** Criei tabelas de "Dados Limpos" utilizando 'SELECT DISTINCT' para isolar registros únicos após o saneamento.

#### 📅 Etapa 3: Arquitetura e Modelagem Estrela
* **Arquitetura:** Os dados foram organizados em um esquema de tabelas dimensões e fato (Avalia), facilitando o relacionamento e a performance.
* **Relacionamentos:** Utilizei 'LEFT JOIN' para conectar a tabela fato 'AVALIA' com as dimensões 'ALUNOS' e 'TURMAS', garantindo que nenhum resultado de avaliação fosse perdido mesmo em casos de inconsistência cadastral.
* *Tabelas Analíticas:* Desenvolvi as tabelas 'ANALISE_GERAL' e 'ANALISE_TURMAS' via SQL para centralizar métricas complexas e reduzir o esforço de processamento do Dashboard.
  
#### 📅 Etapa 4: Desenvolvimento de Métricas de Inteligência
* **Matriz de Coerência:** Foi criada uma métrica 'ACERTOS_PROFICIENCIA' usando lógicas condicionais para flagar alunos com alto acerto e baixa proficiência (e vice-versa), garantindo a confiabilidade da avaliação.
* **Status de Aproveitamento:** Implementou-se uma classificação qualitativa (Crítico a Excelente) baseada no percentual de acertos.
* **Identificador de Risco:** Utilizei a função 'TRIM' e concatenação de strings para criar um status detalhado de risco, unindo critérios de idade, aproveitamento e proficiência.
* **Ranking de Performance:** Apliquei a Window Function 'RANK() OVER (ORDER BY MEDIA_ACERTO DESC)' para gerar um ranking dinâmico entre as turmas.

#### 📅 Etapa 5: Visualização de Dados e UX (Power BI & Canva)
* **Hierarquia Visual:** Utilizou-se cores semafóricas (roxo, amarelo, azul) para distinguir rapidamente as faixas de proficiência.
* **Comparabilidade:** Criou-se um ranking de turmas baseado na média de proficiência para gerar insights competitivos, mas para fins pedagógicos.

#### 📅 Etapa 6:Conclusão e Resultados Obtidos
O projeto resultou em um ambiente de dados auditado e transparente.
* **Impacto:** A gestão agora possui uma ferramenta de auditoria que aponta inconsistências e alunos que precisam de atenção imediata.
* **Ferramentas:** O ciclo foi fechado integrando SQL limpeza, processamento e cálculos, DAX criação de métricas adicionais e Power BI para a visualização dos dados.


* No GitHub, você pode colocar esse Journal no seu README.md principal sob o título "Como este projeto foi construído".
* Isso "vende" a sua capacidade analítica antes mesmo do recrutador abrir o dashboard!
* Dica: No GitHub, você pode usar os nomes dos seus arquivos SQL como links dentro do texto.
* Exemplo: ...identifiquei duplicatas [veja o script 01_LIMPEZA_ALUNOS.sql]. Isso incentiva o recrutador a olhar o seu código!
