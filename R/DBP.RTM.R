##' @title Regression to the mean
##' @param mu  The mean DBP at baseline
##' @param sigma  The standard deviation at baseline and at follow-up
##' @param r The pre-post correlation
##' @param n sample size
##' @param limit Limit for hypertension
##' @param TrueChange True Change from Baseline. Default is zero.
##' @param show.plot Add plot, default=TRUE
##' @return A list with
##' \itemize{
##' \item plot showing equality line and the linear regression slope for all observations
##' \item plot showing extreme subjects only with regression to the mean
##' \item A list with
##' \itemize{
##' \item summary I - Summary statistics for all observations
##' \item summary II - Summary statistics for extreme cases (with hypertension) only
##' \item correlation Pre-Post correlation or intraclass correlation
##' \item t-test all
##' \item t-test extreme
##' \item model Coefs from simple linear regression (that is, by "fixing" baseline), equals the correlation coefficient for standardized data
##' \item fraction of regression to the mean, RTM, equals (1-rho)
##' \item dataI all observations
##' \item dataII extreme cases
##' }}
##' @author meichtry
##' @references Senn, S. (2009) Three things that every medical writer should know about statistics. The Write Stuff, 18 (3). pp. 159-162. ISSN 1854-8466
##' @importFrom graphics abline lines par
##' @importFrom stats lm t.test
##' @export
##' @examples ##Assume a true change of -10 (on diastolic blood presssure)
##' DBP.RTM(TrueChange=-10)
DBP.RTM <-function(mu = 90, sigma = 8, r = .76, n = 1000, limit = 95, TrueChange = 0, show.plot = TRUE){
    muvec <- c(mu, mu + TrueChange)
    sigmavec <- c(sigma, sigma)
    Sigma <- matrix(c(
      sigmavec[1]^2, r * sigmavec[1] * sigmavec[2],
      r * sigmavec[1] * sigmavec[2], sigmavec[2]^2
    ), 2, 2)
    X <- MASS::mvrnorm(n, muvec, Sigma, empirical = TRUE)
    X2 <- X[X[, 1] > limit, ]
    colnames(X) <- colnames(X2) <- c("Baseline", "Follow-up")
    if (show.plot == TRUE) {
      # par(mfrow=c(1,2))
      plot(X, xlim = c(min(X), max(X)), ylim = c(min(X), max(X)), xlab = "DBP at baseline", ylab = "DBP at follow-up", cex = .3)
      abline(h = mean(X[, 2]), v = mean(X[, 1]), lty = 2, col = "red")
      abline(lm(X[, 2] ~ X[, 1]), col = "blue", lty = 1)
      lines(x = c(min(X), max(X)), y = c(min(X) + TrueChange, max(X) + TrueChange), lty = "dashed", col = "red")
      plot(X2[, 1], X2[, 2], xlim = c(min(X), max(X)), ylim = c(min(X), max(X)), xlab = "DBP at baseline", ylab = "DBP at follow-up", cex = .3)
      abline(lm(X[, 2] ~ X[, 1]), col = "blue", lty = 1)
      abline(h = c(limit + TrueChange, mean(X2[, 2])), v = c(limit, mean(X2[, 1])), lty = c(1, 2), col = c(1, 2))
    }
    results <- list(
      overall = psych::describe(X),
      extremgroup = psych::describe(X2),
      correlation = r,
      ttestall = t.test(x = X[, 1], y = X[, 2], paired = TRUE),
      ttestextrem = t.test(x = X2[, 1], y = X2[, 2], paired = TRUE),
      model = summary(lm(X[, 2] ~ X[, 1]))$coef,
      RTM = 1 - r,
      dataall = X,
      dataextrem = X2
    )
    #return(results)
  }
