import numpy as np
import matplotlib.pyplot as plt


data = []

data.append(np.load("data/tp1_artificialdata1.npz")['data'])
data.append(np.load("data/tp1_artificialdata2.npz")['data'])
data.append(np.load("data/tp1_artificialdata3.npz")['data'])
data.append(np.load("data/tp1_artificialdata4.npz")['data'])
data.append(np.load("data/tp1_digit2.npz")['data'])
data.append(np.load("data/tp1_freyfaces.npz")['data'])

for i in range(6):
    cov = np.cov(data[i])
    print("\n--------------------------------------------")
    print("\nCovariance matrix\n")
    print(cov)
    print("--------------------------------------------\n")
    eigenvalues, _ = np.linalg.eig(cov)
    print("\n--------------------------------------------")
    print("\nEigen values\n")
    print(eigenvalues)
    print("--------------------------------------------\n")
    det = np.linalg.det(cov)
    print("\n--------------------------------------------")
    print("\nDeterminant\n")
    print(det)
    print("--------------------------------------------\n")
    product = np.prod(eigenvalues)
    print("\n--------------------------------------------")
    print("\nProduct of eigen values\n")
    print(product)
    print("--------------------------------------------\n")
    plt.figure()
    plt.plot(range(len(eigenvalues)), np.real(eigenvalues))
    plt.title(f"Eigenspectrum of data {i + 1}")
    plt.show()

