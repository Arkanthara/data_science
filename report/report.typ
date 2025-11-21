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
      & = limits(integral)_(0)^(infinity) y lambda e^(-lambda y) d y + a limits(integral)_(0)^(infinity) lambda e^(-lambda y) d y \
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
      & = limits(integral)_(0)^(+ infinity) y^2 lambda e^(-lambda y) d y - 2 limits(integral)_(0)^(+ infinity) y e^(-lambda y) d y + 1 / lambda limits(integral)_(0)^(+ infinity) e^(-lambda y) d y^#report-footnote[We know from previous computation that $integral_0^infinity e^(-lambda y) d y = 1 / lambda$]\
      & = [-y^2 e^(- lambda y)]_0^infinity + limits(integral)_(0)^(+ infinity) e^(-lambda y) d y - 2 ([-y e^(-lambda y)]_0^infinity + limits(integral)_(0)^(+ infinity) e^(-lambda y) d y) + 1 / lambda^2 \
      & = 1 / lambda - 2 / lambda + 1 / lambda^2 \
      & = 1 / lambda (1 / lambda - 1)
    $],
  )



2. Let

$ overline(X)_n = 1/n sum_(i=1)^n X_i , quad S_n^2 = 1/n sum_(i=1)^n (X_i - overline(X)_n)^2 $

be the empirical mean and (non-unbiased) variance. Set the theoretical moments equal to the empirical ones and solve this system to obtain the moment estimators $hat(a)_("MoM")$ and $hat(lambda)_("MoM")$.

Write your solution here

=== Maximum Likelihood Estimation

3. Write the log-likelihood $ℓ(a, lambda)$ of the sample.

Write your solution here

4. Show that the MLE of $a$ is $hat(a)_("MLE") = min_i X_i$.

Write your solution here

5. Derive the corresponding MLE $hat(lambda)_("MLE")$ by maximizing the log-likelihood w.r.t. $lambda$.

Write your solution here

=== Simulation study

Let $a^star = 2$ and $lambda^star = 0.7$.

6. Generate a sample of size $n = 100$ from the shifted exponential with parameters $(a^star, lambda^star) = (0, 1)$, compute the two MoM estimators and the two MLE estimators, and report the values. Compare them and conclude.

Write your solution here

7. Repeat the experiment $5000$ times and produce two histograms:
- the empirical distribution of the estimator of $a$,
- the empirical distribution of the estimator of $lambda$,
comparing Method of Moments and MLE. Print out the mean and variance of the two MoM estimators and the two MLE estimators over 5000 experiments.

Write your solution here

8. Interpret the results: which estimators appear more accurate? Which have lower variance? Give a short theoretical explanation for what you observe.

Write your solution here

=== MGFs : the Gaussian example

In Part 1 you used raw moments via empirical formulas; here you see how MGFs let you get the moments of an important distribution in closed form. For instance, moments of the Gaussian distribution are not easy to obtain from the integral definition, because Gaussian integrals do not have elementary antiderivatives and require several algebraic manipulations.

To illustrate the usefulness of MGFs as a theoretical tool, consider

$ X ~ N(mu, sigma^2) , quad M_X(t) = exp(mu t + 1/2 sigma^2 t^2) . $

9. Using this MGF, compute $EE[X]$ and $EE[X^2]$ by differentiating $M_X(t)$ at $t = 0$, and verify that the variance of $X$ is $sigma^2$. (You may attempt the integrals directly to see why the MGF method is much simpler, but this is not required.)

Write your solution here

10. Explain when MGFs can be useful.

#pagebreak()

= Chain rules for probabilities

For each of the 3 following chains of information, give the joint probability using the chain rule:

1.
$ p(X, Y, Z) = dots ? $" Write your solution here" \
$ p(X, Z) = dots ? $" Write your solution here" \
$ p(X, Y) = dots ? $" Write your solution here" \
$ p(Y, Z) = dots ? $" Write your solution here"

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

2.
$ p(X_1, X_2, dots, X_7) = dots ? $" Write your solution here" \
$ p(X_1, X_3, X_5, X_7) = dots ? $" Write your solution here" \
$ p(X_2, X_4, X_6, X_7) = dots ? $" Write your solution here" \
$ p(X_3, X_6, X_7) = dots ? $" Write your solution here" \
$ p(X_1, X_2, X_4, X_5) = dots ? $" Write your solution here"

#figure(
  caption: "Graphical model for X₁ to X₇",
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

3.
$ p(X_1, X_2, dots, X_7) = dots ? $" Write your solution here" \
$ p(X_1, X_3, X_5, X_7) = dots ? $" Write your solution here" \
$ p(X_2, X_4, X_6, X_7) = dots ? $" Write your solution here" \
$ p(X_3, X_6, X_7) = dots ? $" Write your solution here" \
$ p(X_1, X_2, X_4, X_5) = dots ? $" Write your solution here"

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


Write your solution here

2. $H(U | V)$, $H(V | U)$ and $H(W | U)$


Write your solution here

3. $I(U; V)$, $I(U; W)$ and $I(V; W)$


Write your solution here

4. $H(U, V, W)$


Write your solution here

For each of the above items you could directly use the definition. However, because they are related to each other in many ways, you could calculate some of them and derive the rest by using their relations: chain rules for entropy and mutual information, the Venn diagrams.

= Problem: Source Coding

We study a binary memoryless source $X$, where

$ P(X=1) = theta = 0.1 , quad P(X=0) = 0.9 . $

== Tasks

1. Data Generation:
- Generate $n = 10,000$ binary samples.
- Group them into symbols of length 5 (2000 total symbols).
- Count the frequency of each symbol.


Write your solution here

2. Huffman Coding:
- Build a Huffman code (e.g. with `dahuffman`) using the symbol frequencies.
- Encode the sequence and record its total length in bits.


Write your solution here

3. Entropy and Efficiency:
- Compute the theoretical entropy $H(X)$.
- Compute the average Huffman code length:

$ L = "encoded length (bits)"/"number of symbols" . $

- Compare $H(X)$ and $L$. Comment on compression efficiency.


Write your solution here

= Problem: Communication System with Noise

We send a binary sequence through a channel with additive white Gaussian noise (AWGN).

== System Setup

- A '1' is transmitted as amplitude $A = 1$, a '0' as $A = 0$.
- Each bit is repeated $N$ times ($N = 10$ at first).
- The channel adds Gaussian noise $z[n] ~ N(0, sigma_z^2)$ with $sigma_z^2 = 1.5$.

== Tasks

1. Signal Generation: Generate $k = 10,000$ random bits, build the transmitted signal $x[n]$, and add AWGN to get $y[n]$.


Write your solution here

2. Detection Rules:
- Derive the Neyman-Pearson rule with false alarm $P_("FA") = 0.01$.
- Derive the Bayesian rule assuming $P(H_0) = P(H_1) = 0.5$.
- Report both thresholds $gamma_("NP")$ and $gamma_("Bayes")$. Compare them.


Write your solution here

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
