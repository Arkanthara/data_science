// Main report file
#import "template.typ": make-report, report-footnote
#import "metadata.typ": my-report
#import "@preview/theofig:0.1.0": definition

#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes

#show: make-report.with(my-report)

= Method of Moments, Maximum Likelihood, and Moment Generating Functions

In this assignment we explore three classical estimation techniques on a simple parametric model, and then investigate why higher-order moment matching may fail in practice. The exercises combine theoretical derivations and empirical analysis.

== The shifted exponential distribution

Consider the shifted exponential distribution with parameters $a in RR$ and $lambda > 0$, with density

$ f_(a, lambda)(x) = lambda e^(-lambda(x - a)) bold(1)_({x >= a}) . $

Let $X ~ f_(a, lambda)$. Throughout the section assume we observe an i.i.d. sample $X_1, dots, X_n$ from this distribution.

=== Method of Moments

1. Derive the first two theoretical moments of $X$, i.e. $EE[X]$ and $EE[(X - EE[X])^2]$, and express them as functions of $(a, lambda)$.
  #align(
    left,
    $
      EE[X] & = limits(integral)_(- infinity)^(+ infinity) x f_(a, lambda)(x) d x \
      & = limits(integral)_(- infinity)^(+ infinity) x lambda e^(-lambda(x - a)) bold(1)_({x >= a}) d x \
      & = limits(integral)_(a)^(infinity) x lambda e^(-lambda(x - a)) d x \
      & = limits(integral)_(0)^(infinity) (y + a) lambda e^(-lambda y) d y \
      & = limits(integral)_(0)^(infinity) y lambda e^(-lambda y) d y^#report-footnote[$integral u d v = u v - integral d u v$] + a limits(integral)_(0)^(infinity) lambda e^(-lambda y) d y \
      & = [-y e^(-lambda y)]_0^infinity + limits(integral)_(0)^(infinity) e^(-lambda y) d y + a [-e^(-lambda y)]_0^infinity \
      & = (lim_(y -> infinity) -y e^(-lambda y) + 0) - [1 / lambda e^(-lambda y)]_0^infinity + a (lim_(y -> infinity) -e^(-lambda y) + e^0) \
      & = (lim_(y -> infinity) - 1 / lambda e^(-lambda y) + 1 / lambda e^0) + a \
      & = 1 / lambda + a \
    $,
  )
  So we can derivate the second theoretical moment of $X$:
  #align(
    left,
    [$
      EE[(X - EE[X])^2] & = EE[(X - 1 / lambda - a)^2] \
      & = limits(integral)_(- infinity)^(+ infinity) (x - 1 / lambda - a)^2 f_(a, lambda)(x) d x \
      & = limits(integral)_(- infinity)^(+ infinity) (x - a - 1 / lambda)^2 lambda e^(-lambda(x - a)) bold(1)_({x >= a}) d x \
      & = limits(integral)_(a)^(+ infinity) (x - a - 1 / lambda)^2 lambda e^(-lambda(x - a)) d x \
      & = limits(integral)_(0)^(+ infinity) (y - 1 / lambda)^2 lambda e^(-lambda y) d y \
      & = limits(integral)_(0)^(+ infinity) y^2 lambda e^(-lambda y) d y - 2 limits(integral)_(0)^(+ infinity) y e^(-lambda y) d y + 1 / lambda limits(integral)_(0)^(+ infinity) e^(-lambda y) d y^#report-footnote[$limits(integral)_(0)^(infinity) e^(-lambda y) d y = [- 1 / lambda e^(-lambda y)]_0^infinity = (lim_(y -> infinity) - 1 / lambda e^(-lambda y) + 1 / lambda e^0) = 1 / lambda$]\
      & = [-y^2 e^(- lambda y)]_0^infinity + limits(integral)_(0)^(+ infinity) 2 y e^(-lambda y) d y - 2 / lambda ([-y e^(-lambda y)]_0^infinity + limits(integral)_(0)^(+ infinity) e^(-lambda y) d y) + 1 / lambda^2 \
      & = [-2y 1 / lambda e^(-lambda y)]_0^infinity + limits(integral)_(0)^(+ infinity) 2 / lambda e^(-lambda y) d y - 2 / lambda^2 + 1 / lambda^2 \
      & = 2 / lambda^2 - 2 / lambda^2 + 1 / lambda^2 \
      & = 1 / lambda^2
    $],
  )



2. Let

$ overline(X)_n = 1/n sum_(i=1)^n X_i , quad S_n^2 = 1/n sum_(i=1)^n (X_i - overline(X)_n)^2 $

be the empirical mean and (non-unbiased) variance. Set the theoretical moments equal to the empirical ones and solve this system to obtain the moment estimators $hat(a)_("MoM")$ and $hat(lambda)_("MoM")$.

#align(
  left,
  $
    cases(
      EE[X] = overline(X_n),
      EE[(X - EE[X])^2] = S_n^2
    ) & =cases(
          1 / lambda + a = overline(X_n),
          1 / lambda^2 = S_n^2
        ) \
      & =cases(
          a = overline(X_n) - 1 / lambda,
          1 / lambda^2 - S_n^2 = 0
        ) \
      & =cases(
          a = overline(X_n) - 1 / lambda,
          (1 / lambda - S_n) (1 / lambda + S_n) = 0
        ) \
      & =cases(
          a = overline(X_n) - 1 / lambda,
          lambda = 1 / S_n "or" lambda = - 1 / S_n
        ) \
      & =cases(
          a = overline(X_n) - S_n & " or " & a = overline(X_n) + S_n,
          lambda = 1 / S_n & " or " & lambda = - 1 / S_n
        ) \
  $,
)

