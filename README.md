# Course-Project
Those projects are parts of my course projects, which is interesting or is worth pondering.

## Numerical Analysis
### Probject1-weight and height of children

The main aim is to calculate the children' weight and height according to reference data. The main method I use is `cubic spline interpolation` with ![](http://latex.codecogs.com/gif.latex?f'(x_0)) and ![](http://latex.codecogs.com/gif.latex?f'(x_n)). Before this, I use `least square fit` to gather the derivatives at x_0 and x_n. Besides, I design the GUI with Matlab 2016b. Therefore, there may be some problems if your matlab version is lower than mine.

## Principle of Communication
### Simulation of FSK(Frequency Shift Keying)

The main aim to to simulate the FSK signal and its error rate. Them compare simulation result with theoretical result. 

The file test.m is for noncorrelated demodulation, and test_co.m is for correlated demodulation. If it is slow, maybe you should change same parameters, like ![](http://latex.codecogs.com/gif.latex?E_a) (transmit power of one bit) or the 10000 in this code.

```matlab
num = 10000*ceil(1/P_e_a(i));
```
However, the preformance of simualtion will be worse if number is lower. I suggust this number should be bigger than `100` according to `Monte-Carlo simulation`.

## Computer Graphics 
