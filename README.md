# The latent logarithm

Count or non-negative data are often log transformed to improve heteroscedasticity and scaling. To avoid undefined values where the data are zeros, a small pseudocount (e.g. 1) is added across the dataset prior to applying the transformation. This pseudocount considers neither the measured object's a priori abundance nor the confidence with which the measurement was made, making this practice convenient but statistically unfounded. I introduce here the latent logarithm, or lag. lag assumes that each observed measurement is a noisy realization of an unmeasured latent abundance. By taking the logarithm of this learned latent abundance, which reflects both sampling confidence/depth and the object's a priori abundance, lag provides a probabilistically coherent, stable, and intuitive alternative to the questionable, but conventional "log(x + pseudocount)." 




Send questions/comments to surojitbiswas@g.harvard.edu