So we have $(hat(a)_("MoM"), hat(lambda)_("MoM")) = (overline(X_n) - S_n, 1 / S_n)$ and not the other case because the standard deviation $S_n$ is always positive, so $lambda$ cannot be $- 1 / S_n$.

=== Maximum Likelihood Estimation

3. Write the log-likelihood $cal(l)(a, lambda)$ of the sample.

#align(
  left,
  $
    cal(l)(a, lambda) & = log(product_(i = 0)^n f(X_i; a, lambda)) \
    & = sum_(i = 0)^n log(lambda e^(-lambda(X_i - a)) bold(1)_({X_i >= a})) \
    &= n log(lambda) + sum_(i = 0)^n -lambda(X_i - a) underbrace(bold(1)_({X_i >= a}), "condition on "X_i) \
  $,
)

4. Show that the MLE of $a$ is $hat(a)_("MLE") = min_i X_i$.

First of all, the log-likelihood is only defined when $X_i >= a$.

So $a$ must be less or equal to all $X_i$.

On top of that, we try to maximise the log-likelihood, and the only place where $a$ appears is inside the term $-lambda(X_i - a)$ which has a negative sign.

So we must minimize the term $-lambda(X_i - a)$.
To do that, $a$ must be maximum.
However, $a$ must be less or equal to all $X_i$.
So if we take $a = min X_i$, the condition is respected and $a$ is maximum since all the $X_i$ are greater or equal to $0$.
Effectively, they are all probabilities, so between $0$ and $1$.

So to maximise the log-likelihood, we must take $hat(a)_("MLE") = min_i X_i$.

5. Derive the corresponding MLE $hat(lambda)_("MLE")$ by maximizing the log-likelihood w.r.t. $lambda$.

We want to find the maximum of the log-likelihood function.

To do that, we will compute the derivate of this function according to $lambda$ to find the optimum of the function.

#align(
  left,
  $
    (partial cal(l)(a, lambda)) / (partial lambda) = 0 &<==> partial / (partial lambda) (n log(lambda) + sum_(i = 0)^n -lambda(X_i - hat(a)_("MLE"))) = 0 \
    &<==> n/lambda - sum_(i = 0)^n (X_i - hat(a)_("MLE")) = 0 \
    &<==> n - lambda sum_(i = 0)^n (X_i - hat(a)_("MLE")) = 0 \
    &<==> hat(lambda)_("MLE") = n / (sum_(i = 0)^n (X_i - hat(a)_("MLE"))) \
  $,
)

Then, to check that this stationary point found is a maximum, we need to look at the second derivate of the log-likelihood according to $lambda$, which give us:

#align(
  left,
  $
    (partial^2 cal(l)(a, lambda)) / (partial lambda^2) &= partial / (partial lambda)(n/lambda - sum_(i = 0)^n (X_i - hat(a)_("MLE"))) \
    &= - n/lambda^2
  $,
)

As the second derivate is always negative since $n$ and $lambda$ are by definition positive numbers, this means that the log-likelihood function is concave, so the stationary point found is a maximum.

=== Simulation study

Let $a^star = 2$ and $lambda^star = 0.7$.


