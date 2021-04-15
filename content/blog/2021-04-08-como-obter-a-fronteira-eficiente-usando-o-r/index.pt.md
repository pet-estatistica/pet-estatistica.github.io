---
title: Como obter a fronteira eficiente usando R
author: Geisyane Karina Gonzaga Kath
date: '2021-04-08'
slug: []
categories:
  - tutoriais
  - economia
  - finanças
tags:
  - investimentos
  - carteira otima
  - fronteira eficiente
  - markowitz
description: ''
images:
  - 'img/fronteira_eficiente/calculator-1680905_1920.jpg'
---
### O QUE É FRONTEIRA EFICIENTE

Uma carteira de investimentos é dada por um conjunto de ativos (ou ainda por um único ativo) cuja soma da proporção a ser investida em cada componente é 1. Assim, é possível compreender a definição de fronteira eficiente que foi utilizada por Markowitz: dado um conjunto de ativos, há inúmeras possibilidades de combinações dos mesmos formando carteiras, por isso, para representá-las em um diagrama de forma eficiente e de fácil visualização, basta considerar que se duas carteiras possuem o mesmo risco e uma delas tem o maior retorno, a de menor retorno é desprezada. Do mesmo modo, se duas carteiras possuem o mesmo retorno esperado e uma delas possui o menor risco, esta será a escolhida. Ou seja, a fronteira eficiente é formada apenas pelas carteiras que seriam de interesse de investidores.


No livro Moderna Teoria de Carteiras e Análise de Investimentos (2012), capítulo 5, os autores utilizam a imagem a seguir para representar a infinidade de carteiras possíveis.

|![](/blog/2021-04-08-como-obter-a-fronteira-eficiente-usando-o-r_files/FE.png) | 
|:--:| 
| *Fonte: Elton, et. al (2012)* |


Perceba que, seguindo o conceito anteriormente apresentado de fronteira eficiente, a carteira B é preferível no lugar de A, visto que se trata de correr o mesmo risco e obter um possível retorno maior. Da mesma forma, a carteira E é preferível em relação a F, pois embora o retorno esperado seja o mesmo, o risco é menor. Assim, a fronteira eficiente é aquela que vai da carteira de menor risco até a que possui o maior retorno, observando as regras mencionadas: trata-se, no caso da figura, do segmento CEB.

### SEM VENDAS A DESCOBERTO E SEM RETORNO À TAXA LIVRE DE RISCO

Para representar a fronteira eficiente no R, primeiramente é necessário instalar os seguintes pacotes:

```
install.packages('quadprog')
install.packages('PerformanceAnalytics')
install.packages("IntroCompFinR", repos="http://R-Forge.R-project.org")
install.packages('BatchGetSymbols')

```

Depois, é preciso baixar os dados de interesse, que são os retornos dos ativos em determinado período. Para isso,


```

library(quadprog)
library(PerformanceAnalytics)
library(IntroCompFinR)
library(BatchGetSymbols)

# Selecione os ativos que deseja trabalhar

papeis <- c('MGLU3.SA', 'PETR4.SA', 'ITUB4.SA', 'WEGE3.SA')

# Adicione uma data inicial e final para os retornos que quer consultar.
# Lembre que a data deve ser colocada na ordem ano-mês-dia.

data.inicial <- as.Date('2019-06-17')
data.final <- as.Date('2020-07-31')

# Especifique se deseja retornos diários("daily"), semanais("weekly"), mensais("monthly") ou anuais("yearly").

frequencia <- 'monthly'

Retornos <- BatchGetSymbols(ticker = papeis, first.date = data.inicial,
                            last.date = data.final, freq.data = frequencia)

# Aqui é importante observar a ordem que os dados foram gerados, para isso:

Retornos$df.tickers$ticker

> Retornos$df.tickers$ticker
 [1] "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA"
 [8] "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA" "ITUB4.SA"
[15] "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA"
[22] "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA" "MGLU3.SA"
[29] "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA"
[36] "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA" "PETR4.SA"
[43] "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA"
[50] "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA" "WEGE3.SA"

# Observe que a ordem não é a do vetor informado em "papeis", mas sim ITUB4.SA, MGLU3.SA, PETR4.SA e WEGE3.SA

Tabela_Retornos <- as.data.frame(Retornos[2])
Tabela_Retornos

```

