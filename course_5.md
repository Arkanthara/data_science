# Linear Discriminant Analysis

Supervised latent analysis

# Explain the setup of supervised learning

We want to optimize parameter $\theta$ such as $\theta$ minimise the loss of the training set.

$\phi_{\theta}: \Omega \longrightarrow y$
$x_i \longrightarrow \phi_{\theta}(x_i) = \tilde{y}$

# Why is LDA a linear method?

A linear discrimination is made for each cluster (each cluster is separated from other with a linear function)

We want to draw a decision function that is linear.

LDA is optimal for gaussian model, but not for other kind of models with non-linear relationships...

Every transformation is linear => linear method !!

# What characterizes a discriminant direction? What does a represent?

We characterize the plane by it's orthogonal vector $a$ (1D !!)

dim(plane) = D - 1 and dim($a$) = 1 P = a \ortho

P = {$V \in \mathbb{D}, \langle a, v \rangle = 0$}

Projection of data on $a$ must be distinct to have good predictions !!!



# What is the Fisher criteria?

Fisher criteria maximises inter class divided by intra class, so 

$$\frac{||\hat{\mu_1} - \hat{\mu_2}||^2}{\hat{\sigma_1}^2 + \hat{\sigma_2}^2}$$

# What is the inter-class (between) criteria? Explain its principle

We want a line of projection that maximise the distance between means !
The projected mean is the same than the mean of the projected data !!!!

$$||\hat{\mu_1} - \hat{\mu_2}||^2 = ||  \frac{a^T\mu_1}{||a||^2}a - \frac{a^T\mu_2}{||a||^2}a||^2 = \frac{1}{||a||^2}(a^T(\mu_1 - \mu_2))^2$$

$a = \lambda(\mu_1 - \mu_2)$

So $a$ must be colinear to the line $\mu_1 - \mu_2$ !!!

# How to compute the inter-class covariance matrix?

Compute the global mean $\mu$.

Then create a matrix $B$ of $[\mu_1 - \mu, \cdots, \mu_M - \mu]$

Covariance is given by $\Sigma_b = \frac{1}{M}BB^T$

We maximise over $a$:

$$\frac{1}{M}\sum_k(\hat{\mu_k} - \hat{\mu})^T(\hat{\mu_k} - \hat{\mu}) = \frac{1}{||a||^2}a^T\Sigma_b a$$

# What is the intra-class (within) criteria? Explain its principle

We want a line of projection that minimise the variance

Intra class plays better than inter class !!!

intra criterion: we try to minimise:

$$\hat{\sigma_1}^2 + \hat{\sigma_2}^2$$


# How to compute the intra-class covariance matrix?

We center temporally our (projected) data for each class and compute covariance matrix for each class.

The global covariance is the sum of all covariance matrix of each class

In fact, we superpose each class and try to minimise the global covariance matrix

So global covariance is the projection of the sum of each covariance matrix:

$$\frac{1}{a^Ta}a^T\Sigma_w a$$

with $\Sigma_w$ the sum of all intra-class covariance matrix:

$$\Sigma_w = \sum_k \frac{1}{N_k}A_k A_k^T$$

with $A_k$ the centered class.

# How are they both combined?

They are combined in the Fisher discriminant criteria 

$$\underbrace{argmax}_{a} \Lambda(a) = \frac{ a^T\Sigma_b a}{a^T \Sigma_w a}$$

If we want to find the maximum, we have to take when derivate is equal to zero, so we have:

$$\frac{\delta \Lambda(a)}{\delta a} = \frac{\Sigma_b a (a^T \Sigma_w a) - \Sigma_w a(a^T \Sigma_b a)}{(a^T \Sigma_w a)^2} = 0$$

$\Longrightarrow a$ is solution of the generalized eigne system:

$$\Sigma_b a = \Lambda(a) \Sigma_w a$$

As $\Sigma_w$ is symetric, we have $\Sigma_w^{-1} \Sigma_b a = \Lambda(a) a$ so $a$ is the first eigen vector of $\Sigma_w^{-1}\Sigma_b$ !!


# Can you justify and explain the derivation of the maximum for a?
# Can you describe the multidimensional situation (D > 2)?
# How to do inference using LDA?

No inference in PCA
LDA is optimal for gaussian model, but not for other kind of models with non-linear relationships...

# Provide an example of conditional data model using LDA

We don't know how to explain the data but we know that data follow a gaussian distribution because we take care on mean and variance.
So we can predict label of new data !

We project our data in a way they are the best discriminated...

We have 1 data and we want to predict label.
We can use LDA to achieve our goal:

$$\mathbb{P}(C = k | x_j) = \frac{\mathbb{P}(x_j | C = k)\mathbb{P}C = k}{x_j}$$

Each class follow a gaussian model because we only consider the mean and the variance.

So

$$\mathbb{P}(x|C= k) \approx e^{-(x - \mu_k)^T \Sigma_k^{-1}(x - \mu_k)}$$

Concentration of classes make some curve because of the attraction due to density... It's because we take also care of the variance !!