```python
# Generated by qwen3-coder:480b-cloud
# Reviewed and improved by me
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

def shifted_exponential_samples(a, lam, n_samples=100):
    """
    Generate samples from shifted exponential distribution
    """
    standard_exp_samples = np.random.exponential(scale=1/lam, size=n_samples)
    samples = standard_exp_samples + a
    return samples

def shifted_exponential_pdf(x, a, lam):
    """
    Probability density function of shifted exponential distribution
    """
    pdf_values = np.where(x >= a, lam * np.exp(-lam * (x - a)), 0)
    return pdf_values

def mom_estimators(samples):
    """
    Method of Moments estimators for shifted exponential distribution

    For Shifted Exp(a, λ):
    E[X] = a + 1/λ
    Var[X] = 1/λ²

    MoM estimations:
    λ_hat = 1/sqrt(sample_variance)
    a_hat = sample_mean - 1/λ_hat
    """
    sample_mean = np.mean(samples)
    sample_var = np.var(samples)  # Population variance for MoM

    # MoM estimator: λ based on variance
    lam_mom = 1 / np.sqrt(sample_var)

    # MoM estimator: a based on λ_mom
    a_mom = sample_mean - 1 / lam_mom
    return a_mom, lam_mom

def mle_estimators(samples):
    """
    Maximum Likelihood Estimators for shifted exponential distribution

    MLE equations:
    â = min(X₁, X₂, ..., Xₙ) (minimum of samples)
    λ̂ = n / Σ(Xᵢ - â)
    """
    n = len(samples)
    a_mle = np.min(samples)  # MLE of shift parameter
    lam_mle = n / np.sum(samples - a_mle)  # MLE of rate parameter

    return a_mle, lam_mle

# Parameters
true_a = 2.0        # true shift parameter
true_lam = 0.7      # true rate parameter
n_samples = 100
n_experiments = 5000

print("="*70)
print("SHIFTED EXPONENTIAL DISTRIBUTION")
print("="*70)
print(f"True parameters: a = {true_a}, λ = {true_lam}")
print(f"Sample size: {n_samples}")
print(f"Number of experiments: {n_experiments}")
print()

# Initialize arrays to store estimates
a_mom_estimates = np.zeros(n_experiments)
lam_mom_estimates = np.zeros(n_experiments)
a_mle_estimates = np.zeros(n_experiments)
lam_mle_estimates = np.zeros(n_experiments)

# Run experiments
for i in range(n_experiments):
    if (i + 1) % 1000 == 0:
        print(f"Completed {i + 1}/{n_experiments} experiments...")

    # Generate samples
    samples = shifted_exponential_samples(true_a, true_lam, n_samples)

    # Compute MoM estimators
    a_mom, lam_mom = mom_estimators(samples)
    a_mom_estimates[i] = a_mom
    lam_mom_estimates[i] = lam_mom

    # Compute MLE estimators
    a_mle, lam_mle = mle_estimators(samples)
    a_mle_estimates[i] = a_mle
    lam_mle_estimates[i] = lam_mle

print("All experiments completed!")
print()

# Calculate statistics
print("ESTIMATOR VALUES OVER 1 EXPERIMENTS:")
print("="*50)

print("Parameter 'a' estimators:")
print("-" * 30)
print(f"True value: {true_a}")
print(f"MoM: {a_mom_estimates[0]:.6f}")
print(f"MLE: {a_mle_estimates[0]:.6f}")
print()

print("Parameter 'λ' estimators:")
print("-" * 30)
print(f"True value: {true_lam}")
print(f"MoM: {lam_mom_estimates[0]:.6f}")
print(f"MLE: {lam_mle_estimates[0]:.6f}")
print()

# Create histograms
plt.figure(figsize=(15, 12))

# Histogram for 'a' parameter estimators
plt.subplot(1, 2, 1)
plt.axvline(true_a, color='green', linewidth=2, linestyle='--', label=f'True a = {true_a}')
plt.axvline(np.mean(a_mom_estimates), color='cyan', linewidth=2, linestyle='--', label=f'MoM mean = {np.mean(a_mom_estimates):.4f}')
plt.axvline(np.mean(a_mle_estimates), color='magenta', linewidth=2, linestyle='--', label=f'MLE mean = {np.mean(a_mle_estimates):.4f}')
plt.hist(a_mom_estimates, bins=50, alpha=0.7, color='blue', edgecolor='black', density=True, label='MoM')
plt.hist(a_mle_estimates, bins=50, alpha=0.7, color='red', edgecolor='black', density=True, label='MLE')
# Get some kind of zoom inside interesting zones
plt.xlim(true_a - 0.2, true_a + 0.2)
plt.xlabel('Estimated value of a')
plt.ylabel('Density')
plt.title('Empirical Distribution of Estimator for Parameter a')
plt.legend()
plt.grid(True, alpha=0.3)

# Histogram for 'λ' parameter estimators
plt.subplot(1, 2, 2)
plt.axvline(true_lam, color='green', linewidth=2, linestyle='--', label=f'True λ = {true_lam}')
plt.axvline(np.mean(lam_mom_estimates), color='cyan', linewidth=2, linestyle='--', label=f'MoM mean = {np.mean(lam_mom_estimates):.4f}')
plt.axvline(np.mean(lam_mle_estimates), color='magenta', linewidth=2, linestyle='--', label=f'MLE mean = {np.mean(lam_mle_estimates):.4f}')
plt.hist(lam_mom_estimates, bins=50, alpha=0.7, color='blue', edgecolor='black', density=True, label='MoM')
plt.hist(lam_mle_estimates, bins=50, alpha=0.7, color='red', edgecolor='black', density=True, label='MLE')
plt.xlabel('Estimated value of λ')
plt.ylabel('Density')
plt.title('Empirical Distribution of Estimator for Parameter λ')
plt.legend()
plt.grid(True, alpha=0.3)

plt.tight_layout()
plt.show()

# Summary comparison
print("SUMMARY COMPARISON:")
print("="*30)
print("For parameter 'a':")
print(f"  MoM Variance: {np.var(a_mom_estimates):.6f}")
print(f"  MLE Variance: {np.var(a_mle_estimates):.6f}")
print(f"  MLE has {(np.var(a_mom_estimates)/np.var(a_mle_estimates) - 1)*100:.1f}% smaller variance")
print()
print("For parameter 'λ':")
print(f"  MoM Variance: {np.var(lam_mom_estimates):.6f}")
print(f"  MLE Variance: {np.var(lam_mle_estimates):.6f}")
print(f"  MLE has {(np.var(lam_mom_estimates)/np.var(lam_mle_estimates) - 1)*100:.1f}% smaller variance")
print()
```


