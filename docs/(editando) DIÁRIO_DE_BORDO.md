# 📓 Diário do Projeto: Indicadores de Desempenho Educacional

#### 📅 Etapa 1: Entendimento do Desafio e Definição de Escopo
* **Objetivo Inicial:** Transformar dados brutos de avaliações externas em informações acionáveis para a gestão escolar.
* **Problema:** Existiam inconsistências de diferentes dados e divergências entre o número de acertos e o nível de proficiência atribuído.
* **Solução:** Estabeleceu-se uma população-alvo de estudantes do 1º ano do Ensino Médio, com idade entre 14 e 17 anos, para garantir uma análise realista.

#### 📅 Etapa 2: Limpeza e Modelagem de Dados (ETL)
Nesta fase, o foco foi a integridade técnica. Utilizou-se SQL (PostgreSQL) para aplicar as regras de ouro:
* **Normalização:** Notas registradas como texto foram convertidas para NUMERIC para precisão de cálculo.
* **Tratamento de Inconsistências:** Alunos fora da faixa etária tiveram suas idades ajustadas pela média da turma após validação.
* **Arquitetura:** Os dados foram organizados em um esquema de tabelas dimensões e fato (Avalia), facilitando o relacionamento e a performance.

#### 📅 Etapa 3: Desenvolvimento de Métricas de Inteligência
* **Matriz de Coerência:** Criou-se uma regra de auditoria para flagar alunos com alto acerto e baixa proficiência (e vice-versa), garantindo a confiabilidade da avaliação.
* **Status de Aproveitamento:** Implementou-se uma classificação qualitativa (Crítico a Excelente) baseada no percentual de acertos.
* **Identificador de Risco:** Desenvolveu-se uma métrica composta para sinalizar alunos em risco de evasão ou de aprendizagem.

#### 📅 Etapa 4: Visualização de Dados e UX (Power BI & Canva)
* **Hierarquia Visual:** Utilizou-se cores semafóricas (roxo, amarelo, azul) para distinguir rapidamente as faixas de proficiência.
* **Comparabilidade:** Criou-se um ranking de turmas baseado na média de proficiência para gerar insights competitivos saudáveis.

#### Conclusão e Resultados Obtidos
O projeto resultou em um ambiente de dados auditado e transparente.
* **Impacto:** A gestão agora consegue identificar precisamente quais alunos precisam de intervenção imediata através da métrica de "Alunos em Risco".
* **Ferramentas:** O ciclo foi fechado integrando SQL para o pesado, DAX para a inteligência e Power BI para a entrega final.


* No GitHub, você pode colocar esse Journal no seu README.md principal sob o título "Como este projeto foi construído".
* Isso "vende" a sua capacidade analítica antes mesmo do recrutador abrir o dashboard!
* Dica: No GitHub, você pode usar os nomes dos seus arquivos SQL como links dentro do texto.
* Exemplo: ...identifiquei duplicatas [veja o script 01_LIMPEZA_ALUNOS.sql]. Isso incentiva o recrutador a olhar o seu código!
