# 📖 Dicionário de Dados
Este documento detalha a estrutura das tabelas, tipos de dados e as definições aplicadas a cada atributo do projeto. O objetivo é fornecer uma visão técnica clara sobre a origem e o significado de cada campo utilizado no Dashboard.


## 📍 Sumário
- [Convenção de Tipagem](#convenção-de-tipagem-utilizada-nesta-documentação)
- [Tabelas Dimensão](#tabelas-originais)
- [Tabela Fato](#tabela-fato-avalia)
- [Métricas Analíticas](#novas-métricas)


## Convenção de Tipagem utilizada nesta documentação:
* **`Int4`:** Campos destinados a chaves primárias ou valores numéricos sem casas decimais (como quantidade de acertos ou idade).
* **`Varchar(50)`:** Campos de texto alfanumérico limitados, ideais para nomes de turmas, nomes de alunos ou classificações (como "Básico", "Adequado"), garantindo a economia de armazenamento no banco.
* **`Numeric`:** Escolhido para campos de cálculo (como a Proficiência ou a Porcentagem de Acerto) por permitir casas decimais e garantir que não haja perda de precisão em operações matemáticas.

## Tabelas Originais
---

#### Tabela Dimensão: Turmas
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| 🔑 ID_TURMA |`Varchar(50)`| Chave primária da turma | Única por turma. Utilizada para relacionamento (JOIN). |
| NOME_TURMA |`Varchar(50)`| Referência nominal da turma | Ex: Ailton Krenak, Lélia Gonzalez. |
| SÉRIE |`Varchar(50)`| Nível de Escolaridade | Domínio fixo: "1º Ano EM". |
| TURNO |`Varchar(50)`| Período em que frequentam as aulas | Manhã (1A, 1B) e Tarde (1C, 1D). |

---

#### Tabela Dimensão: Alunos
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| 🔑 ID_ALUNO |`Int4`| Chave primária do aluno | Identificador único. Utilizado para garantir a integridade referencial com a planilha de resultados. |
| NOME |`Varchar(50)`| Nome completo cadastrado | Campo normalizado para evitar duplicidade; cada registro representa um estudante único. |
| IDADE |`Int4`| Idade cronológica validada | Faixa padrão entre 14 e 17 anos. Valores fora deste intervalo foram ajustados pela média da turma após validação de inconsistência. |

---

#### Tabela Dimensão: Proficiencia
> [!NOTE]
> A Proficiencia nas próximas tabelas se refere ao domínio dos estudantes na disciplina de matemática, em uma avaliação externa. A classificação considera pontuações de diferentes questões, tempo de prova, dentre outros critérios.

| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| 🔑 ID_PROFICIENCIA |`Int4`| Chave primária do nível | Identificador único utilizado para o relacionamento com a tabela fato AVALIA. |
| FAIXA_DE_PROFICIENCIA |`Varchar(50)`| Nome da categoria de desempenho | Domínio: Abaixo do Básico, Básico, Adequado e Avançado. |
| NÍVEL_ORDEM |`Int4`| Indexador hierárquico | Define a ordem lógica de desempenho (1 a 4). Essencial para a ordenação correta de eixos e legendas no Power BI. |
| DESCRIÇÃO |`Varchar(50)`| Detalhamento pedagógico do nível |Explicação qualitativa sobre quais competências e habilidades o estudante demonstra em cada faixa. |

---

#### Tabela Fato: Avalia
> [!NOTE]
> Centraliza os resultados individuais. Devido à metodologia da avaliação (pesos diferentes por questão), alunos com o mesmo ID_PROFICIENCIA podem apresentar pontuações de PROFICIENCIA distintas.

| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| 🔗 ID_ALUNO |`Int4`| Chave Estrangeira | Relaciona o resultado ao estudante específico na dimensão Alunos. |
| 🔗 ID_TURMA |`Varchar(50)`| Chave Estrangeira | Relaciona o resultado à turma correspondente na dimensão Turmas. |
| 📐 ACERTOS |`Int4`| Qtd de itens respondidos corretamente | Valor absoluto de acertos. Intervalo de 0 a 32. |
| TOTAL_QUESTOES |`Int4`| Escopo da avaliação externa | Total de itens aplicados (Padrão: 32). Base para o cálculo de porcentagem. |
| 📐 PROFICIENCIA |`Numeric`| Score de cada aluno | Pontuação numérica da Avaliação Externa baseada na Teoria de Resposta ao Item (TRI) ou critérios metodológicos desconhecidos. |
| 🔗 ID_PROFICIENCIA |`Int4`| Chave Estrangeira | Relaciona a pontuação à sua categoria na dimensão Proficiencia (Nível 1 a 4).|

---

## Novas Métricas
#### Tabela: Analise Geral
> [!NOTE]
> Esta tabela consolidada foi estruturada para centralizar a visão analítica do projeto. As informações sobre Alunos e Turmas mantêm os mesmos padrões já apresentados nas seções anteriores. O foco aqui recai sobre as novas métricas desenvolvidas para este estudo, como os indicadores de risco e aproveitamento.

| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| 📐 PORCENTAGEM_ACERTO |`Numeric`| Índice de rendimento objetivo. | Cálculo:  $$\frac{\text{Acertos} \times 100}{\text{Total de Questões}}$$. Representa o aproveitamento bruto do estudante. |
| STATUS_APROVEITAMENTO|`Varchar(50)`| Classificação qualitativa de rendimento | Domínio: Crítico, Insuficiente, Bom e Excelente. Baseado em faixas percentuais de acerto. |
| ACERTOS_PROFICIENCIA|`Varchar(50)`| Indicador de Matriz de Coerência. | Sinaliza inconsistências entre o volume de acertos e o nível de proficiência atribuído (Ex: "Analisar Inconsistência"). |
| ALUNOS_EM_RISCO |`Varchar(50)`| Identificador de alerta pedagógico | Métrica Composta: Sinaliza "Em Risco" alunos com baixa proficiência, aproveitamento insuficiente ou distorção idade-série. |

---

#### Tabela: Analise Turmas
> [!NOTE]
> Esta tabela centraliza os indicadores de performance por grupo para facilitar a comparação entre as turmas. As informações de ID_TURMA, NOME_TURMA e TURNO mantêm as definições já apresentadas na tabela de dimensões correspondente.

| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| TOTAL_ALUNOS |`Int4`| Contagem total de estudantes. | Representa o volume de alunos matriculados e avaliados por turma.|
| 📐 MEDIA_ACERTO |`Numeric`| Desempenho médio de acertos. | Média aritmética simples dos acertos brutos dos alunos da turma. |
| 📐 MEDIA_PROFICIENCIA |`Numeric`| Score médio de proficiência.| Média das pontuações de proficiência; utilizada como base para o ranking pedagógico. |
| 📐 RANKING_TURMA |`Int4`| Posição competitiva da turma. | Lógica de Ranking: Calculado via função RANK() no SQL, onde a maior média de proficiência ocupa a 1ª posição. |


[⬅️ Voltar para o README Principal](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/main/README.md)
