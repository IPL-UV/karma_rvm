# KERNEL ARMA for RVM and SVM

**Version:** 1.1  
**Release Date:** February 20, 2006  

## Description
This repository provides implementations for nonlinear system identification using:

- **Relevance Vector Machines (RVM)** with KARMA methods (Kernel ARMA).
- **Support Vector Machines (SVM)** for regression and signal estimation.

It includes advanced composite kernels and solvers such as:
- Kernel Ridge Regression (KRR)
- Support Vector Regression (SVR)
- Relevance Vector Machines (RVMs)

These methods are based on the following references:

1. **Nonlinear system identification with composite relevance vector machines**  
   Camps-Valls, G., Martínez-Ramón, M., Rojo-Álvarez, J.L., Muñoz-Marí, J.  
   *IEEE Signal Processing Letters*, 14(4): 279-282, 2007.

2. **A unified SVM framework for signal estimation**  
   Rojo-Álvarez, J.L., Martínez-Ramón, M., Muñoz-Marí, J., Camps-Valls, G.  
   *Digital Signal Processing: A Review Journal*, 26(1): 1-20, 2014.

---

## Repository Structure

### Main Directories
- **`data/`**: Contains sample input/output signals.
- **`rvm_code/`**: Implements RVM solvers and KARMA methods.
- **`svm_code/`**: Contains SVM implementations and compiled files for different platforms.

### Key Scripts
- **`Demo.m`**: Demonstrates training of KARMA methods for nonlinear signal estimation.
- **`demo_rvm.m`**: Sparse Bayesian learning (SBL) example for RVM-based regression.
- **`BuildData.m`**: Generates input/output matrices based on signal delay and tap order.
- **`BuildKernels.m`**: Builds composite kernel matrices using methods like 'svr', '2k', 'svr+4k'.
- **`TrainKernel.m`**: Trains kernel matrices using solvers: 'krr', 'svr', and 'rvm'.

---

## Setup

1. **Install MATLAB.**
2. **Clone the repository:**

```bash
# Clone the repository
https://github.com/IPL-UV/karma_rvm.git
cd karma_rvm
```

3. **Add paths to MATLAB:**

```matlab
% Add paths to required directories
addpath('./data/');
addpath('./rvm_code/');
addpath('./svm_code/');
```

---

## Usage

### **Example 1: Training KARMA Methods**

Run the main demonstration script for KARMA methods:

```matlab
clear; clc; close all;

% Select method and problem
method  = 'stack+4k';   % Kernel method
problem = 'mg17';       % Signal problem

% Parameters
D  = 0;    % Signal delay
p  = 2;    % Tap order
gam = 1e-4; % Regularization
C  = 1e2;   % Penalization
e  = 1e-5;  % Epsilon insensitivity

% Kernel setup
ker = 'rbf';
kparams.x = 2; kparams.y = 2; kparams.z = 2;

% Load sample data
load mg17.dat
N = 400; M = 1000;
X = mg17(1:N-1); Y = mg17(2:N);

% Build data matrices
[Hx, Hy, ~, ~] = BuildData(X, Y, [], [], D, p);

% Build kernel matrices
[K, ~] = BuildKernels(Hx, Hy, [], [], ker, kparams, method);

% Train with different solvers
[Yhat_krr, results_krr] = TrainKernel(K, [], Y, [], D, p, gam, e, C, 'krr');
[Yhat_rvm, results_rvm] = TrainKernel(K, [], Y, [], D, p, gam, e, C, 'rvm');

% Display results
disp(results_krr);
disp(results_rvm);
```

---

### **Example 2: Sparse Bayesian Regression with RVM**

Run the RVM demonstration for noisy sinc data:

```matlab
setEnvironment('InfoLevel', 3);

% Generate noisy sinc data
N = 100;
X = 10 * linspace(-1, 1, N)';
y = sin(abs(X)) ./ abs(X) + 0.1 * randn(N, 1);

% Train RVM
initAlpha = 1e-4; initBeta = 1;
[weights, used] = sbl_rvm(X, y, initAlpha, initBeta, '+gauss', 3);

% Predict and plot
PHI = sbl_kernelFunction(X, X(used), '+gauss', 3);
y_pred = PHI * weights;

figure;
plot(X, y, 'r--', X, y_pred, 'w-', 'LineWidth', 2);
title('RVM Regression on Noisy Sinc Data');
```

---

## SVM Files

The folder **`svm_code`** contains precompiled files for SVM training and prediction:

- **Windows**: `svmtrain.dll`, `svmpredict.dll`
- **Linux 64-bit**: `svmtrain.mexa64`, `svmpredict.mexa64`
- **Linux (older systems)**: `svmtrain.mexglx`, `svmpredict.mexglx`

To use these, call the `svmtrain` and `svmpredict` functions directly in MATLAB.

---

## Results and Visualization

**Outputs:**
- **Predicted vs Actual Scatter Plots**: Compare predictions for KRR, SVR, and RVM visually.
- **Boxplots of Residuals**: Analyze the residual errors to compare solver performances.

---

## Authors

- **Jordi Muñoz-Marí**  
- **Gustavo Camps-Valls**  
- **Manel Martínez-Ramón**  
- **José L. Rojo-Álvarez**

**Copyright © 2006**

---

## License

This project is distributed under the **MIT License**.

---
