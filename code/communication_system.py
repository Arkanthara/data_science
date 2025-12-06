import numpy as np

random_bits = np.random.randint(0, 2, size=(10000, 1))
signal = random_bits @ np.ones(10)
signal = signal.ravel()

noise = np.random.normal(loc=0, scale=np.sqrt(1.5), size=signal.shape[0])
transmitted_signal = (signal + noise).astype(int)
