# Factor correspondence analysis (Not at the exam !)

# What is a contingency table? Look for an example other than those given here

Show the contingency distribution of 2 variables.

Given the $D_1 \times D_2$ data matrix $\mathbf{X}$, we can examine the marginal distributions:

- The row marginal vector is given by $\mathbf{r} = \mathbf{X} \mathbf{1}_{D_2}$,
- The column marginal vector is given by $\mathbf{c} = \mathbf{X}^\top \mathbf{1}_{D_1}$,

where $\mathbf{1}_{D_1}$ and $\mathbf{1}_{D_2}$ are vectors of ones of dimensions $D_1$ and $D_2$, respectively.


# What are the specificities of such data?
# How to compute row- and column-profiles?
# How/why do we change metric in linear analysis (eg χ2)?
# Can we directly superimpose dual latent analysis?
# Is the role of latent factors the same is in PCA?

## 📊 Correspondence Analysis: From Contingency Table to Covariance Matrix

Given the $D_1 \times D_2$ contingency table $\mathbf{X}$, we start by computing the **marginal distributions**:

- **Row marginals**:  
  $$
  \mathbf{r} = \mathbf{X} \mathbf{1}_{D_2}
  $$

- **Column marginals**:  
  $$
  \mathbf{c} = \mathbf{X}^\top \mathbf{1}_{D_1}
  $$

where $\mathbf{1}_{D_1}$ and $\mathbf{1}_{D_2}$ are vectors of ones of size $D_1$ and $D_2$, respectively.

---

We then define the **diagonal matrices of weights**:

$$
\mathbf{D}_r = \operatorname{diag}(\mathbf{r}), \quad \mathbf{D}_c = \operatorname{diag}(\mathbf{c})
$$

Next, we compute the **matrix of relative frequencies**:

$$
\mathbf{P} = \frac{\mathbf{X}}{n}, \quad \text{where } n = \sum_{i,j} X_{ij}
$$

The **expected frequencies under independence** are given by the outer product of marginals:

$$
\mathbf{E} = \frac{\mathbf{r} \mathbf{c}^\top}{n^2}
$$

Then we compute the **standardized residuals** (i.e., chi-squared normalization):

$$
\mathbf{S} = \mathbf{D}_r^{-1/2} \left( \mathbf{P} - \frac{\mathbf{r} \mathbf{c}^\top}{n^2} \right) \mathbf{D}_c^{-1/2}
$$

---

### 📈 Column Covariance Matrix

Putting it all together, we construct the **column covariance matrix** under the chi-squared metric:

$$
\boldsymbol{\Sigma}_c = \mathbf{C}^\top \mathbf{W}_c \mathbf{C}
$$

Where:

- $\mathbf{C}$ is the matrix of **column profiles**,
- $\mathbf{W}_c = \mathbf{D}_c^{-1}$ is the **column weight matrix**,
- $\boldsymbol{\Sigma}_c$ is the **weighted covariance matrix** capturing the structure among column modalities.

---

### 🔗 Connection Between Both Parts

1. We begin with the contingency table $\mathbf{X}$ to compute **marginals** ($\mathbf{r}, \mathbf{c}$).
2. These marginals are used to build:
   - Expected frequencies under independence,
   - Normalized data (standardized residuals),
   - Profiles and weight matrices.
3. Finally, we use this structure to build **covariance matrices**, which form the basis of the **singular value decomposition (SVD)** in correspondence analysis.


Goal: map data on same latent factor (allow to plot some features on same plot... It's a kind of correlation between features.....)

GPU -> make matrix products instead of loops !
