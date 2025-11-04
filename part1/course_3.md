## Questions

### Explain how PCA uses variance as a criterion

PCA uses variance as criterion because variance measure the quantity of information.
Then PCA will try to maximise the quantity of information on each axis.
Finally, if there is no variance on the last dimensions, we can delete it.... (look at eigen value spectrum !!! Then we can fix a noise threshold to indicate that we cut when we are under the noise threshold)
(! Use incremental method to find eig to find only the K eigen vectors usefull !)
It allow to decorelate datas !
Covariance matrix on result is diagonal with only eigen values !!!

### Show that variance maximization is equivalent to error minimization

Maximize projection minimize error according to Pythagore (with constant hypotenuse)
(It's a quadratic regression because of minimization of error ! Not sure I've all understood)

### Show how PCA uses the Eckart-Young theorem

If I have any matrix and I want to limit it's rank to K, the projection to the rank will be $\Sigma_K$ and this can be simplified to limit spectrum to the K first eigen values of the Covariance matrix $\Sigma_K$.

$$\Sigma_K = U_K \Lambda_K U_K^T$$

Transform in 2 directions:
$y = U^T_K x$ and $x = U_KU^T_Kx + \bar{x}$

The approximation is given by:

$$|| \Sigma - \Sigma_K ||_F^2 = \sum_{d = K + 1}^D \lambda_d$$

### Given some data, how do you apply PCA?

- Compute mean
- Center data
- Compute covariance
- Select number of components
- Project data on new space

Choice of K ?

### What information does it provide you with?

Show how much data is correlated



### How do you reconstruct data with K < D components?

Transform in 2 directions:
$y = U^T_K (x - \bar{x})$ and $x = U_KU^T_K(x + \bar{x})$

### How do you select the components to keep?

The first components of the covariance matrix have the most informations.

If we look at the eigenspectrum, we can see that it's decreasing.

As information is contained in $\lambda$, we can keep all dimensions with great $\lambda$ and forget all the rest that brings not a lot of informations,
which correspond to cut the covariance matrix $\Sigma$ at the $k$ element: $\Sigma_K = U_K \Lambda_K U_K^T$

The rest is considered like gaussian noise.

### Can you apply PCA on any data?
### Is it relevant to apply PCA on any data?

PCA is not relevant for non-Gaussian data because it assumes the fact that the Gaussian distribution is the distribution that fit the best our real distribution.

### How can I apply PCA over clustered data?

Apply PCA on each clustered data

### Show that PCA is equivalent to a linear AE

Linear AutoEncoder

We train our network to be closest to the original input.

If we remove a neuron, we will try to reconstruct our data as closest as possible than the original representation.

When we train our new network, we will basically retrieve PCA.

The loss = $||x_i - \tilde{x_i}||_2$

###

PCA: linear operation

We'll find new set of dimensions to best look after our datas

Use variance as criterion because if the variance is null in a direction, we can delete this direction but first, we must map data thanks to PCA to another set of dimensions that make more sense...

PCA: map data with base created around the direction of the maximal variance of the set of datas...

$cos \theta = \frac{x^t}{||x||}\frac{u}{||u||}$

v_{u1} = covariance of projected data = $u_1^T\Sigma u_1$

$u_1 = argmax u_1^T\Sigma \frac{1}{||u||^2}$ if we write this, we are more interested to the length than to the direction because small values of $u$ will
give some big values !!! So we prefer to write only a condition $u_1^Tu = 1 = ||u_1||^2 = ||u_1||$....

Lagrangian: function + \lambda * zero constraint


first direction = first eigen vector with the higest eigen value of the covariance matrix !!!!

Tr(\Lambda) = \sum \lambda_i = Tr(U^T\SigmaU) = Tr(U^TU \Sigma) (invariance of Trace) = Tr(\Sigma) (because U and U^T are orthogonal => U^TU = 0)

1. centering x - \bar{x}
2. rotate u^T(x - \bar{x})
3. scaling using \Lambda^{1/2}

$\Lambda = U^T \Sigma U \Longleftrightarrow U \Lambda U^T = U U^T \Sigma U U^T \Longleftrightarrow U \Lambda^{1/2}\Lambda^{1/2} U^T$
$U\Lambda^{1/2}$ is our transform...

PCA is an exact transform (we can revert it !!)

### Next course

Recal:

$$
Cov(X) = \frac{1}{n - 1} (X - \bar{X})^T (X - \bar{X})
$$


$$
Var(x) = \frac{1}{n - 1} (x - \bar{x})^T (x - \bar{x})
$$

When $X = X - \bar{X}$,
$$Var(X) = \frac{1}{N} \sum_i^N (x_i - \bar{x})^T(x_i - \bar{x}) = \frac{1}{N} \sum_i^N x_i^T x_i = \frac{1}{N} X X^T = \text{Covariance matrix of the centered data}$$

### **Variance vs. Covariance (Matrix Form)**

#### **1. Variance**

Variance measures how much the values of a single variable deviate from their mean.

In matrix form, for a column vector $x \in \mathbb{R}^{n \times 1}$:

$$
\mathrm{Var}(x) = \frac{1}{n - 1} (x - \bar{x})^T (x - \bar{x})
$$

Where:
- $\bar{x} = \frac{1}{n} \mathbf{1}^T x$ is the mean of $x$ (with $\mathbf{1}$ being a vector of ones).

#### **2. Covariance**

Covariance measures how two or more variables change together.

For a data matrix $X \in \mathbb{R}^{n \times p}$ (where each row is an observation and each column a variable):

$$
\mathrm{Cov}(X) = \frac{1}{n - 1} (X - \bar{X})^T (X - \bar{X})
$$

Where:
- $\bar{X} \in \mathbb{R}^{n \times p}$ is the matrix where each row is the mean vector of the columns of $X$.
- Alternatively, if $\mu \in \mathbb{R}^{1 \times p}$ is the row vector of column means, then:
  $$
  \bar{X} = \mathbf{1} \mu
  $$

#### **3. Key Relationship**

Variance is a special case of covariance when the variable is compared with itself:

$$
\mathrm{Var}(x) = \mathrm{Cov}(x, x)
$$

#### **4. Summary of Differences**

- Variance describes the **spread** of one variable.
- Covariance describes the **linear relationship** between **two or more variables**.
- Variance is always **non-negative**, while covariance can be **positive, negative, or zero**.

We are sampling data to a normal distribution of mean $\bar{x}$

I have a distribution... I compute the mean and the variance.
I sample $X$ to $X'$ with the only constraint that Var($X$) = Var($X'$)


When we compute mean and variance of our data, we try to fit it to a gaussian distribution that fit the best my datas

We assume the fact that the gaussian distribution is enough to represent all my datas....

The moments is like the harmonic distribution of our datas