6. Generate a sample of size $n = 100$ from the shifted exponential with parameters $(a^star, lambda^star) = (0, 1)$, compute the two MoM estimators and the two MLE estimators, and report the values. Compare them and conclude.

  ```raw
  Parameter 'a' estimators:
  ------------------------------
  True value: 2.0
  MoM: 2.193838
  MLE: 2.006864

  Parameter 'λ' estimators:
  ------------------------------
  True value: 0.7
  MoM: 0.795522
  MLE: 0.692516
  ```
  We can see that the MLE estimator is more accurate than the MoM estimator for both $a$ and $lambda$.

  It is normal because the MLE estimator is based on a search of theoretical values that maximise the log-likelihood of the probability density function.
  It means that it will optimize the parameters to maximise the probability to have observed values near the given model.
  However the MoM estimator is simply based on correspondance between empirical and theoretical moments of the given model.
  In this way, since the objective is not to match the data to the model as closely as possible, the results are good, but not as good as those obtained with MLE, which attempts to match the data to the model as closely as possible by maximizing the likelihood of the data relative to the model.

7. Repeat the experiment $5000$ times and produce two histograms:
- the empirical distribution of the estimator of $a$,
- the empirical distribution of the estimator of $lambda$,
comparing Method of Moments and MLE. Print out the mean and variance of the two MoM estimators and the two MLE estimators over 5000 experiments.

#figure(caption: "Result of the 5000 experiments", image("img/hist.png")) <hist>

8. Interpret the results: which estimators appear more accurate? Which have lower variance? Give a short theoretical explanation for what you observe.

  As we can see on @hist, in both case MLE has a smaller variance than MoM.
  Indeed, variance of $hat(a)_("MoM")$ is $100$ times bigger than variance of $hat(a)_("MLE")$ and variance of $hat(lambda)_("MoM")$ is 2 times bigger than variance of $hat(lambda)_("MLE")$

  Furthermore, in both cases, the mean obtained by MLE estimator is closer to the real value than the mean obtained by the MoM estimator.

  This is due to the way MLE and MoM achieve estimations.
  MLE try to maximise the likelihood of the data relative to the model.
  On the contrary, MoM simply try to match the moments of the model with the empirical moments.
  In this way, some information is lost because only the two moments are taken into account, resulting in a loss of information contained in other moments of the model.
  This information is not lost during likelihood maximization, as this takes into account the entire likelihood function, which contains all the information contained in all moments of the model.

  So the MLE estimator method is better than the MoM estimator method because more informations are taken into account to make the estimations.

=== MGFs : the Gaussian example

In Part 1 you used raw moments via empirical formulas; here you see how MGFs let you get the moments of an important distribution in closed form. For instance, moments of the Gaussian distribution are not easy to obtain from the integral definition, because Gaussian integrals do not have elementary antiderivatives and require several algebraic manipulations.

To illustrate the usefulness of MGFs as a theoretical tool, consider

$ X ~ N(mu, sigma^2) , quad M_X(t) = exp(mu t + 1/2 sigma^2 t^2) . $

9. Using this MGF, compute $EE[X]$ and $EE[X^2]$ by differentiating $M_X(t)$ at $t = 0$, and verify that the variance of $X$ is $sigma^2$. (You may attempt the integrals directly to see why the MGF method is much simpler, but this is not required.)

  First, we will evaluate the first derivate of $M_X(t)$ according $t$ and evaluate it when $t = 0$ to obtain $EE[X]$.

  We have:

  #align(
    left,
    $
      (partial M_X(t)) / (partial t) & = partial / (partial t) exp(mu t + 1/2 sigma^2 t^2) \
                                     & = (mu + sigma^2t)exp(mu t + 1/2 sigma^2 t^2)
    $,
  )

  So when $t = 0$, we have:
  #align(
    left,
    $
      EE[X] & = (mu + sigma^2 dot 0)exp(mu dot 0 + 1/2 sigma^2 0^2) \
            & = mu exp(0) \
            & = mu
    $,
  )

  Now, to find the second moment of the function, we need to take the second derivate of $M_X(t)$ and evaluate it when $t = 0$.

  We have:

  #align(
    left,
    $
      (partial^2 M_X(t)) / (partial t^2) &= partial / (partial t) (mu + sigma^2t)exp(mu t + 1/2 sigma^2 t^2) \
      &= partial / (partial t) mu exp(mu t + 1/2 sigma^2 t^2) + partial / (partial t) sigma^2 t exp(mu t + 1/2 sigma^2 t^2) \
      &= mu (mu + sigma^2 t)exp(mu t + 1/2 sigma^2 t^2) + sigma^2 exp(mu t + 1/2 sigma^2 t^2) + sigma^2 t (mu + sigma^2 t) exp(mu t + 1/2 sigma^2 t^2) \
      &= ((mu + sigma^2 t)^2 + sigma^2)exp(mu t + 1/2 sigma^2 t^2) \
    $,
  )

  So when $t = 0$, we have:
  #align(
    left,
    $
      EE[X^2] & = ((mu + 0)^2 + sigma^2)exp(0) \
              & = mu^2 + sigma^2 \
    $,
  )

  So the variance give us:
  #align(
    left,
    $
      EE[(X - EE[X])^2] & = EE[X^2 - 2EE[X]X + EE[X]^2] \
                        & = EE[X^2] - 2EE[X]EE[X] + EE[X]^2 \
                        & = EE[X^2] - EE[X]^2 \
                        & = mu^2 + sigma^2 - mu^2 \
                        & = sigma^2
    $,
  )


10. Explain when MGFs can be useful.

