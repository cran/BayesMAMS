\name{ssbayes}
\alias{ssbayes}
\title{
Bayesian Sample Size Calculation for Multi-Arm Studies
}
\description{This function implements a Bayesian approach to designing multi-arm trials where several experimental treatments are compared to a common control. The sample size is calculated to fulfil two criteria: (1) the probability of concluding a treatment is better than control (by a relevant margin) exceeds a prespecified value, eta, and (2) the probability of concluding that none of the treatments is better than control exceeds another prespecified value, zeta. The calculations can be performed with the precision assumed to be known or unknown. The underlying methods are described in Whitehead et al. (2015).
}
\usage{
ssbayes(k, nu, q0, deltastar, eta, zeta, alpha0, beta0, xi, prec="known", crit="1")
}
\arguments{
  \item{k}{Number of experimental treatments.}
  \item{nu}{Anticipated precision i.e., inverse of the variance.}
  \item{q0}{Vector of prior precisions to be multiplied with nu (first element for control, then experimental treatments)}
  \item{deltastar}{Clinically important treatment difference.}
  \item{eta}{Desired minimum posterior probability that a specific treatment (criterion 1) or at least any treatment (criterion 2) shows promise.}
  \item{zeta}{Desired minimum posterior probability that no treatment shows the clinically important treatment difference \code{deltastar}.}
  \item{alpha0}{Parameter in the gamma prior distribution for nu (only required if prec="unknown").}
  \item{beta0}{Parameter in the gamma prior distribution for nu (only required if prec="unknown").}
  \item{xi}{Desired probability that condition (10) in Whitehead et al. (2015) is fulfilled (only required if prec="unknown").}
  \item{prec}{Character string indicating whether the precision is assumed to be \code{"known"} or \code{"unknown"}.}
  \item{crit}{Character string indicating whether a sample size is to be set with respect to criterion "1" or "2" (see details below).}
}
\details{
Criterion (1) requires that the posterior probability of one ore more experimental treatments being better than control is at least \code{eta}, or else the posterior probability of none of the treatments being better than control (by a relevant margin \code{deltastar}) is at least \code{zeta}.

Criterion (2) requires that the posterior probability of at least one (any) experimental treatment being better than control is at least \code{eta}, or else the posterior probability of none of the treatments being better than control (by a relevant margin \code{deltastar}) is at least \code{zeta}.

The crucial difference between the two criteria is that (1) allows to tell which treatment(s) show(s) promise whereas (2) only allows to state that at least one treatment is promising (but we do not know which one). More details on the criteria can be found in Whitehead et al. (2015).
}
\value{
A matrix giving the sample sizes required per group (rounded up to the nearest integer).
}
\references{
Whitehead, J., Cleary, F., Turner, A. (2015) Bayesian sample sizes for exploratory clinical trials comparing multiple experimental treatments with a control. Statistics in Medicine, 34(12), 2048--2061.
}
\author{
Philip Pallmann (\email{p.pallmann@lancaster.ac.uk}), using R code from Amanda Turner
}
\note{
The calculated sample sizes are optimal in the sense that they add up to the smallest total sample size for a given scenario. However, they are usually not integers and hence rounded up to the nearest integer for practical reasons. Sometimes one can find combinations of integer group sample sizes that lead to a (slightly) smaller total sample size (by exhaustively searching all possible combinations).
}
\section{Warning }{
When the precisions \code{nu} and/or \code{q0} are extremely large, the calculation may yield negative values. In such cases the sample size is set to 0, and a warning message is printed.
}
\examples{
### Known precision (example from Section 3 of Whitehead et al. 2015)

# Criterion 1
ssbayes(k=2, nu=1, q0=c(16, 4, 4), eta=0.95, zeta=0.90, deltastar=0.5, prec="known", crit="1")

# Criterion 2
ssbayes(k=2, nu=1, q0=c(16, 4, 4), eta=0.95, zeta=0.90, deltastar=0.5, prec="known", crit="2")

### Unknown precision (example from Section 5 of Whitehead et al. 2015)

# Criterion 1
ssbayes(k=4, q0=c(10, rep(2, 4)), eta=0.95, zeta=0.90, deltastar=5, alpha0=1, beta0=49, xi=0.95,
        prec="unknown", crit="1")

# Criterion 2
ssbayes(k=4, q0=c(10, rep(2, 4)), eta=0.95, zeta=0.90, deltastar=5, alpha0=1, beta0=49, xi=0.95,
        prec="unknown", crit="2")
}
\keyword{~design}
