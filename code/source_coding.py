import numpy as np
from dahuffman import HuffmanCodec

samples = np.random.rand(2000, 5)
samples[samples >= 0.9] = 1
samples[samples < 0.9] = 0
samples = samples.astype(int)

symbols, frequencies = np.unique(samples, axis=0, return_counts=True)
print(f"Frequency of each symbol: {frequencies}")

symbols = ["".join(str(sample) for sample in row) for row in samples]
codec = HuffmanCodec.from_frequencies(dict(zip(symbols, list(frequencies))))
codec.print_code_table()
sequence = "".join(str(sample) for sample in samples.ravel())
print(len(sequence))
encoded = codec.encode(sequence)
print(len(encoded))