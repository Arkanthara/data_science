# k-means

# Describe formally clustering

unsupervised method that aims at discovering consistent groups of data, corresponding to peaks of data intensity.

Called also Vector Quantization (VQ)

Quantization: slice features: for instance, instead to store heigh of peoples, we store bins (how many peoples have this heigh etc...)

clustering algorithms: Hierarchical Agglomerative clustering / k-means/spectral clustering / community detection / high-dimensional clustering / self-organizing maps / neural gaz / ...

# In what sense is it an unsupervised technique?

We give only the data.

(vs supervised: we train data)

# Explain why k-means is intrinsically linked to the Euclidean metric?

We compute distance between each points and the k means.
And the distance is obtained by the euclidean norm.

We try to minimise the negative likelyhood that is given by the euclidean distance.
Probability that element is in cluster c_i according to mean m_i of cluster c_i is the likelyhood, which is gaussian...
|| (x_i - m)/\sigma_k  ||_2^2

# Why do we say that k-means considers a Gaussian model for the clusters?
# Is the k-means algorithm exact?

No.
The quality of the solution is given by the initialization.
We can be blocked by a local optimum...

# What are the principles to initialize k-means?
# What is the coordinate descent algorithm?

We try to minimise the gradient.
First, we fix M and we compute Z, then we fix Z and we compute M 

We are searching where are groups of data.

## Hierarchical Agglomerative clustering

Need to compute a distance of a point to the other...Nearset point create cluster with the given point...

Non parametric clustering algorithm => cluster can have any shape.

## k-means

We are looking for assignment... We want to create $Z$ matrix which is data again cluster (does data i belong to cluster j or not)

A cluster in k-means is represented by center of mass 

Z_i1 = yes if x_i is closer to m_1 than to another means.

How we find the means ??

### Algorithm

- Fix k
- We take k points randomly to construct the set M at time 0. $M^{(0)}$
- We check for each point which mean is the closest and assign to given cluster. (Maximisation)
- We update the means (Expectation)

Expectation: my mean goes where it is expected to go.

unsupervised algorithm

weak supervision (it's more constraint that supervision): we know that some points must be in same cluster and some points must not be in same cluster...

Not very fast because at each step, we need to compute distance of each point to the means...

Quality of results depend on initialization.

### K mean loss

M: the k means
Z: assignment for the points
$\theta = [M, Z] = argmin \mathbf{L}(\theta, x)$
with:
$$
\mathbf{L}(\theta, x) = \sum_i^N \sum_k^K Z_{ik}||x_i - \mu_k||_2^2
$$

This function sum all the distance of all points to the means...In term of inertia, we want to create groups with smallest inertia.

It's spherical gaussian cluster with the euclidean norm considered as variance...