Sendo de interesse apenas a coluna da tabela que contém os retornos ajustados pelo preço (df.tickers.ret.adjusted.prices), é importante extrair apenas os dados dessa coluna referente a cada um dos ativos. 


```
# Para obter apenas os dados da coluna de interesse

dados<-Tabela_Retornos$df.tickers.ret.adjusted.prices
dados

# Para colocar os dados em sequência e retirar os NA

x <- seq_along(dados[!is.na(dados)])
x

# Para separar os dados em termos de cada ativo (ceiling é x/13 porque são 13 meses).
# Como são 4 ativos sendo analisados, serão 4 sep

sep <- split(dados[!is.na(dados)], ceiling(x/13))
sep

# Para que os retornos fiquem em porcentagem:

# ITUB4.SA
z1<-sep$'1'*100
# MGLU3.SA 
z2<-sep$'2'*100
# PETR4.SA 
z3<-sep$'3'*100
# WEGE3.SA
z4<-sep$'4'*100

ativos<-c('ITUB4.SA','MGLU3.SA','PETR4.SA','WEGE3.SA')
retornos<-cbind(z1,z2,z3,z4)

```

Para traçar a fronteira eficiente é preciso ter alguns insumos como o retorno médio de cada ativo e também a matriz de covariância dos mesmos, assim,

```
# Para calcular a média dos retornos de cada ativo:

retorno_medio<- rbind(mean(retornos[,1]), mean(retornos[,2]), mean(retornos[,3]), mean(retornos[,4]))
retorno_medio

# Para calcular o desvio padrão dos retornos de cada ativo:

desvio_padrao<- rbind(sd(z1),sd(z2), sd(z3), sd(z4))

# Para nomear as linhas

rownames(desvio_padrao)<-ativos
rownames(retorno_medio) <- ativos

# Para obter a matriz de covariância dos ativos

matriz_cov <- cov(retornos)

rownames(matriz_cov) <- ativos
colnames(matriz_cov) <- ativos

```

Para obter a carteira de menor risco e os pontos da fronteira eficiente:


```
#Para que não haja vendas a descoberto:

short<-FALSE

# Cálculo da carteira com a menor risco possível

carteira_min_risco <- globalMin.portfolio(retorno_medio, matriz_cov, shorts = short)

# É possível visualizar o retorno esperado, o risco e a proporção a ser investida em cada ativo para a carteira de menor risco

carteira_min_risco

# Cálculo dos diferentes pontos da fronteira eficiente
#nport é o número de pontos com diferentes pesos a serem calculados pela função

fronteira_eficiente <- efficient.frontier(retorno_medio, matriz_cov, nport = 1500, shorts = short)
fronteira_eficiente

```

E para visualizar a fronteira eficiente:


```

# Visualização da Fronteira Eficiente
# xlim e ylim é a escala do gráfico, xaxs='i' e yaxs='i' é para que o eixo horizontal e vertical se iniciem em zero
#xlab e ylab é para renomear os eixos x e y respectivamente

plot(fronteira_eficiente$sd,fronteira_eficiente$er, ylab= "Retorno esperado", xlab="Risco da carteira",col="blue", pch=16, xlim=c(0,17),ylim=c(0,14),xaxs='i',yaxs='i')

# Observe que o eixo horizontal apresenta o desvio padrão e o eixo vertical apresenta o retorno esperado

# Para visualizar a carteira de menor risco

points(carteira_min_risco$sd, carteira_min_risco$er, col="green", pch=10, cex=2)
text(carteira_min_risco$sd, carteira_min_risco$er, labels="Risco Mínimo", pos=2)

# Para visualizar os demais ativos (o desvio padrão e o retorno médio são respectivamente colocados)
# pos=2 o nome do ativo fica ao lado esquerdo do ponto
# pos=1 o nome do ativo fica logo abaixo do ponto
# pos=3 o nome do ativo fica acima do ponto

points(9.9538,-1.2182, col='purple',pch=10, cex=2)
text(9.9538,-1.2182, "ITUB4", pos = 2)

points(15.3075,10.4740, col='Yellow',pch=10, cex=2)
text(15.3075,10.4740, "MGLU3", pos = 3)

points(16.9875,0.4360, col='gray',pch=10, cex=2)
text(16.9875,0.4360, "PETR4", pos = 2)

points(13.7182,10.3032, col='black',pch=10, cex=2)
text(13.7182,10.3032, "WEGE3", pos = 1)

```