As we can see, the MGFs is very useful to easily compute the moments of a function.
So it allows to easily extract each moments of the function and modelise the function with only a few moments.
So MGFs is very useful to simplify the real function and theoretical proof by simplifying a lot the computations, avoiding complex integrations.

#pagebreak()

= Chain rules for probabilities

For each of the 3 following chains of information, give the joint probability using the chain rule:

#figure(
  // caption: "Graphical model for X, Y, Z",
  gap: 1.5em,
  [
    #let color = rgb(255, 160, 210, 20%)      // rose pastel
    #diagram(
      node-corner-radius: 4pt,
      node-stroke: .01em,
      node-shape: circle,
      spacing: 2.5em,

      node((0, 0), [X], fill: color),
      node((2, 0), [Y], fill: color),
      node((4, 0), [Z], fill: color),

      edge((0, 0), (2, 0), "->"),
      edge((2, 0), (4, 0), "->"),
      edge((0, 0), (4, 0), "->", bend: 40deg),
    )
  ],
)

1.
  - $p(X, Y, Z) = p(X) dot p(Y | X) dot p(Z | X, Y)$
  - $p(X, Z) = p(X) dot p(Z)$
  - $p(X, Y) = p(X) dot p(Y | X)$
  - $p(Y, Z) = p(Y) dot p(Z | Y)$

#figure(
  gap: 1.5em,
  [
    #let color = rgb(255, 160, 210, 20%)      // rose pastel
    #diagram(
      node-corner-radius: 20pt,
      node-stroke: .01em,
      node-shape: circle,
      spacing: 2.5em,

      node((0, -1), [$X_1$], fill: color),
      node((0, 1), [$X_2$], fill: color),
      node((2, 0), [$X_3$], fill: color),
      node((4, -1), [$X_4$], fill: color),
      node((4, 1), [$X_5$], fill: color),
      node((6, 0), [$X_6$], fill: color),
      node((8, 0), [$X_7$], fill: color),

      edge((0, -1), (2, 0), "->"),
      edge((0, 1), (2, 0), "->"),
      edge((2, 0), (6, 0), "->"),
      edge((4, -1), (6, 0), "->"),
      edge((4, 1), (6, 0), "->"),
      edge((6, 0), (8, 0), "->"),
    )
  ],
)

2.
  - $p(X_1, X_2, X_3, X_4, X_5, X_6, X_7) = p(X_1) dot p(X_2) dot p(X_3 | X_1, X_2) dot p(X_4) dot p(X_5) dot p(X_6 | X_5, X_4, X_3) dot p(X_7 | X_6)$
  - $p(X_1, X_3, X_5, X_7) = sum_(X_2) sum_(X_4) sum_(X_6) p(X_1, dots, X_7) = p(X_1) dot p(X_3 | X_1) dot p(X_5) dot p(X_7 | X_5, X_3)$
  - $p(X_2, X_4, X_6, X_7) = p(X_2) dot p(X_4) dot p(X_6 | X_2, X_4) dot p(X_7 | X_6)$
  - $p(X_3, X_6, X_7) = p(X_3) dot p(X_6 | X_3) dot p(X_7 | X_6)$
  - $p(X_1, X_2, X_4, X_5) = p(X_1) dot p(X_2) dot p(X_4) dot p(X_5)$

#figure(
  caption: "Complex graphical model for X₁ to X₇",
  gap: 1.5em,
  [
    #let color = rgb(255, 160, 210, 20%)      // rose pastel
    #diagram(
      node-corner-radius: 20pt,
      node-stroke: .01em,
      node-shape: circle,
      spacing: 2.5em,

      node((0, -1), [$X_1$], fill: color),
      node((0, 1), [$X_2$], fill: color),
      node((2, 0), [$X_3$], fill: color),
      node((4, -1), [$X_4$], fill: color),
      node((4, 1), [$X_5$], fill: color),
      node((6, 0), [$X_6$], fill: color),
      node((8, 0), [$X_7$], fill: color),

      edge((0, -1), (2, 0), "->"),
      edge((0, 1), (2, 0), "->"),
      edge((0, 1), (4, 1), "->"),
      edge((2, 0), (6, 0), "->"),
      edge((4, -1), (6, 0), "->"),
      edge((8, 0), (4, -1), "->"),
      edge((4, 1), (6, 0), "->"),
      edge((6, 0), (8, 0), "->"),
    )
  ],
)

3.
  - $p(X_1, X_2, X_3, X_4, X_5, X_6, X_7) = p(X_1) dot p(X_2) dot p(X_3 | X_1, X_2) dot p(X_4 | X_7) dot p(X_5 | X_2) dot p(X_6 | X_5, X_4, X_3) dot p(X_7 | X_6)$
  - $p(X_1, X_3, X_5, X_7) = sum_(X_2) sum_(X_4) sum_(X_6) p(X_1, dots, X_7) = p(X_1) dot p(X_3 | X_1) dot p(X_5) dot p(X_7 | X_5, X_3)$
  - $p(X_2, X_4, X_6, X_7) = p(X_2) dot p(X_4 | X_7) dot p(X_6 | X_4, X_2) dot p(X_7 | X_6)$
  - $p(X_3, X_6, X_7) = p(X_3) dot p(X_6 | X_3) dot p(X_7 | X_6)$
  - $p(X_1, X_2, X_4, X_5) = p(X_1) dot p(X_2) dot p(X_4 | X_1, X_2, X_5) dot p(X_5 | X_2)$

