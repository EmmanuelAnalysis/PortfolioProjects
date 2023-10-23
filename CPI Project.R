
# This code allows us to analyze CPI and CPIXFE (excluding food and energy) data from a Statistics Canada table from 1992 to 2023. #


# Import the data in text format. 

datacpi <- read.delim("~/Documents/PortfolioProjects/donneesipc.txt")
View(datacpi)


# Let's create a time series for CPI and CPIXFE and plot both series on a graph.

CPI <- ts(datacpi$CPI, start=c(1992, 1), end=c(2023, 7), frequency = 12)
CPIXFE <- ts(datacpi$CPIXFE, start=c(1992, 1), end=c(2023, 7), frequency = 12)

ts.plot(CPI, CPIXFE, main="CPI et CPIXFE", col=c("blue", "red"))
legend("topleft", legend=c("CPI", "CPIXFE"), lty=1:1, col=c("blue", "red"), 
       bty="n", x.intersp=0.5, y.intersp=0.5, xpd=TRUE)


# Let's make this more interesting by creating an interactive graph of these series using "ploty". 

library(plotly)

plotly_line_plot <- plot_ly()

plotly_line_plot <- add_trace(
  plotly_line_plot,
  x = time(CPI),
  y = as.vector(CPI),
  name = "CPI",
  type = "scatter",
  mode = "lines",
  line = list(color = "blue")
)

plotly_line_plot <- add_trace(
  plotly_line_plot,
  x = time(CPIXFE),
  y = as.vector(CPIXFE),
  name = "CPIXFE",
  type = "scatter",
  mode = "lines",
  line = list(color = "red")
)

plotly_line_plot <- layout(
  plotly_line_plot,
  title = "Interactive Time Series Plot of CPI and CPIXFE",
  xaxis = list(title = "Time"),
  yaxis = list(title = "Inflation Rate"),
  showlegend = TRUE
)

plotly_line_plot


# Using CPI and CPIXFE, we can calculate the annual inflation rate in Canada since 1992 and plot this on a graph. 

annual_CPI <- aggregate(CPI, nfrequency = 1, FUN = sum)
annual_CPIXFE <- aggregate(CPIXFE, nfrequency = 1, FUN = sum)
annual_inflation_rate_CPI <- diff(CPI, lag = 12) / lag(CPI, 12) * 100
annual_inflation_rate_CPIXFE <- diff(CPIXFE, lag = 12) / lag(CPIXFE, 12) * 100

ts.plot(annual_inflation_rate_CPI, annual_inflation_rate_CPIXFE, main="Inflation Rate", col=c("blue", "red"))
legend("topleft", legend=c("Inflation CPI", "Inflation CPIXFE"), lty=1:1, col=c("blue", "red"),
       bty="n", cex=0.6, x.intersp=0.5, y.intersp=0.5, xpd=TRUE)


# By creating histograms, we can see that the inflation rate has remained within a range of 1% to 3% most of the time.

hist(annual_inflation_rate_CPI)
hist(annual_inflation_rate_CPIXFE)


# By analyzing the variance, we can see which of CPI or CPIXFE is the most volatile. 

var(annual_inflation_rate_CPI)
var(annual_inflation_rate_CPIXFE)


# We now want to compare the evolution of the CPI if the annual infaltion rate were 2% every year since 1995.
# We'll call this index CPIIDEAL.

months <- seq(from = as.Date("1992-01-01"), 
              to = as.Date("2023-07-01"), by = "months")

months_to_1995 <- which(format(months, "%Y-%m") == "1995-01")

taux_inflation <- 1.02 ^ (1/12) - 1

CPIIDEAL <- numeric(length(months))

CPIIDEAL [months_to_1995] <- 100

for (i in (months_to_1995 + 1):length(months)) {
  CPIIDEAL[i] <- CPIIDEAL[i - 1] * (1 + taux_inflation)
}

CPIIDEAL <- ts(CPIIDEAL, start = c(1992, 1), frequency = 12)


# CPI and CPIXFE are adjusted to compare with CPIIDEAL. 

CPI_adjusted <- (CPI/86.6) * 100
CPIXFE_adjusted <- (CPIXFE/87.8) * 100


# Let's create a graph to compare CPIIDEAL, CPI and CPIXFE

ts.plot(CPI_adjusted, CPIXFE_adjusted, CPIIDEAL, main="Comparison Inflation", col=c("blue", "red", "orange"))
legend("topleft", legend=c("CPI", "CPIXFE", "CPITAR"), lty=1:1, col=c("blue", "red", "orange"), 
       bty="n", cex=0.8, x.intersp=0.5, y.intersp=0.5, xpd=TRUE)


# End of code. 