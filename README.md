# Lung Sound Classification Using Fluctuation-Based Dispersion Entropy

This repository contains the MATLAB and Google Colab implementation for lung sound classification using Fluctuation-Based Dispersion Entropy (FDispEn) features extracted from the Discrete Wavelet Transform (DWT).

This work was conducted as part of an academic research project.

---

## Overview

The proposed framework consists of signal preprocessing, DWT decomposition, FDispEn feature extraction, and machine learning-based classification of lung sounds.

The evaluated machine learning models include:

- Support Vector Machine (SVM)
- Multilayer Perceptron (MLP)
- XGBoost

---

## Dataset

The dataset is **not included** in this repository.

Please download the dataset from the official source:

https://doi.org/10.34740/kaggle/dsv/14636317

After downloading the dataset, place it in the appropriate project directory before running the code.

---

## Project Structure

```
lung-sound-classification/
│
├── notebooks/
│   ├── 01_dwt_fdispen.m
│   ├── 02_ml_evaluation_dwt_fdispen.ipynb
│   └── README.md
│
├── README.md
├── LICENSE
└── .gitignore
```

---

## Workflow

1. Lung sound preprocessing
2. Discrete Wavelet Transform (DWT)
3. Feature extraction using Fluctuation-Based Dispersion Entropy (FDispEn)
4. Machine learning training and evaluation

---

## Tools

- MATLAB
- Google Colab
- Python

---

## License

This project is licensed under the MIT License.
