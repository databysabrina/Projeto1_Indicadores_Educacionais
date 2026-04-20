# 📊 Dashboard de Performance Educacional: Análise de Indicadores
<img width="1643" height="942" alt="image" src="https://github.com/user-attachments/assets/10171de3-f48b-495c-9c9c-4a66e4f55460" />

---

Este projeto apresenta uma solução completa de **Análise de Dados** aplicada ao setor educacional. O foco central foi transformar dados brutos de avaliações externas em indicadores estratégicos (KPIs), permitindo que gestores identifiquem rapidamente alunos em situação de risco e comparem o desempenho entre turmas através de dados auditados e saneados.

---

## 📂 Organização do Repositório

O repositório está organizado de forma modular para refletir um fluxo de trabalho profissional de dados:

* **[`/assets`](./assets):** Identidade visual, layouts desenvolvidos no Canva e vídeo demonstrativo.
* **[`/dados`](./dados):** Amostras dos dados originais e tabelas resultantes (`Analise Geral` e `Analise Turmas`).
* **[`/docs`](./docs):** Documentação consultiva do projeto contendo premissas lógicas e técnicas de cada campo, além das fases de desenvolvimento.
* **[`/scripts_SQL`](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/tree/968955fe175ea88eb8fc1d93335bee9b30dcb565/scripts%20SQL):** Scripts de dados construído em SQL (PostgreSQL).
    * `00_VALIDAÇÃO_INICIAL.sql` até `05_EXPLORAÇÃO_ANALISE_TURMAS.sql`.
* **[`/power_bi`](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/tree/968955fe175ea88eb8fc1d93335bee9b30dcb565/power%20bi):** Arquivo fonte `.pbix` e versão em PDF do relatório.


---

## 🔗 Links Rápidos
* [📖 Ler o Dicionário de Dados](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/5f6b39ae002180b5fdd95474b9eee029905d1657/docs/Dicion%C3%A1rio%20de%20Dados.md)
* [📓 Ver o Diário de Bordo (Passo a passo)](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/537f36bce0351409de44bdd091c90431469e1965/docs/Di%C3%A1rio%20de%20Bordo.md)
* [📑 Entender as Regras de Negócio](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/eb660e00c92e356b46d47d933395d6f06c881bd7/docs/Regras%20de%20Neg%C3%B3cio.md)

---

## 🛠️ Jornada Técnica (Flow do Projeto)

### 1. Saneamento e Engenharia de Dados (SQL)
A base bruta apresentava desafios comuns de qualidade de dados. Utilizei SQL para garantir a confiabilidade da análise:
* **Diagnóstico de Integridade:** Mapeamento de duplicatas e valores nulos com `GROUP BY`, `HAVING` e `COALESCE`.
* **Saneamento de Dados:** Tratamento de idades inconsistentes e normalização de nomes e IDs.
* **Tipagem Dinâmica:** Conversão de strings para `NUMERIC` e `INTEGER` para viabilizar cálculos matemáticos precisos.
* **Modelagem Star Schema:** Estruturação de Tabelas Dimensão e Fato, otimizando o processamento para o Power BI.

### 2. Engenharia de Atributos e Métricas (📐)
Fui além dos dados básicos, criando camadas de inteligência para o negócio:
* **Matriz de Coerência:** Regra criada para identificar inconsistências entre o volume de acertos e o score de proficiência.
* **Alerta de Risco Composto:** Métrica que sinaliza alunos com distorção idade-série ou desempenho crítico.
* **Ranking de Performance:** Uso de *Window Functions* (`RANK()`) para classificar o desempenho das turmas de forma automatizada.

### 3. Visualização e UX (Power BI)
O design foi planejado para ser funcional e direto:
* **UX Design:** Interface customizada via Canva para evitar poluição visual.
* **Destaque Semafórico:** Uso de cores estratégicas para guiar o olhar do gestor para os pontos de atenção (Níveis Abaixo do Básico e Básico).

### 4. Uso Estratégico de IA (Copiloto)
A Inteligência Artificial foi integrada ao fluxo de trabalho como ferramenta de suporte e produtividade:
* **Refino Técnico:** Auxílio na revisão de scripts SQL e sugestões de tratamento seguindo boas práticas.
* **Documentação:** Estruturação técnica do Dicionário de Dados e tradução de conceitos complexos para uma linguagem acessível.
* **Aprendizado:** Uso da ferramenta para explorar novas possibilidades de cálculos e intergração de SQL e Power BI.

---

## 📈 Principais Insights e Valor de Negócio
* **Identificação de Alunos em Risco:** Cruzamento de dados que permite intervenção pedagógica preventiva.
* **Auditoria Pedagógica:** A Matriz de Coerência ajuda a identificar se os resultados da avaliação externa condizem com o histórico do aluno.
* **Benchmarking de Turmas:** Comparação clara de médias e rankings para compartilhamento de boas práticas entre professores.

---

*Projeto desenvolvido para fins de portfólio em análise e engenharia de dados.*

---

## 👤 Autora
**Sabrina da Silva** 

*Conecte-se comigo!* 

[![LinkedIn](https://img.shields.io/badge/-LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/sabrina-da-silva-b4b333172)
[![E-mail](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:contact.sabrinads@gmail.com)



