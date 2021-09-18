clc
clear
close all

%------------planta o proceso----
a=[1 1];
b=[1 2];
c=[1 0];
den= conv(a,b);
den= conv(den,c);

g=tf(1.06,den);

rlocus(g)
figure
gr=feedback(g,1);
pzmap(gr)
title('Mapa de polos y ceros sin compensador')

[p z] = pzmap(gr);

%polos dominantes: 
s1=-0.33+0.59*i;
s2=-0.33-0.59*i;

%polinomio caracteristico:
pol = conv([1 -s1],[1 -s2])

wn=sqrt(pol(3))
e=pol(2)/(2*wn)

% constante Kv actual
Kv_a=0.53
% se desea Kv cerca a 5 la razón es 9.43, se puede acerca a 10 para fines
% practicos

%------G_c(s)=(s+z)/(s+p)-----
z=0.05;
p=0.005;
g_c = tf([1 z],[1 p]);

%nuevo lgr
sis_c=g_c*g;
figure
rlocus(sis_c)


%ubicar los nuevos polos dominantes teniendo en cuenta G_c*G
sis_rc=feedback(g_c*g,1);
[p z]=pzmap(sis_rc)
figure
pzmap(sis_rc)
title('Mapa de polos y ceros con compensador')

% determinar la ganancia K para ubicar los polos deseados en lazo cerrado
s1= -0.31+0.57*i;
s2= -0.31-0.57*i;
num = 1.06*(s1+0.05);
den = s1*(s1+0.005)*(s1+1)*(s1+2);

div = abs(num/den);

K=1/div;

%polinomio caractetistcio nuevo
pol = conv([1 -s1],[1 -s2])

wn=sqrt(pol(3))
e=pol(2)/(2*wn)


%sistema completo realimentado
sis_r_c=feedback(K*g_c*g,1);
figure
step(gr,'b')
hold on
step(sis_r_c,'k')
title('Respuesta al escalon')
legend('Sistema no compensado', 'Sistema compensado')