= Problem: information quantifiers

U, V and W are three binary random variables. Their joint probability mass function is depicted as below:

#figure(
  table(
    columns: 4,
    align: center,
    stroke: none,
    table.hline(),
    table.header([U], [V], [W], [$p_(U, V, W)(u,v,w)$]),
    table.hline(),
    table.vline(x: 3, start: 1),
    [0], [0], [0], [$1/4$],
    [0], [0], [1], [$0$],
    [0], [1], [0], [$1/4$],
    [0], [1], [1], [$1/8$],
    [1], [0], [0], [$0$],
    [1], [0], [1], [$1/8$],
    [1], [1], [0], [$0$],
    [1], [1], [1], [$1/4$],
    table.hline(),
  ),
)

Calculate the information measures below:

1. $H(U)$, $H(V)$ and $H(W)$
  - $p_U(u = 0) = sum_(v in V) sum_(w in W) p_(U, V, W)(u = 0, v, w) = 1/4 + 0 + 1/ 4 + 1/8 = 5/8$
  - $p_U(u = 1) = 1 - p_U(u = 0) = 1 - 5/8 = 3/8$
  - $p_V(v = 0) = sum_(u in U) sum_(w in W) p_(U, V, W)(u, v = 0, w) = 1/4 + 0 + 0 + 1/8 = 3/8$
  - $p_V(v = 1) = 1 - p_V(v = 0) = 1 - 3/8 = 5/8$
  - $p_W(w = 0) = sum_(u in U) sum_(v in V) p_(U, V, W)(u, v, w = 0) = 1/4 + 1/4 + 0 + 0 = 1/2$
  - $p_W(w = 1) = 1 - p_W(w = 0) = 1 - 1/2 = 1/2$

  So we have:

  - $H(U) = - sum_(u in U)p_U(u)log_2(p_U(u)) = -5/8 log_2(5/8) - 3/8 log_2(3/8) approx 0.95$
  - $H(V) = - sum_(v in V)p_V(v)log_2(p_V(v)) = -5/8 log_2(5/8) - 3/8 log_2(3/8) approx 0.95$
  - $H(W) = - sum_(w in W)p_W(w)log_2(p_W(w)) = -1/2 log_2(1/2) - 1/2 log_2(1/2) = 1$

2. $H(U | V)$, $H(V | U)$ and $H(W | U)$


  - $H(U | V) &= H(U, V) - H(V) \
    &= -sum_(u in U) sum_(v in V) p_(U, V)(u, v) log_2(p_(U, V)(u, v)) - H(V) \
    &= - 1/4 log_2(1/4) - 3/8 log_2(3/8) - 1/8 log_2(1/8) - 1/4 log_2(1/4) - H(V) \
    &approx 1.9 - 0.95 \
    &approx 0.95 \ $


  - $H(V | U) & = H(U, V) - H(U) \
    & = H(U | V) + H(V) - H(U) \
    & approx 0.95 + 0.95 - 0.95 \
    & approx 0.95 \ $


  - $H(U | W) & = H(U, W) - H(W) \
    & = -sum_(u in U) sum_(w in W)p_(U, W)(u, w) log_2(p_(U, W)(u, w)) - H(W) \
    & = -1/2 log_2(1/2) - 1/8 log_2(1/8) - 0 - 3/8 log_2(3/8) - 1 \
    & approx 1.4 - 1 \
    & approx 0.4 \ $

3. $I(U; V)$, $I(U; W)$ and $I(V; W)$

  - $I(U; V) &= H(U) - H(U | V) \
    &approx 0.95 - 0.95 \
    &approx 0 \ $
  - $I(U; W) &= H(U) - H(U | W) \
    &approx 0.95 - 0.4 \
    &approx 0.55 \ $
  - $I(V; W) &= H(V) + H(W) - H(V | W) \
    &= H(V) + H(W) - (H(V, W) - H(W)) \
    &= H(V) + 2H(W) - H(V, W) \
    &= H(V) + 2H(W) + sum_(v in V) sum_(w in W) p_(V, W)(v, w) log_2(p_(V, W)(v, w)) \
    &= H(V) + 2H(W) + 1/4 log_2(1/4) + 1/8 log_2(1/8) + 1/4 log_2(1/4) + 3/8 log_2(3/8)\
    &approx 0.95 + 2 - 1.9 \
    &approx 1.05$

4. $H(U, V, W)$

  We have:
  $
    H(U, V, W) & = -sum_(u in U) sum_(v in V) sum_(w in W) p_(U, V, W) (u, v, w) log_2(p_(U, V, W)(u, v, w)) \
               & = - 3 dot 1/4 log_2(1/4) - 2 dot 1/8 log_2(1/8) \
               & = 3/2 + 3/4 \
               & = 2.25
  $

  For each of the above items you could directly use the definition. However, because they are related to each other in many ways, you could calculate some of them and derive the rest by using their relations: chain rules for entropy and mutual information, the Venn diagrams.

= Problem: Source Coding

We study a binary memoryless source $X$, where

$ P(X=1) = theta = 0.1 , quad P(X=0) = 0.9 . $

