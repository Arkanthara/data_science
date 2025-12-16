If independent, entropy is bigger !

I don't know what is the total entropy, but I can generate next symbol thanks to previous generated symbols...

If X is given by a function that is deterministic dependant on Y, H(X | Y) becomes 0

Kullback-Leibler divergence (KLD) determine how many our function derivate from target function...

D(p || q) q must be as closest as possible to p !!!

MSE vs KLD: MSE -> geometric KLD -> theory of information MSE x, y = MSE y, x.... KLD x || y != KLD y||x !! So conceptualy similar, but matematicaly differents !!!

KLD: what is the price to encode q(x) with encoding of p(x) ???

Penality for us caused by bad using of encoding...

Cross Entropy: in general in ML they say they use CE whereas using only KLD: only KLD depend on theta !!!!

Link between KLD and CE very important !!!

Mutual information: KLD between join distribution and p(x) p(y) (like independent !)
