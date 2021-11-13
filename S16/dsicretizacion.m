clc
close all
clear

g=tf(1,[2.5 1]);
figure
step(g)
figure
bode(g)
grid on
w=0.402;
Ts=1;%0.1*pi/w;
gd=c2d(g,Ts); %zoh
gd1=tf(0.4,[1 -0.6],Ts);
gd2=tf([0.2857 0],[1 -0.7143],Ts);
gd3=c2d(g,Ts,'tustin');
figure
step(g,'k')
hold on
step(gd,'r')
step(gd1,'b')
step(gd2,'--k')
step(gd3,'g')
legend('Continuo','ZOH','Euler en adelanto','Euler en atraso','Tustin')


h=tf(1,1,1)+tf([1 0],[1 -1],1)+tf([1 -1],[1 0],1);
h2=tf(1,1,1)+tf(1,[1 -1],1)+tf([1 -1],[1 0],1);
h=feedback(h,1);
h2=feedback(h2,1);
figure
step(h)
hold on
step(h2,'--r')
%-----------r-g------
g=tf(10,[1 4 10]);
figure
bode(g)
grid on

w=3.48;
%w=2pi/T------wn=2pi/Ts>2*w (Nyquist)---Ts<pi/w;
Ts=0.1*pi/w;
gd1=c2d(g,Ts);
gd2=c2d(g,Ts,'tustin');

figure
step(g,'k')
hold on
step(gd1,'r')
step(gd2,'b')