== Tasks

1. Data Generation:
  - Generate $n = 10,000$ binary samples.
  - Group them into symbols of length 5 (2000 total symbols).
  - Count the frequency of each symbol.

    ```py
    import numpy as np
    from dahuffman import HuffmanCodec

    samples = np.random.rand(2000, 5)
    samples[samples >= 0.9] = 1
    samples[samples < 0.9] = 0
    samples = ["".join(str(int(elem)) for elem in row) for row in samples]

    symbols, frequencies = np.unique(samples, axis=0, return_counts=True)
    print(f"Frequency of each symbol: {frequencies}")
    ```
    ```raw
    Frequency of each symbol: [1185  140  113   13  137   18   13  130   16   11    2   11    3  133  18   17    1   17    2    2   13    1    1    3]
    ```

2. Huffman Coding:
  - Build a Huffman code (e.g. with `dahuffman`) using the symbol frequencies.
  - Encode the sequence and record its total length in bits.
    ```py
    codec = HuffmanCodec.from_frequencies(dict(zip(symbols, list(frequencies))))
    encoded = codec.encode(samples)
    print(f"Number of bits used for encoding: {len(encoded)}")
    ```
    ```raw
    Number of bits used for encoding: 594
    ```

3. Entropy and Efficiency:
  - Compute the theoretical entropy $H(X)$.
    $H(X) = - sum_X P(X) log_2(P(X)) = - 0.1 log_2(0.1) - 0.9 log_2(0.9) approx 0.468995593$
  - Compute the average Huffman code length:

  $ L = "encoded length (bits)"/"number of symbols" = 594/2000 = 0.297 $

  - Compare $H(X)$ and $L$. Comment on compression efficiency.

    Here the entropy indicate the number of bits needed to encode the variable created by the probability rule.
    So it means that we need an average of 0.469 bits per binary sample to encode the most efficiently the binary sequence in a brute force way.
    However, if we look at the Huffman coding, we can constate that only 0.297 bits are needed to encode a binary sample.
    So it means that the Huffman coding, by switching the representation of the sequence in a more intelligent way using frequencies of each symbols, allows a compression of the sequence.
    Indeed the efficiency of the Huffman coding with only 0.297 bits needed for a sample is better than the base entropy of 0.469 bits per sample.

    So it is very important for compression to use a good representation of the data in such a way an intelligent encoding can be achieved to reduce number of bits needed to properly encode the data.

= (*optional*) Problem: Communication System with Noise

We send a binary sequence through a channel with additive white Gaussian noise (AWGN).

== System Setup

- A '1' is transmitted as amplitude $A = 1$, a '0' as $A = 0$.
- Each bit is repeated $N$ times ($N = 10$ at first).
- The channel adds Gaussian noise $z[n] ~ N(0, sigma_z^2)$ with $sigma_z^2 = 1.5$.

== Tasks

1. Signal Generation: Generate $k = 10,000$ random bits, build the transmitted signal $x[n]$, and add AWGN to get $y[n]$.

  ```py
  import numpy as np

  random_bits = np.random.randint(0, 2, size=(10000, 1))
  signal = random_bits @ np.ones(10)
  signal = signal.ravel()

  noise = np.random.normal(loc=0, scale=np.sqrt(1.5), size=signal.shape[0])
  transmitted_signal = (signal + noise).astype(int)
  ```

