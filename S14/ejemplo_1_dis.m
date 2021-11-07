clc
close all
clear

%proceso
g=tf(1,[1 48 5]);
step(g,'k')
g_cl=feedback(g,1);
hold on

%deseado
Ts=1;
so=13/100;
e=sqrt((log(so))^2/(pi^2+(log(so))^2));
wn=4/(Ts*e);
g_d=tf(wn^2,[1 2*e*wn wn^2]);
hold on
step(g_cl,'b')
step(g_d,'r')
legend('Sin compensar','sin compensar en CL','Deseado')
[P Z]=pzmap(g_d)

pol_d=[1 2*e*wn wn^2];
pol_a=conv(pol_d,[1 40]);

%------controlador----
K_p=373.9-5;
T_i=K_p/2157.5;
g_c=tf([K_p*T_i K_p],[T_i 0]);

%--------compensado----
sis_ol=g_c*g;
sis_cl=feedback(sis_ol,1);
figure
step(sis_cl,'k')
hold on
step(g_d,'r')
legend('Compensado','Deseado')
[p z]=pzmap(sis_cl)


%--------------------discretizar----------------
%----------w=ancho de banda en lazo cerrado---
w=14.3;
ws=2*14.3;
Ts=2*pi/ws;
% Ts=1/10;  %1/10 foh
gc_d=c2d(g_c,Ts,'foh');
gp_d=c2d(g,Ts,'foh');
sis_ol_d=gc_d*gp_d;
sis_cl_d=feedback(sis_ol_d,1);
figure
step(sis_cl_d,'k')
hold on
step(g_d,'r')
legend('Compensado','Deseado')

figure
step(sis_cl_d,'k')
hold on
step(sis_cl,'b')
legend('Discreto','Continuo')
%--------------------discretizar----------------


%-----------implementar algoritmo-------------
rk=1;
%------controlador-----
uk1=0;
uk=0;
ek1=0;
ek=0;

%------controlador-----

%------proceso-----
ukp1=0;
ukp2=0;
ukp=0;
yk1=0;
yk2=0;
yk=0;
y=[];
%------proceso-----


t=0:Ts:2.5;
for i=1:length(t)
    
    yk=4.287e-05*ukp1 + 3.654e-05*ukp2 + 1.618*yk1 - 0.6188*yk2;
    %yk = 0.0006962*ukp + 0.001286*ukp1 + 7.728e-05*ukp2 + 0.9979*yk1 -
    %0.00823*yk2; %foh
    y=[y yk];
    %calcular el error
    ek = rk - yk;
    %calcular accion de control
    uk=368.9*ek - 347.3*ek1+uk1; 
    %uk=476.8*ek - 261*ek1+uk1;  %foh
    ukp = uk;
    %--------actualizar valores--------
    ek1=ek;
    uk1=uk;
    
    ukp2=ukp1;
    ukp1=ukp;
    
    yk2=yk1;
    yk1=yk;    
     
    
end
figure
plot(t,y,'--r')
hold on
step(sis_cl_d,'k')
step(sis_cl,'b')
legend('algoritmo','Discreto','Continuo')
