# 📖 Dicionário de Dados

## Convenção de Tipagem utilizada nesta documentação:

* INT4: Número inteiro (Chaves e contagens).
* VARCHAR(50): Texto variável de até 50 caracteres (Nomes e categorias).
* NUMERIC: Valor decimal (Cálculos de médias e porcentagens).

## TABELAS ORIGINAIS
#### Tabela Dimensão: Turmas
OBS: Coluna ID_TURMA se conecta com coluna de mesmo nome na tabela AVALIA.
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| ID_TURMA | String| Chave primária da turma | Única por turma |
| NOME_TURMA | String | Referência nominal da turma | Único por turma |
| SÉRIE | String | Nível de Escolaridade | Todas as turmas pertencem ao 1º ano do ensino médio |
| TURNO | String | Período em que frequentam as aulas | Turmas 1A e 1B estudam pela manhã, turmas 1C e 1D à tarde |


#### Tabela Dimensão: Alunos
OBS: Coluna ID_ALUNO se conecta com coluna de mesmo nome na tabela AVALIA.
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| ID_ALUNO | Integer (ARRUMAR DEPOIS, DBEAVER)| Chave primária do aluno | Única por aluno |
| NOME | Integer | Nome cadastrado | Único por aluno |
| IDADE | Integer | Idade cadastrada | Faixa etária entre 14 e 17 anos |


#### Tabela Dimensão: Proficiencia
Nota: A Proficiencia nas próximas tabelas se refere ao domínio dos estudantes na disciplina de matemática, em uma avaliação externa. A classificação considera pontuações de diferentes questões, tempo de prova, dentre outros critérios.

OBS: Coluna ID_PROFICIENCIA se conecta com coluna de mesmo nome na tabela AVALIA.
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| ID_PROFICIENCIA | Integer (ARRUMAR DEPOIS, DBEAVER)| Chave primária da proficiência | Única por nível |
| FAIXA_DE_PROFICIENCIA | Integer | Nome cadastrado | ... |
| NÍVEL_ORDEM | Integer | Idade cadastrada | Mostra qual está mais abaixo e qual está mais acima, dentre as FAIXAS DE PROFICIENCIA |
| DESCRIÇÃO | Integer | Detalhamento do que cad | Detalha o que cada Faixa de Proficiencia indica sobre os estudantes |


#### Tabela Fato: Avalia
Nota: Cada questão da prova tem um peso diferente, o que leva a pontuações diferentes para o mesmo ID_PROFICIENCIA;

OBS: Colunas ID_ALUNO, ID_TURMA e ID_PROFICIENCIA se conecta com colunas de mesmo nome nas tabelas dimensão.
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| ID_ALUNO | Integer (ARRUMAR DEPOIS, DBEAVER)| Chave primária do aluno | Única por aluno |
| ID_TURMA | Integer (ARRUMAR DEPOIS, DBEAVER)| Chave primária da turma | Única por turma |
| ACERTOS | Integer | Qtd de itens respondidos corretamente | Intervalo de 0 a 32 |
| TOTAL_QUESTOES | Integer (ARRUMAR DEPOIS, DBEAVER)| Qtd de itens na avaliação externa | Por padrão, são 32 questões |
| PROFICIENCIA | Integer (ARRUMAR DEPOIS, DBEAVER)| Pontuação de cada aluno | Critérios diversos de avaliação |
| ID_PROFICIENCIA | Integer (ARRUMAR DEPOIS, DBEAVER)| Chave primária da proficiência | Indica o nível de desempenho do aluno |

(ARRUMAR A PARTIR DAQUI)

| ACERTOS | Integer | Qtd de itens respondidos corretamente | Range: 0 a 32 |
| STATUS_APROVEITAMENTO| String | Classificação de rendimento | Calculado via DAX/SQL |
| ALUNOS_EM_RISCO | String | Identificador de alerta pedagógico | Baseado em critérios de proficiência e acertos |

## NOVAS MÉTRICAS
#### Tabela: Analise Geral
OBS: Coluna ID_TURMA se conecta com coluna de mesmo nome na tabela AVALIA.
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| ID_TURMA | Integer (ARRUMAR DEPOIS, DBEAVER)| Chave primária da turma | Única por turma |
| NOME_TURMA | Integer | Referência nominal da turma | Único por turma |

#### Tabela: Analise Turmas
OBS: Coluna ID_TURMA se conecta com coluna de mesmo nome na tabela AVALIA.
| Coluna | Tipo | Descrição | Observações/Domínio |
| :--- | :--- | :--- | :--- |
| ID_TURMA | Integer (ARRUMAR DEPOIS, DBEAVER)| Chave primária da turma | Única por turma |
| NOME_TURMA | Integer | Referência nominal da turma | Único por turma |
