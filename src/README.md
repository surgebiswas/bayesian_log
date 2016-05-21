# The latent logarithm
This folder contains the source code for the latent logarithm, or lag. 

## Usage
The two functions of primary interest are `lag.m` and `lag_plus_learn_prior.m`. Both functions require a vector of non-negative data to be modeled (`t`) and a vector of offsets/confidences/exposures/sampling depths (`o`). `lag.m` additionally requires specification of the prior mean and variance, wherease `lag_plus_learn_prior.m` learns these values.

An example of their use is given below:

```
clear;
rng('default');
cd('~/GitHub/latent_log'); % Change accordingly
path(genpath(pwd), path);

% Load the data.
% t, t2, and o in memory. 
% t and t2 are the TPM abundances for the 'rare' and 'abundant' gene respectively.
% o contains the TPM offsets.
load('AT2G43386_AT1G14630.mat'); 
```

