#Gabriel Boechat; Economia PUC-Rio
#GitHub: https://github.com/gabrielboechat
#Twitter: https://twitter.com/gab_boechat
#LinkedIn: https://www.linkedin.com/in/gabriel-boechat/



#SETOR PÚBLICO - REGIME DE PRÓPRIO DE PREVIDÊNCIA SOCIAL (A PARTIR DE AGORA RPPS) - 10/2019

#source: http://www.previdencia.gov.br/dados-abertos/estatisticas-e-informacoes-dos-rpps/

#Bibliotecas utilizadas:

library(rmarkdown)
library(AER)
library(stats)
library(MASS)
library(scales)
library(haven)
library(descr)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)


# Para RPPS em geral, arquivos serão listados como:

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#aliquota: representam dados gerais como quantidade de pessoas jurídicas com as mesmas características previdenciárias, dividindo entre servidores do Estado e Municípios. Porcentagem da alíquota também é observada para cada agregado
file.head("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Aliquotas-de-Contribuicao-Praticadas.csv")

aliquota = read.csv("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Aliquotas-de-Contribuicao-Praticadas.csv", sep = ";", dec = ".", header = TRUE, quote = "")

names(aliquota) = c("CNPJ","Ente","UF","Plano de Segregação","Sujeito Passivo","Alíquota","Início de Vigência","Fim de Vigência")

aliquota



#historico: representam dados sobre municípios e estados que participam de RPPS ou RGPS, além de dados jurídicos sobre a legislação em cada Ente e/ou uF 
file.head("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Historico-de-Regimes-Previdenciarios.csv")

historico = read.csv("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Historico-de-Regimes-Previdenciarios.csv", sep = ";", dec = ".", header = TRUE, quote = "")

names(historico) = c("CNPJ","UF","Ente","Regime","Data de Início do Regime","Data de Fim do Regime","Tipo de Documento","Número (sem Ano)","Data do Documento","Data da Publicação","Data de Início da Vigência","Ementa","Lei que revogou","SERVIDOR AMPARADO","NM_ARTIGO_INICIO")

historico



#regimes: versão concisa da tabela anterior, representando quantidade de RGPS e RPPS por UF
file.head("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Quantidade-de-Regimes-por-UF.csv")

regimes = read.csv("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Quantidade-de-Regimes-por-UF.csv", sep = ";", dec = ".", header = TRUE, quote = "")

names(regimes) = c("UF","RGPS","RPPS","RPPS em Extinção")

regimes



#regime_ente: para cada município, representa se tem RPPS ou RGPS
file.head("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Regime-Previdenciario-dos-Entes-Federativos.csv")

regime_ente = read.csv("C:\\Users\\gabri\\Desktop\\Ciências Econômicas\\Período IV\\Economia do Setor Público\\Trabalhos\\seminário previdência\\dados\\DADOS-GERAIS-Regime-Previdenciario-dos-Entes-Federativos.csv", sep = ";", dec = ".", header = TRUE, quote = "")

names(regime_ente) = c("CNPJ","UF","Ente Federativo","Regime")

regime_ente



# Para observar o data.frame em sua totalidade, usar a função view("data.frame"), com seu respectivo nome

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Agora, estamos interessados em fazer apresentações gráficas dos dados listados acima.

#Gráfico nº1: Proporção de RPPS para cada UF

ggplot(data = regime_ente) +
  geom_bar(mapping = aes(x = regime_ente$UF, fill = regime_ente$Regime), position = "fill") +
  coord_flip() +
  xlab("Unidade Federativa") +
  ylab("Proporção") +
  labs(caption = "Fonte: Portal da Previdência
       Elaboração: Gabriel Boechat") +
  ggtitle("Proporção do RPPS para cada Unidade Federativa") +
  scale_fill_brewer(name = "Regime Previdenciário", palette = "Pastel2", labels = c("RGPS", "RPPS", "RPPS em Extinção")) +
  theme_classic()



# OBS:

library(RColorBrewer)

# Para rodar todas as paletas de cores:

display.brewer.all()



#Gráfico nº2: Proporção dos servidores

ggplot(data = aliquota) +
  geom_bar(mapping = aes(x = aliquota$UF, fill = aliquota$`Sujeito Passivo`), position = "fill") +
  coord_flip() +
  xlab("Unidade Federativa") +
  ylab("Proporção") +
  labs(caption = "Fonte: Portal da Previdência
       Elaboração: Gabriel Boechat") +
  scale_fill_brewer(name = "Sujeito Passivo", palette = "Pastel2") +
  ggtitle("Qual proporção do caráter passivo dos pertencentes ao regime?") +
  theme_bw()
  