![](/blog/2021-04-08-como-obter-a-fronteira-eficiente-usando-o-r_files/Rplot02.png)

### SEM VENDAS A DESCOBERTO E COM RETORNO À TAXA LIVRE DE RISCO

Aqui admite-se que o investidor tem a opção de investir em algum ativo com retorno livre de risco, para esse exemplo considere um retorno à taxa de juros de 0.11%. A forma de baixar os dados necessários é a mesma que no caso anterior e os mesmos dados foram utilizados para esse exemplo. 

```
# Para um retorno à taxa livre de risco igual a 0.11% e sem vendas a descoberto
tx_livre_risco <- 0.11
short <- FALSE

# Carteira eficiente

carteira_eficiente <-IntroCompFinR::tangency.portfolio(retorno_medio, matriz_cov, tx_livre_risco, shorts = short)

# É possível visualizar o retorno esperado, o risco da carteira e também a proporção que deve ser investida em cada ativo para obtê-la

carteira_eficiente

# Carteira de menor risco

carteira_min_risco <- globalMin.portfolio(retorno_medio, matriz_cov, shorts = short)


```
Para encontrar a fronteira eficiente:

```

# Pontos da Fronteira Eficiente

fronteira_eficiente <- efficient.frontier(retorno_medio, matriz_cov, nport = 1500, shorts = FALSE)

# Visualização da Fronteira Eficiente

plot(fronteira_eficiente$sd,fronteira_eficiente$er, col="blue",ylab= "Retorno esperado", xlab="Risco da carteira", pch=16, xlim=c(0,18),ylim=c(0,15), xaxs='i',yaxs='i') 

points(carteira_min_risco$sd, carteira_min_risco$er, col="green", pch=10, cex=2)
text(carteira_min_risco$sd, carteira_min_risco$er, labels="Risco Mínimo", pos=2)

points(carteira_eficiente$sd, carteira_eficiente$er, col="red", pch=10, cex=2)
text(carteira_eficiente$sd, carteira_eficiente$er, labels="Carteira Eficiente", pos=2)

points(9.9538,-1.2182, col='purple',pch=10, cex=2)
text(9.9538,-1.2182, "ITUB4", pos = 2)

points(15.3075,10.4740, col='Yellow',pch=10, cex=2)
text(15.3075,10.4740, "MGLU3", pos = 3)

points(16.9875,0.4360, col='gray',pch=10, cex=2)
text(16.9875,0.4360, "PETR4", pos = 2)

points(13.7182,10.3032, col='black',pch=10, cex=2)
text(13.7182,10.3032, "WEGE3", pos = 1)

```

A linha que tangencia a carteira eficiente tem como coeficiente angular
$$
\theta=\frac{\bar{R}_p-R_f}{\sigma_p}
$$

Em que


$\bar{R}_p$ é o retorno esperado da carteira ótima


$R_f$ é o retorno do ativo livre de risco


$\sigma_p$ é o risco da carteira ótima


Então,



```

# Cálculo de theta

theta <- (carteira_eficiente$er - tx_livre_risco)/carteira_eficiente$sd
theta

# Adição da linha que tangencia a carteira eficiente e que tem como intercepto o retorno à taxa livre de risco

abline(a = tx_livre_risco, b=theta, col="green")



```


![](/blog/2021-04-08-como-obter-a-fronteira-eficiente-usando-o-r_files/Rplot03.png)

### REFERÊNCIA BIBLIOGRÁFICA

ELTON, E. J.; GRUBER, M. J.; BROWN S. J.; GOETZMANN, W. N. Moderna Teoria de Carteiras e Análises de Investimentos. Tradução de Helga Hoffmann. Elsevier Editora Ltda, 2012. 747 p