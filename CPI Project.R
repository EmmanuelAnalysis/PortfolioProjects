
# This code allows us to analyze CPI and CPIXFE (excluding food and energy) data from a Statistics Canada table from 2005 to 2023. #

View(datacpi)

# Let's create a time series for CPI and CPIXFE and plot both series on a graph.

CPI <- ts(datacpi$CPI, start=c(2005, 1), end=c(2023, 7), frequency = 12)
CPIXFE <- ts(datacpi$CPIXFE, start=c(2005, 1), end=c(2023, 7), frequency = 12)

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


# Using CPI and CPIXFE, we can calculate the annual inflation rate in Canada since 2000 and plot this on a graph. 

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


# End of code. 
