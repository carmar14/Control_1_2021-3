clc
close all
clear

%proceso
global b c pol_d
a=0;%5.746e-4;
b=0.015;%.1e-4;
c=0.035;
g=tf([b],[1 c]);
step(g,'k')
g_cl=feedback(g,1);
figure
step(g_cl,'k')
[p z]=pzmap(g);

%deseado
Ts=10; % 50
so=5/100;
e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
g_d=tf(wn^2,[1 2*e*wn wn^2]);
g_dn=tf(wn^2*[1/0.1541 1],[1 2*e*wn wn^2]);
figure

step(g_d,'r')
% hold on
% step(g_dn,'-k')
legend('Sin compensar','sin compensar en CL','Deseado')
[P Z]=pzmap(g_d)


pol_d=[1 2*e*wn wn^2];
% pol_a=conv(pol_d,[1 8]);


%------controlador PID----
x0=[0 0.1 0];
x=fsolve(@pid,x0);
K_p=x(1);
T_i=x(2);
T_d=x(3);
g_c=tf([K_p*T_i*T_d K_p*T_i K_p],[T_i 0]);

%--------compensado----
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(10*sis_cl,'k')
hold on
step(10*g_d,'r')
legend('Compensado','Deseado')
[p z]=pzmap(sis_cl)
%------controlador PID----

%-----------controlador algebraico----
pol_d=[1 2*e*wn wn^2];
pol_a=conv(pol_d,[1 4]);

A=[0 0 1 0;
   a 0 c 1;
   b a 0 c;
   0 b 0 0];
B=pol_a';
x = inv(A)*B;

q1=x(1);
q0=x(2);

p1=x(3);
p0=x(4);
%--------compensado----
g_c=tf([q1 q0],[p1 p0 0]); %----con integrador---
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado algebraico','Deseado')
[p z]=pzmap(sis_cl)
%-----------controlador algebraico----

function f=pid(x)
global b c pol_d

Kp=x(1);
Ti=x(2);
Td=x(3);
d=pol_d(1);
e=pol_d(2);
g=pol_d(3);

%--------sistema de ecuaciones a resolver-----
%-----f(x)=0------
f(1)=1+b*Kp*Td-d;
f(2)=c+b*Kp-e;
f(3)=b*Kp/Ti-g;


end