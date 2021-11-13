clc
clear
close all

%----------discreto------
gd=tf([0.368 0.264],[1 -1.368 0.368],1);
A=[0 0 1 0;
   0.368 0 -1.368 1;
   0.264 0.368 0.368 -1.368;
   0 0.264 0 0.368];
B=[1 0 0 0]';
x = inv(A)*B;
q1=x(1);
q0=x(2);
p1=x(3);
p0=x(4);
gc_d=tf([q1 q0],[p1 p0],1);

sis_ol=gd*gc_d;
sis_cl=feedback(sis_ol,1);
step(sis_cl,'k')

%---------continuo-----
g=d2c(gd,'tustin');
gc=d2c(gc_d,'tustin');

sis_ol=g*gc;
sis_cl=feedback(sis_ol,1);
hold on
step(sis_cl,'r')
legend('Sistema con controlador discreto','Sistema con controlador continuo');

figure
pzmap(sis_cl)