import numpy as np
from dahuffman import HuffmanCodec

samples = np.random.rand(2000, 5)
samples[samples >= 0.9] = 1
samples[samples < 0.9] = 0
samples = ["".join(str(int(elem)) for elem in row) for row in samples]

symbols, frequencies = np.unique(samples, axis=0, return_counts=True)
print(f"Number of different symbols: {len(frequencies)}")
print(f"Frequency of each symbol: {frequencies}")

codec = HuffmanCodec.from_frequencies(dict(zip(symbols, list(frequencies))))
encoded = codec.encode(samples)
print(f"Number of bits used for encoding: {len(encoded)}")