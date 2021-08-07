clc
clear
close all

R=10e3;
C=1e-6;
L=100000e-3;

num = [R*L 0];
den = [R*L*C L R];
h= tf(num,den);

step(2*h)

figure
pzmap(h)

[p z]= pzmap(h);

