<div align="center">

# Lung Sound Classification Using Fluctuation-Based Dispersion Entropy

**Listening to the lungs through signal processing and machine learning.**

MATLAB and Google Colab implementation for classifying lung sounds using Fluctuation-Based Dispersion Entropy (FDispEn) features extracted from the Discrete Wavelet Transform (DWT).

![MATLAB](https://img.shields.io/badge/MATLAB-0076A8?style=for-the-badge&logo=mathworks&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Google Colab](https://img.shields.io/badge/Google_Colab-F9AB00?style=for-the-badge&logo=googlecolab&logoColor=white)

</div>

---

## Overview

Lung sounds carry useful information about respiratory health, but raw audio is difficult to analyze directly. This project turns each recording into a compact set of entropy-based features and uses them to train machine learning classifiers.

The pipeline has four stages:

1. **Preprocessing** of the lung sound signals
2. **Decomposition** with the Discrete Wavelet Transform (DWT)
3. **Feature extraction** using Fluctuation-Based Dispersion Entropy (FDispEn)
4. **Classification** with machine learning models

This work was conducted as part of an academic research project.

## Results

Classification performance of the two feature extraction methods (Table II in the paper):

| Feature Extraction Method | Accuracy (%) | Precision (%) | Sensitivity (%) | F1-Score (%) |
| ------------------------- | ------------ | ------------- | --------------- | ------------ |
| DWT-FDispEn               | 95.95        | 96.40         | 96.20           | 95.95        |
| DWT-HFD                   | 93.94        | 94.48         | 94.40           | 94.40        |

DWT-FDispEn achieved the best performance across all metrics, outperforming DWT-HFD by about 2 percentage points in accuracy.

## Workflow

```text
Lung sound  ->  Preprocessing  ->  DWT  ->  FDispEn features  ->  Classifier  ->  Evaluation
```

| Stage | Description | Tool |
| ----- | ----------- | ---- |
| Preprocessing | Prepare the raw lung sound signals for analysis | MATLAB |
| DWT decomposition | Split each signal into frequency sub-bands | MATLAB |
| Feature extraction | Compute FDispEn from the DWT output | MATLAB |
| Classification and evaluation | Train and compare machine learning models | Python (Google Colab) |

## Models Evaluated

* Support Vector Machine (SVM)
* Multilayer Perceptron (MLP)
* XGBoost

## Dataset

The dataset is **not included** in this repository.

Please download it from the official source:

[https://doi.org/10.34740/kaggle/dsv/14636317](https://doi.org/10.34740/kaggle/dsv/14636317)

After downloading, place the dataset in the appropriate project directory before running the code.

## Project Structure

```text
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

| File | Purpose |
| ---- | ------- |
| `01_dwt_fdispen.m` | MATLAB script for DWT decomposition and FDispEn feature extraction |
| `02_ml_evaluation_dwt_fdispen.ipynb` | Notebook for training and evaluating the SVM, MLP, and XGBoost models |
| `notebooks/README.md` | Extra notes about the notebooks |

## How to Run

**Step 1: Get the data**

Download the dataset from the link above and place it in the project directory.

**Step 2: Extract features in MATLAB**

Open `notebooks/01_dwt_fdispen.m` in MATLAB and run it. This performs the DWT and computes the FDispEn features.

**Step 3: Train and evaluate in Google Colab**

Open `notebooks/02_ml_evaluation_dwt_fdispen.ipynb` in Google Colab (or Jupyter), load the extracted features, and run the cells to train and compare the models.

## Tools

* MATLAB
* Google Colab
* Python

## Citation

If you use this code or build on this work, please credit this repository and the original dataset.

```text
Dataset: https://doi.org/10.34740/kaggle/dsv/14636317
```

## Author

Made by **AURELIA ARDHANISA PUTRI**.


## License

Copyright (c) 2026 Aurelia Ardhanisa Putri. All rights reserved.

This repository is shared for viewing and academic reference only. If you would like to use, adapt, or build on this work, please contact me first at aureliaardhanisap@gmail.com
