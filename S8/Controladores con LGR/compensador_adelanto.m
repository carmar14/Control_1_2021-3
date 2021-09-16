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
num=s1+3.26;
den=s1*(s1+2)*(s1+6.13);
div=abs(num/den);

%---------encontrando la ganancia----
K=5.061;
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
pzmap(sis)
subplot(1,2,2)
pzmap(cl)




