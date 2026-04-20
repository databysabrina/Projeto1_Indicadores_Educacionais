# 📊 Dashboard de Performance Educacional: Análise de Proficiência
<img width="1643" height="942" alt="image" src="https://github.com/user-attachments/assets/10171de3-f48b-495c-9c9c-4a66e4f55460" />

---

Este projeto apresenta uma solução completa de **Análise de Dados** aplicada ao setor educacional. O foco central foi transformar dados brutos de avaliações externas em indicadores estratégicos (KPIs), permitindo que gestores identifiquem rapidamente alunos em situação de risco e comparem o desempenho entre turmas através de dados auditados e saneados.

---

## 📂 Organização do Repositório

O repositório está organizado de forma modular para refletir um fluxo de trabalho profissional de dados:

* **[`/assets`](./assets):** Identidade visual, layouts desenvolvidos no Canva e vídeo demonstrativo.
* **[`/dados`](./dados):** Amostras dos dados originais e tabelas resultantes (`Analise Geral` e `Analise Turmas`).
* **[`/docs`](./docs):** Documentação consultiva do projeto.
    * [Dicionário de Dados](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/0fbf8cacd97ae9d0a1208bd8bc2baaa81c9f63c2/docs/Dicion%C3%A1rio%20de%20Dados.md): Premissas e lógicas aplicadas.
    * [Regras de Negócio](https://github.com/databysabrina/Projeto_Indicadores_Educacionais/blob/eb660e00c92e356b46d47d933395d6f06c881bd7/docs/Regras%20de%20Neg%C3%B3cio.md): Definição técnica de cada campo.
    * [Journal do Projeto](./docs/JOURNAL.md): O diário de bordo com as fases de desenvolvimento.
* **[`/scripts_SQL`](./scripts_SQL):** Pipeline de dados construído em SQL (PostgreSQL).
    * `00_VALIDAÇÃO_INICIAL.sql` até `05_EXPLORAÇÃO_ANALISE_TURMAS.sql`.
* **[`/power_bi`](./power_bi):** Arquivo fonte `.pbix` e versão em PDF do relatório.


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

---

## 📈 Principais Insights e Valor de Negócio
* **Identificação de Alunos em Risco:** Cruzamento de dados que permite intervenção pedagógica preventiva.
* **Auditoria Pedagógica:** A Matriz de Coerência ajuda a identificar se os resultados da avaliação externa condizem com o histórico do aluno.
* **Benchmarking de Turmas:** Comparação clara de médias e rankings para compartilhamento de boas práticas entre professores.

---

## 🔗 Links Rápidos
* [📖 Ler o Dicionário de Dados](./docs/DICIONÁRIO_DADOS.md)
* [📓 Ver o Journal (Passo a passo)](./docs/JOURNAL.md)
* [📑 Entender as Regras de Negócio](./docs/REGRAS_DE_NEGÓCIO.md)

---

## 👤 Autor
**Sabrina Batista** *Conecte-se comigo!* [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](SEU_LINK_DO_LINKEDIN_AQUI)
[![E-mail](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:SEU_EMAIL_AQUI)

---
*Projeto desenvolvido para fins de portfólio em análise e engenharia de dados.*

Dica para o seu GitHub:
Imagens: Se possível, tire um print bem bonito do dashboard e coloque logo abaixo do título principal. Recrutadores adoram ver o visual antes do código.

Caminhos: Verifique se os caminhos dos links (./scripts_SQL, etc.) estão batendo exatamente com os nomes das pastas que você criou no seu repositório.

GIF: Se tiver o vídeo do dashboard, você pode convertê-lo em um pequeno GIF e colocar no README para dar movimento à página!
* No GitHub, você pode colocar esse Journal no seu README.md principal sob o título "Como este projeto foi construído".
* Isso "vende" a sua capacidade analítica antes mesmo do recrutador abrir o dashboard!
