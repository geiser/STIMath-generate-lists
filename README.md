# Algoritmos para a gerâção de listas de exercicios no projeto STIMath

## (1) TRI aplicado nos itens do piloto para o STIMath 

O programa em R no arquivo "estimate-irt-params-2.R" determina os parâmetros de dificuldade, chute e discriminante usando a TRI (Teoria da Resposta ao Item). Além disso também calcula o fator latente (habilidade) estimada para os participantes do estudo piloto.

### Entrada de dados: Lista de Arquivos

 - Classificacao_dos_itens.xlsx : Arquivo com os dados da aplicação do piloto (avaliação efeituada para calcular os valores dos parâmetros)

### Saída de dados: Lista de Arquivos

As columnas nas tabelas seguintes correspondem com: 

 - a1: poder de discriminação
 - d: grau de dificuldade
 - g: probabilidade de chute (acerto ao acaso)

A lista de arquivos são as seguintes:

 - EF01MA06-irt-params.csv : Parâmetros da TRI estimados para os itens da compêtencia EF01MA06.
 - EF01MA08-irt-params.csv : Parâmetros da TRI estimados para os itens da compêtencia EF01MA08.
 - EF02MA05-irt-params.csv : Parâmetros da TRI estimados para os itens da compêtencia EF02MA05.
 - EF02MA06-irt-params.csv : Parâmetros da TRI estimados para os itens da compêtencia EF02MA06.

 - EF01MA06-theta.csv : Hábilidades (fator latente - F1) estimadas na competência EF01MA06 para os participipantes do piloto.
 - EF01MA08-theta.csv : Hábilidades na competência EF01MA08 para os participipantes do piloto.
 - EF02MA05-theta.csv : Hábilidades na competência EF02MA05 para os participipantes do piloto.
 - EF02MA06-theta.csv : Hábilidades na competência EF02MA06 para os participipantes do piloto.


## (2) Exemplo de como aplicar TRI (apenas para fines didáticos)

O arquivo "estimate-irt-params.R" contem um exemplo de como usar R para determina os parâmetros de dificuldade, chute e discriminante usando a TRI (Teoria da Resposta ao Item).

### Entrada de dados: Lista de Arquivos

 - dat.csv : Arquivo com os dados para o exemplo de estimação de parametros usando TRI.

### Saída de dados: Lista de Arquivos

 - irt-params.csv : Parâmetros da TRI estimados para os dados do exemplo.
 - theta.csv : Hábilidades (fator latente - F1) estimadas com os dados do exemplo.

## (3) Algoritmo para a geração de lista de exercícios como atividades de reforço

Atividades com exercicios de tipo reforço correspondem com exercícios destinados a estudantes que, por alguma razão, não conseguiram aprender certo conteúdo durante as aulas regulares e apresentam algum tipo de dificuldade de aprendizagem. Nesse sentido, é importante apresentar para o estudante uma lista com exercícios previamente resolvidos por eles.

O algorimo para a geração deste tipo de listas exercicios foi desenvolvido na linguagem R e está disponível no arquivo "reinforcement-exercises.R" (para detalhes do algoritmo leia-se [https://docs.google.com/document/d/17lLS8oGUaISOt6mW3z8H0Pj952QQbshN/edit?usp=drivesdk&ouid=115231936147760778990&rtpof=true&sd=true](https://docs.google.com/document/d/17lLS8oGUaISOt6mW3z8H0Pj952QQbshN/edit?usp=drivesdk&ouid=115231936147760778990&rtpof=true&sd=true))


### Entrada de dados: Lista de Arquivos

 - irt-params.csv : Parâmetros da TRI para os exercícios que serão usados como itens na lista de exercicios.
 - log.csv : Arquivo com as atividades prévias efeituadas pelos estudantes - na tabela, as colunas correspondem com:
    
   - problem_id : identificador do exercício resolvido pelo estudante.
   - skill_name : habilidade na qual é categorizada cada exercício/problema.
   - user_id : identificador do estudante/usuário que resolveu o exercício/problema.
   - correct : o valor 1 indica que o exercício/problema foi resolvido adequadamente e 0 que não foi resolvido.

## (4) Algoritmo para a geração de lista de exercícios em sala de aula

Nas atividades em sala de aula, pelo geral é necessaria a geração de uma lista de exercício com itens que nunca foram aplicados, a lista de exercício será gerada estimando a probabilidade que cada um dos estudantes têm em possuir uma determina competência da BNCC.    

O algorimo para a geração deste tipo de listas exercicios foi desenvolvido na linguagem R e está disponível no arquivo "new-exercises.R" (para detalhes do algoritmo leia-se [https://docs.google.com/document/d/17lLS8oGUaISOt6mW3z8H0Pj952QQbshN/edit?usp=drivesdk&ouid=115231936147760778990&rtpof=true&sd=true](https://docs.google.com/document/d/17lLS8oGUaISOt6mW3z8H0Pj952QQbshN/edit?usp=drivesdk&ouid=115231936147760778990&rtpof=true&sd=true))


### Entrada de dados: Lista de Arquivos

 - irt-params.csv : Parâmetros da TRI para os exercícios que serão usados como itens na lista de exercicios.
 - log.csv : Arquivo com as atividades prévias efeituadas pelos estudantes - na tabela, as colunas correspondem com:
    
   - problem_id : identificador do exercício resolvido pelo estudante.
   - skill_name : habilidade na qual é categorizada cada exercício/problema.
   - user_id : identificador do estudante/usuário que resolveu o exercício/problema.
   - correct : o valor 1 indica que o exercício/problema foi resolvido adequadamente e 0 que não foi resolvido.

### Algoritmos e outros programas auxiliares

O arquivo "bkt.R" apresenta uma implentação básica do algoritmo BKT - algoritmo que é usado para determinar qual é a probabilidade de um estudante possuir uma habilidade com base em respostas anteriores.
