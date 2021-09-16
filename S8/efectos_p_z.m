clc
clear
close all

tao= 1;
h=tf(1,[tao 1]);
rlocus(h)
title('LGR de $F(s)=\frac{1}{\tau s +1}$','Interpreter','latex')


tao = 1/2;
h2=tf(1,[tao 1]);
figure
rlocus(h*h2)
title('LGR de $F(s)=\frac{1}{(\tau_1 s +1)(\tau_2 s +1)}$','Interpreter','latex')

tao = 2;
h3=tf(1,[tao 1]);
figure
rlocus(h*h2*h3)
title('LGR de $F(s)=\frac{1}{(\tau_1 s +1)(\tau_2 s +1)(\tau_3 s +1)}$','Interpreter','latex')



% tao = 10;
% h4=tf(1,[tao 1]);
% figure
% rlocus(h*h2*h3*h4)

