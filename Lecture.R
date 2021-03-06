

# Let's look at some basic plots first
plot(BJsales)
plot(EuStockMarkets)
plot(JohnsonJohnson)

# Attach the 'TTR' package
plot(WWWusage)
smoothWWWusage = SMA(WWWusage,n=5)
par(mfrow=c(2,1))
plot(WWWusage)
plot(smoothWWWusage)

# Next we use built in functions to decompose a TS
# into the three basic parts
airpassengerscomp=decompose(AirPassengers)
par(mfrow=c(1,1))
plot(airpassengerscomp)

# We can isolate the trend by subtracting out the other
# components
names(airpassengerscomp)
AirPassTrend = AirPassengers - airpassengerscomp$seasonal- airpassengerscomp$random
par(mfrow=c(1,1))
plot(AirPassTrend)

# Next we'll look at rainfall totals and use Holt Winters
# to build a model. Note we need to use the 'scan' function
# to read the data in as one long vector.
c.name = file.path("C:", "knot4u", "UTD", "6301","InClassProject","InClassClean","Data","rain.dat")
rain = scan(c.name)
rainseries <- ts(rain,start=c(1813))

# This converts the data into a TS, starting in year 1813
plot.ts(rainseries)

# There does not appear to be a trend, which makes sense
# Let's use HW to create a forecast model
rainseriesforecasts = HoltWinters(rainseries, beta=FALSE, gamma=FALSE)
?HoltWinters

# Note we did not do a trend (because the TS is stationary)
# and we did not do seasonality since these are yearly totals
plot(rainseriesforecasts)
rainseriesforecasts$SSE
names(rainseriesforecasts)

# By default, HW only makes forecasts in the data range
# To make forecasts outside this range, we need the
# 'forecast' package
rainseriesforecasts2 = forecast.HoltWinters(rainseriesforecasts, h=8)
plot.forecast(rainseriesforecasts2)
rainseriesforecasts2

# Notice we get out this model is a point estimate for the
# expected value, and confidence intervals
# The noise is significant, so the intervals are wide
# Let's check the residuals
plot(rainseriesforecasts2$residuals)
hist(rainseriesforecasts2$residuals)

# Fairly normal
qqnorm(rainseriesforecasts2$residuals)
APforecasts = HoltWinters(AirPassengers)
plot(APforecasts)
APforecasts2= forecast.HoltWinters(APforecasts, h=8)
plot(APforecasts2)
plot(APforecasts2$residuals)
hist(APforecasts2$residuals)

# Let's check the correlograms
acf(AirPassengers)
pacf(AirPassengers)
?pacf
data()

# Let's apply this technique to Johnson & Johnson
plot(JohnsonJohnson)
JJforecasts = HoltWinters(JohnsonJohnson)
plot(JJforecasts)
JJforecasts2 = forecast.HoltWinters(JJforecasts,h=8)
plot(JJforecasts2)
names(JJforecasts)
JJforecasts$SSE
length(JohnsonJohnson)
JohnsonJohnson
sqrt(JJforecasts$SSE)/length(JohnsonJohnson)