2. Detection Rules:
  - Derive the Neyman-Pearson rule with false alarm $P_("FA") = 0.01$.

    We consider that $x[n]$ is the signal to transmit and $z[n]$ is the noise added to the signal, that give us $y[n] = x[n] + z[n]$.

    If we consider $H_0$ as the hypothesis "bit 0 is transmitted" and $H_1$ as the hypothesis "bit 1 is transmitted", we have

    $
      P(y[n]; H_0) = underbrace(x[n], "=0 due to "H_0) + z[n] = z[n] = 1/(sqrt(2 pi sigma_z^2))exp^(-(y[n] - 0)^2/(2sigma_z^2))
    $
    and
    $
      P(y[n]; H_1) = underbrace(x[n], "=1 due to "H_1) + z[n] = 1/(sqrt(2 pi sigma_z^2))exp^(-(y[n] - 1)^(2^#report-footnote[Here we have $y[n] - 1$ because we add some gaussian noise $z[n] ~ N(0, sigma_z^2)$ to an amplitude of $1$ meaning that the mean of the resulting distribution is $1$]))/(2sigma_z^2))
    $
    According to the definition of Neyman-Pearson, to maximise $P_D$ for a given $P_(F A) = alpha$, decide $H_1$, if:
    $ L(x) = p(x; H_1) / p(x; H_0) > gamma $
    where the threshold $gamma$ is found from:
    $ P_(F A) = integral_(x:L(x) > gamma) p(x; H_0) d x = alpha $
    In our case, we have $P_(F A) = 0.01$ and $x = y[n]$.
    So we have:
    $
      L(x) &= (P(y[n]; H_1)) / (P(y[n]; H_0)) > gamma \
      &= (1/(sqrt(2 pi sigma_z^2))exp^(-(y[n] - 1)^2/(2sigma_z^2))) / (1/(sqrt(2 pi sigma_z^2))exp^(-y[n]^2/(2sigma_z^2))) > gamma \
      &= exp^(y[n]^2/(2sigma_z^2) - (y[n] - 1)^2/(2sigma_z^2)) > gamma \
      &= exp^(1/ (2sigma_z^2) (y[n]^2 - y[n]^2 + 2y[n] - 1)) > gamma \
      &= exp^(1/ (2sigma_z^2) (2y[n] - 1)) > gamma \
      &= exp^((2y[n] - 1)/ 3) > gamma \
    $
  - Derive the Bayesian rule assuming $P(H_0) = P(H_1) = 0.5$.
  - Report both thresholds $gamma_("NP")$ and $gamma_("Bayes")$. Compare them.


3. Apply Detection: Use both rules to estimate the received bits. Compare with the original sequence.


Write your solution here

4. Visualization: Plot $x[n]$, $y[n]$, and the estimated $hat(x)[n]$. Zoom in on 100 samples to see the noise effect.


Write your solution here

5. Performance: Compute empirical $P_M$ (miss), $P_(F A)$ (false alarm), and $P_e$ (total error). Compare with theoretical values.


Write your solution here

6. Effect of $N$: Vary $N$ from 1 to 100. Plot how $P_M$, $P_(F A)$, and $P_e$ change for both detection rules. Explain why larger $N$ improves detection.


Write your solution here

#pagebreak()

= (Small project *(optional)*) When moment matching fails

In this section we study a simple nonlinear simulator and investigate how different moment-matching losses behave in practice.

Consider the generator

$ X = g_theta(Z) = theta_0 + theta_1 Z^2 + theta_2 Z^5 , quad Z ~ N(0,1) , $

with true parameters

$ theta^star = (2, 0.7, 0.05) . $

=== Data generation

Generate $n = 10,000$ samples $X_1, dots, X_n$ from the model using the true parameters. Keep these samples fixed for all subsequent experiments (i.e. do not regenerate new data each iteration).

=== (b) Optimization

Let $theta = (theta_0, theta_1, theta_2)$ be a trainable parameter vector in PyTorch, initialized at

$ theta^((0)) = (1.6, 0.7, 0.01) . $

Use the Adam optimizer with learning rate $10^(-3)$. At each iteration, draw a fresh batch $Z ~ N(0,1)$ of size 1024 and compute $X_("model") = g_theta(Z)$.

Unless stated otherwise, run all experiments below for $10,000$ iterations.

Train the parameter vector $theta$ using the following losses, one at a time:

1. *Match only the mean*:

$ L_1 = (EE[X_("model")] - EE[X_("data")])^2 . $

2. *Match mean and variance*:

$ L_2 = (EE[X_("model")] - EE[X_("data")])^2 + ("Var"(X_("model")) - "Var"(X_("data")))^2 . $

3. *Match mean, variance, and 5th central moment*:

$ L_3 = L_2 + (EE[(X_("model") - EE[X_("model")])^5] - EE[(X_("data") - EE[X_("data")])^5])^2 . $

After training with each loss, record the final value of $theta$.

=== Kernelized moment matching (MMD)

Define the Gaussian kernel

$ k(x,y) = exp(-(x-y)^2/(2 sigma^2)) , quad sigma = 2 . $

Define the empirical squared MMD between two batches $x$ and $y$ as

$ "MMD"^2(x,y) = 1/m^2 sum_(i,j) k(x_i,x_j) + 1/m^2 sum_(i,j) k(y_i,y_j) - 2/m^2 sum_(i,j) k(x_i,y_j) . $

```python
  def rbf_kernel(x, y, sigma=1.0):
      x = x.view(-1, 1)
      y = y.view(1, -1)
      diff2 = (x - y)**2
      return torch.exp(-diff2 / (2 * sigma**2))

  def mmd_squared(x, y, sigma=1.0):
      Kxx = rbf_kernel(x, x, sigma)
      Kyy = rbf_kernel(y, y, sigma)
      Kxy = rbf_kernel(x, y, sigma)
      m = x.shape[0]
      n = y.shape[0]
      return Kxx.mean() + Kyy.mean() - 2 * Kxy.mean()
```

Now train $theta$ by minimizing

$ L_("MMD") = "MMD"^2(X_("data"), X_("model")) . $

Record the final value of $theta$.

=== Empirical comparison

For each loss $L_1$, $L_2$, $L_3$, and $L_("MMD")$:

Generate $10,000$ new samples from $g_theta(Z)$ using the trained parameter vector.
Plot a histogram of this model-generated sample along with a histogram of the real data sample.
Compare the fitted parameter vector $theta$ with the true value $theta^star$.
```python
_, bins, _ = plt.hist(
    x_data.numpy(), bins=50, density=True,
    alpha=0.5, label="data"
)
plt.hist(
    x_model_final.numpy(), bins=bins, density=True,
    alpha=0.5, label="model (MMD trained)"
)
```

=== Interpretation

Provide a concise discussion:

- Which losses successfully recover $(theta_0, theta_1)$?
- What happens when including the 5th central moment? Why does this lead to unstable training or incorrect $theta_2$?
- Why does the MMD loss (implicitly matching infinitely many smooth bounded moments) produce stable and accurate estimates?
- How does this illustrate the general difference between matching raw high-order moments and using smooth kernel-based moments?
