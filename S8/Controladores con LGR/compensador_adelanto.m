clc
clear
close all

%---------sistema en lazo abierto---
g=tf(4,[1 2 0]);
rlocus(g)
%---------sistema en lazo abierto---

%---------sistema en lazo abierto con G_c(s)---
gc=tf([1 3.26],[1 6.13]);

ol=gc*g;
figure
rlocus(ol)
%---------sistema en lazo abierto con G_c(s)---


%---------encontrando la ganancia----
s1=-2+2*sqrt(3)*i;
num=4*(s1+3.26);
den=s1*(s1+2)*(s1+6.13);
%num=4*(s1/3.26+1);
%den=s1*(s1+2)*(s1/6.13+1);
div=abs(num/den);

%---------encontrando la ganancia----
%K=5.061;
K=1/div;
sc=K*ol; % sistema completo en lazo abierto
cl=feedback(sc,1); % sistema compensado en lazo cerrado
sis=feedback(g,1) % sistema sin compensador en lazo cerrado
figure
step(cl,'k')
hold on
step(sis,'b')
title('Respuesta al escalon')
legend('Sistema compensado', 'Sistema no compensado')

figure
subplot(1,2,1)
pzmap(sis,'b')
title('Sistema no compensado')
subplot(1,2,2)
pzmap(cl,'k')
title('Sistema compensado')
%----------compensador usando operacionales-------

R1=30.67e3;
R2=16.31e3;
R3=10e3;
R4=50.061e3;
C1=10e-6;
C2=C1;

K_c=R4*C1/(R3*C2);
z=1/(R1*C1);
p=1/(R2*C2);
Gc=tf(K_c*[1 z],[1 p]);
s_con=feedback(Gc*g,1);
figure
step(s_con,'k')
hold on
step(sis,'b')
title('Respuesta al escalon')
legend('Sistema compensado', 'Sistema no compensado')




