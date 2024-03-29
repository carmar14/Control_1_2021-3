clc
close all
clear

%---------proceso--------
den=conv([1 1],[1 5]);
%g=tf(1,den);
g=tf(1,den,'InputDelay',1);
step(g,'b')

L=1;
T=1.75-1;

%-----------controlador p-----
K_p=T/L;
g_c=tf(K_p,1);
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
hold on
step(sis_cl,'k')


%------controlador PI----
K_p=0.9*T/L;
T_i=L/0.3;
g_c=tf([K_p*T_i K_p],[T_i 0]);
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
hold on
step(sis_cl,'r')

%------controlador PID----
K_p=1.2*T/L;
T_i=2*L;
T_d=0.5*L;
g_c=tf([K_p*T_i*T_d K_p*T_i K_p], [T_i 0]); 
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
hold on
step(sis_cl,'--k')

legend('OL','P','PI','PID')
title('Primer método')


den = conv([1 1],[1 5]);
den = conv(den,[1 0]);
g=tf(1,den);
figure
rlocus(g)

K_cr=30;
sis_ol=K_cr*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
P_cr=2.8;
%-----------controlador p-----
K_p=0.5*K_cr;
g_c=tf(K_p,1);
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')


%------controlador PI----
K_p=0.45*K_cr;
T_i=P_cr/1.2;
g_c=tf([K_p*T_i K_p],[T_i 0]);
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
hold on
step(sis_cl,'r')

%------controlador PID----
K_p=0.6*K_cr;
T_i=0.5*P_cr;
T_d=0.125*P_cr;
g_c=tf([K_p*T_i*T_d K_p*T_i K_p], [T_i 0]); 
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
hold on
step(sis_cl,'--k')

legend('P','PI','PID')
title('Segundo método')