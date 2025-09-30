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

If I project my matrix

Closest matrix

If I have any matrix and I want to limit it's rank to K, the projection to the rank will be Sigma K and this can be simplified to limit spectrum to the K first eigen values.

Transform in 2 directions:
$y = U^T_K x and x = U_KU^T_Kx + \bar{x}$

### Given some data, how do you apply PCA?
### What information does it provide you with?
### How do you reconstruct data with K < D components?

Transform in 2 directions:
$y = U^T_K x and x = U_KU^T_Kx + \bar{x}$

### How do you select the components to keep?
### Can you apply PCA on any data?
### Is it relevant to apply PCA on any data?
### How can I apply PCA over clustered data?
### Show that PCA is equivalent to a linear AE


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
