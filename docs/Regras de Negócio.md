## 📄 Regras de Negócio e Definições Métricas

### 1. Definição da População e Faixa Etária
Para garantir que a análise reflita a realidade do ensino médio, foram aplicadas as seguintes premissas:
* **Público-alvo:** Estudantes regularmente matriculados no 1º ano que realizaram a Avaliação Externa.
    * *Ação Técnica:* IDs de alunos não compatíveis com a planilha de resultados da Avaliação foram desconsiderados na análise.
* **Regra de Idade:** A faixa etária padrão foi definida entre **14 e 17 anos**.
    * *Ação Técnica:* Alunos identificados fora dessa faixa foram tratados como inconsistências de cadastro e ajustados para a idade média da turma após validação.

### 2. Avaliação Externa e Proficiência
A análise baseia-se nos resultados da Avaliação Externa, onde a métrica central é a "Faixa de Proficiência".
* **Proficiência:** Pontuação numérica calculada sobre peso de questões, tempo de prova, dentre outros critérios.
    * *Ação Técnica:* Notas registradas como texto ou com separadores inconsistentes no banco original foram normalizadas para o tipo NUMERIC para garantir a  precisão dos cálculos de média.
* **Escala de Proficiência:** Foram utilizados 4 faixas padronizadas a depender da pontuação de "Proficiencia" atingida,  cada uma representando um nível de 1 a 4 (1-Abaixo do Básico, 2-Básico, 3-Adequado e 4-Avançado).
* **Tratamento de Notas (Score):** O número de acertos brutos em conjunto com a coluna de total de questões permitiu a criação da "Porcentagem de Acertos".

### 3. Critérios de Proficiência e Aproveitamento
O "Status de Aproveitamento" é uma métrica qualitativa derivada do desempenho quantitativo do estudante. Este indicador não se limita à contagem de acertos, mas classifica o nível de domínio do conteúdo. Um status elevado reflete maior consistência nas respostas, sugerindo que o estudante possui segurança teórica e menor probabilidade de acerto por casualidade (chute), consolidando uma correlação entre o volume de acertos e a efetiva construção do conhecimento.
* **Cálculo da Porcentagem de Acerto:** $\frac{\text{Acertos} \times 100}{\text{Total de Questões}}$
* **Classificação de Status de Aproveitamento:** 
    * **Crítico:** Aproveitamento abaixo de 40%.
    * **Insuficiente:** Aproveitamento entre 40% e 59%.
    * **Bom:** Aproveitamento entre 60% e 79%.
    * **Excelente:** Aproveitamento igual ou superior a 80%.
* **Nota:** A classificação do "Status de Aproveitamento" foi estabelecida a partir da taxa de acertos, correlacionada às competências pedagógicas previstas na avaliação.

### 4. Matriz de Coerência (Auditoria de Dados)
Para garantir a confiabilidade dos dados, foi estabelecida uma regra de **Cruzamento de Inconsistência** entre a nota objetiva (baseada nos Acertos) e a classificação de proficiência da avaliação externa (baseada no ID_Proficiencia):
* **Premissa:** Um aluno com alto percentual de acertos não deve estar classificado em níveis iniciais de proficiência, e vice-versa.
* **Flag de Inconsistência:** Criou-se a coluna "Acertos x Proficiência para sinalizar registros onde a nota objetiva divergia do nível atribuído, servindo como uma camada de auditoria de dados para a gestão escolar. Quando há Risco de Dados, a linha é sinalizada como "Analisar Inconsistência".
    * *Inconsistência Tipo A:* Estudante com alto acerto ($\geq$ 60%) mas com "ID_Proficiência" baixo (1 ou 2).
    * *Inconsistência Tipo B:* Estudante com baixo acerto ($\leq$ 40%) mas com "ID_Proficiencia" alto (3 ou 4).

### 5. Definição de "Alunos em Risco" (Métrica Composta)
O conceito de "Risco" neste projeto é multidimensional, não se limitando apenas a notas baixas. Um registro é sinalizado como "Em Risco" se atender a qualquer um destes critérios:
* **Risco de Engajamento:** Proficiência classificada nos níveis 1 ou 2 (Abaixo do Básico/Básico).
* **Risco de Aprendizagem:** Aproveitamento com status "Crítico" ou "Insuficiente".
* **Risco Etário:** Estudante com 17 anos ou mais (risco de evasão/distorção idade-série).
* **Sem Risco:** Quando nenhum dos critérios é contemplado.

### 6. Lógica de Ranking de Turmas
Para comparar a performance entre as turmas (1A, 1B, 1C e 1D), o ranking foi estabelecido com base na **Média de Acertos**.
* *Mecânica:* Utilizou-se da função `RANK()` no SQL para ordenar as turmas de forma que a maior média ocupa a 1ª posição.

### 7. Considerações de Saída e Visualização
A aplicação rigorosa das premissas descritas neste documento garantiu que a base de dados fosse exportada com alto nível de integridade. As métricas foram modeladas para permitir que o Dashboard atenda aos seguintes requisitos de negócio:

* **Identificação Imediata:** Visualização clara de alunos que necessitam de intervenção pedagógica através da métrica de "Risco".
* **Comparabilidade:** Análise justa entre turmas utilizando médias (de acertos e proficiência) e rankings.
* **Auditoria:** Possibilidade de rastrear inconsistências entre a Avaliação Externa e o aproveitamento dos estudantes.

### 8. Ferramentas e Validação
* **Processamento:** SQL (PostgreSQL) para limpeza, padronização e aplicação de regras de negócio.
* **Cálculos:** DAX (Power BI) para cálculos de medidas dinâmicas e indicadores de performance.
* **Visualização:** Layout personalizado (Canva/Power BI) focado em usabilidade e contraste, utilizando cores semafóricas para facilitar a leitura rápida dos níveis de proficiência.

[⬅️ Voltar para o README Principal](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/main/README.md)
