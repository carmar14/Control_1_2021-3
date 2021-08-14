clear
close all
clc

%--------------primer orden-------------
k=1;
tao=4;
spo=tf(k,[tao 1]);
subplot(3,1,1)
step(spo)

za = tf([1.9*tao 1],1);
subplot(3,1,2)
step(spo*za)

%figure
%pzmap(spo*za)

pa = tf(1,[0.5*tao 1]);
subplot(3,1,3)
step(spo*pa)

figure
pzmap(spo*za)

%--------------segundo orden-------------
e=0.3;
wn=2;
k=1;
sso=tf(k*wn^2,[1 2*e*wn wn^2]); 
figure
%subplot(3,1,1)
step(sso,'k')

e=0.7;
sso=tf(k*wn^2,[1 2*e*wn wn^2]); 
hold on
step(sso,'r')

e=0.1;
sso=tf(k*wn^2,[1 2*e*wn wn^2]); 

step(sso,'b')



za = tf([11],1);  % probar con 10%, 5% 2%
subplot(3,1,2)
step(sso*za)

pa = tf(1,[1/(0.6/5) 1]);
subplot(3,1,3)
step(sso*pa)

figure
pzmap(sso*za)


figure
step(sso)
hold on
step(sso*pa)
