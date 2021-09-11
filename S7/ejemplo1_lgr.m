clc
clear
close all

%ecuacion caracteristica del ejemplo 1
% -------s^2+6s+k=0------

figure
for k=0:20
    r=roots([1 6 k]);
    r
    k
    plot(real(r),imag(r),'*')
    hold on       
end

xlabel('Real')
ylabel('Imag')


figure
rlocus(tf(1,[1 6 0]))


%-------Ejemplo introductio 1-----
h=tf(1,[1 2]);
figure
rlocus(h)

%-------Ejemplo introductio 2-----
h=tf(1,conv([1 2],[1 3]));
figure
rlocus(h)

%-----------ejemplo 3---------
den= conv([1 1],[1 8]);
den= conv(den,[1 0]);
h= tf(1,den);
figure
rlocus(h)


    