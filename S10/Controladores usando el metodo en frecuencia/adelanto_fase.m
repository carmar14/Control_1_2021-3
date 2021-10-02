clc
clear
close all


%------proceso
g=tf(4,[1 2 0]);
g_cl=feedback(g,1);
step(g_cl)
title('Respuesta en lazo cerrado del proceso sin compensador')


%---------encontrar el MF y MG de K*G(s)
K=10;
g1=K*g;
figure
margin(g1)

%---------se encuentra a------
a=(1-sind(37))/(1+sind(37));%0.25;
%-------se encuentra la nueva frecuencia de cruce de ganancia---
w=roots([1 0 4 0 -80^2]);
w=8.83;

%-------a partir de w se encuentra la ubicacion del cero y el polo--
%---G_c(s)=Kc*(s+z)/(s+p)---> z=1/T, p=-1/(aT)   z=w

T=1/(w*sqrt(a));
z=1/T;
p=1/(T*a);
Kc=K/a;
gc=Kc*tf([1 z],[1 p]);

s_comp=gc*g;
figure
margin(s_comp)
s_comp_clo=feedback(s_comp,1);
figure
step(s_comp_clo)
title('Respuesta en lazo cerrado del proceso con compensador')


figure
step(s_comp_clo,'k')
hold on
step(g_cl,'b')
legend('compensado','no compensado')


figure
pzmap(s_comp_clo)


