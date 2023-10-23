# Importer les données en format text. 

donneesipc <- read.delim("~/Documents/PortfolioProjects/donneesipc.txt")
View(donneesipc)

# Créeons une série chronologique pour CPI et CPIXFE 

CPI <- ts(donneesipc$CPI, start=c(1992, 1), end=c(2023, 7), frequency = 12)
CPIXFE <- ts(donneesipc$CPIXFE, start=c(1992, 1), end=c(2023, 7), frequency = 12)


ts.plot(CPI, CPIXFE, main="CPI et CPIXFE", col=c("blue", "red"))
legend("topleft", legend=c("CPI", "CPIXFE"), lty=1:1, col=c("blue", "red"), 
       bty="n", x.intersp=0.5, y.intersp=0.5, xpd=TRUE)


annual_CPI <- aggregate(CPI, nfrequency = 1, FUN = sum)
annual_CPIXFE <- aggregate(CPIXFE, nfrequency = 1, FUN = sum)
annual_inflation_rate_CPI <- diff(CPI, lag = 12) / lag(CPI, 12) * 100
annual_inflation_rate_CPIXFE <- diff(CPIXFE, lag = 12) / lag(CPIXFE, 12) * 100
annual_inflation_rate_CPI
annual_inflation_rate_CPIXFE


# Traçons sur un graphique le taux d'inflation mesuré par CPI et CPIXFE

ts.plot(annual_inflation_rate_CPI, annual_inflation_rate_CPIXFE, main="Inflation Rate", col=c("blue", "red"))
legend("topleft", legend=c("Inflation CPI", "Inflation CPIXFE"), lty=1:1, col=c("blue", "red"),
       bty="n", cex=0.6, x.intersp=0.5, y.intersp=0.5, xpd=TRUE)
hist(annual_inflation_rate)
hist(annual_inflation_rate_CPIXFE)

#En général, en se basant sur les histogrammes, la Banque du Canada a été en mesure de rencontrer son mandat de maintenir le taux d'inflation dans une fourchette de 1% à 3%.


# Calculons la variance de l'inflation mesurée par CPI et CPIXFE

var(annual_inflation_rate_CPI)
var(annual_inflation_rate_CPIXFE)



# Les économistes et les banquiers centraux se préoccupent de l'inflation fondamentale dans la conduite de la politique monétaire pour plusieurs raisons importantes.
# Premièrement, comme nous l'avons vu, c'est une mesure moins volatile que le CPI et l'un des objectifs de la politique monétaire est de maintenir la stabilité des prix. 
# L'inflation fondamentale, qui exclut les aliments et l'énergie, (CPIXFE) permet de mieux mesurer la tendance générale de l'inflation, en éliminant la volatilité potentielle due aux prix des produits de base qui fluctuent souvent comme les aliments et l'énergie. 
# Se baser sur l'inflation fondamentale aide à prévenir une inflation excessive qui pourrait déstabiliser l'économie. L'inflation fondamentale se concentre sur des componsantes avec moins de variations temporaires importantes. 
# Cela rend la mesure de l'inflation plus précise et permet aux décideurs de mieux comprendre les tendances.


# Créeons la séquence de mois de janvier 1992 à juillet 2023

months <- seq(from = as.Date("1992-01-01"), 
              to = as.Date("2023-07-01"), by = "months")

# On calcule le nombre de mois de janvier 1992 à janvier 1995

months_to_1995 <- which(format(months, "%Y-%m") == "1995-01")

# On calcule le taux d'inflation annuel de 2%

taux_inflation <- 1.02 ^ (1/12) - 1

# On crée un vecteur vide pour CPITAR

CPITAR <- numeric(length(months))

# On met janvier 1995 à 100

CPITAR [months_to_1995] <- 100

# On calcule les valeurs restantes pour CPITAR en utilisant une boucle

for (i in (months_to_1995 + 1):length(months)) {
  CPITAR[i] <- CPITAR[i - 1] * (1 + taux_inflation)
}

# On fait de CPITAR une série temporelle

CPITAR <- ts(CPITAR, start = c(1992, 1), frequency = 12)
print(CPITAR)


# On ajuste CPI et CPIXFE pour qu'ils prennent la valeur 100 en janvier 1995. 

CPI_adjusted <- (CPI/86.6) * 100
CPI_adjusted

CPIXFE_adjusted <- (CPIXFE/87.8) * 100
CPIXFE_adjusted

CPITAR


ts.plot(CPI_adjusted, CPIXFE_adjusted, CPITAR, main="Comparaison Inflation", col=c("blue", "red", "orange"))
legend("topleft", legend=c("CPI", "CPIXFE", "CPITAR"), lty=1:1, col=c("blue", "red", "orange"), 
       bty="n", cex=0.8, x.intersp=0.5, y.intersp=0.5, xpd=TRUE)