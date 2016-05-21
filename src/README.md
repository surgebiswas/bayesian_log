# The latent logarithm
This folder contains the source code for the latent logarithm, or lag. 

## Usage
The two functions of primary interest are `lag.m` and `lag_plus_learn_prior.m`. Both functions require a vector of non-negative data to be modeled (`t`) and a vector of offsets/confidences/exposures/sampling depths (`o`). `lag.m` additionally requires specification of the prior mean and variance, wherease `lag_plus_learn_prior.m` learns these values.
