= Problem of interest

- information extraction (from pictures, audio, ... Method stay the same for each kind of data)
  - steganography: the goal is to keep all secret and information is hidden != cryptography
- mining
- recognition and classification (not only recognition, but also authentification... Is it true or not ?? -> binary classification)
- search and identification (organize data in such a way we can retrieve information... How it was made before ??? Today ??? Tomorrow ???)
- transmission and compression (smart strategy to store data)

Covariance matrix is symetric => EVD !!!
For instance, a pixel is very correlated to others.
Information are concentrated in first eigen values...
More correlation => eigen values decrease more fastly !!!
DCT transform is very fast to compute !!!
For real images, PCA tends to DCT

PCA is linear because it is only linear multiplication !
DCT vs deeplearning: easy to compute ! efficient ! deeplearning is very expansive, need some train to each dataset, time consuming etc...

- $p$ is for discrete domain. Its the probability mass function
- $f$ is for continuous domain. Its the probability density function
// #note[we must make integral in continuous domain of the $f$ function to have probability]

Be careful with llm !!! Its the most dummy system in the world.... If not trained on something, it can make nimporte quoi !!!
Quantization: go from continuous to discrete domain

- Gaussian distribution for continuous
- Binomial distribution for discrete

== Moments

Discrete vs continuous domain

== Characteristic function

$\phi(t) = \int_{-\inf}^{\inf}f(x)e^{jtx}dx = \mathbb{E}_{f(x)}[e^{jtX}]$

pdf can be recovered as

$f(x) = \frac{1}{2\pi}\int_{-\inf}^{\inf}\phi(t)e^{-jtx}dt$

=== Moment generating function of pdf

$M(t) = \mathbb{E}_{f(x)}[e^{tX}]$

We cant reconstruct function from moments...

Compute pdf, then moments of pdf for an image... If no imaginary part, its generated !!
