= Course 2

To approximate the function, we can take only a number of moments of the function

characteristic function vs moment function: moment function has no imaginary part !!!

Moment generation computation don't allow in all case to come back to the $phi$ characteristic function because we loose the imaginary part ??

Blind Statistical Steganalysis of Additive Steganography Using Wavelet Higher Order Statistics
Discover secret communication is already a big success !
Principe: compute moments of residual image.... Image with Steganography is different from other images, so moments allow to differenciate image with and without secret... Same procedure can be used to check if image is created by AI...

Important to check if generated data because to train models, we need good data ! Synthetic data decrease performances of models !!

== Recall

- $"Var"[X] = E[[X - E[X]]^2] = E[X^2] - E[X]^2$
- $0 <= "Var"[X] <= E[X^2]$
- $"Var"[c X] = c^2"Var"[X]$
- $"Var"[a X + b Y] = a^2"Var"[X] + 2 a b "Cov"[X, Y] + b^2 "Var"[Y]$
- $"Cov"[X, Y] = E_(p(x, y))[(X - mu_X)(Y - mu_Y)] = sum_((x, y) in S_(X, Y)) p(x, y)(x - mu_X)(y - mu_Y) = E_(p(x, y))[X Y] - mu_X mu_Y = sigma_(X Y)$

=== Chain rules

$p(x, y, z) = p(x) dot p(y|x) dot p(z|x, y)$

marginal distribution:
$p(x_i)$

joint distribution:
$p(x_1, x_2, dots, x_N) = product_(i = 1)^N p(x_i | x_(i - 1), dots, x_2, x_1)$

Chain rules give the decomposition of a very difficult distribution to a chain of simpler elements !!

Bayes rule is the consequence of the chain rules !

In case of independent variables, it becomes a simple product !

Identically distributed means that each variable follow the same law !

However, taking all statistics in care is impossible because there is too many informations !!! $->$ uncorrelate data !!

Covariance include second order dependencies ????


