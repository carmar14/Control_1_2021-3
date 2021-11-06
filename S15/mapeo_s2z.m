clc
close all
clc

%----------
h=tf(1,[1 1]);
pzmap(h)
grid on

Ts=1/10;
hd=c2d(h,Ts);
figure
pzmap(hd)
grid on

e=0:0.1:1;
wn=0:1:pi/Ts;
s1=zeros(length(wn),length(e));
s2=zeros(length(wn),length(e));
% f1 = figure;
% f2 = figure;
figure
% s1=-e(i)*wn(j)+wn(j)*sqrt(e(i)^2-1);
% s2=-e(i)*wn(j)-wn(j)*sqrt(e(i)^2-1);   
% plot(real(s1(i,:)),imag(s1(i,:)),'k',real(s2(i,:)),imag(s2(i,:)),'r')
%-------line punteada frecuencia natural constante----
%--------linea constante linea solida------
for i=1:length(e)
    for j=1:length(wn)
        s1(i,j)=-e(i)*wn(j)+wn(j)*sqrt(e(i)^2-1);
        s2(i,j)=-e(i)*wn(j)-wn(j)*sqrt(e(i)^2-1);
%         plot(real(s1),imag(s1),'k',real(s2),imag(s2),'r')
%         hold on
    end    
    plot(real(s1(i,:)),imag(s1(i,:)),'k',real(s2(i,:)),imag(s2(i,:)),'r')
    hold on   
    
end

plot(real(s1),imag(s1),'--k',real(s2),imag(s2),'--r')

%title('\omega_n = cte')
figure
% for i=1:length(s1)
z1=exp(s1*Ts);
z2=exp(s2*Ts);
%     [theta1,rho1] = cart2pol(real(s1),imag(s1));
%     [theta2,rho2] = cart2pol(real(s2),imag(s2));
for i=1:length(e)
      
    plot(real(z1(i,:)),imag(z1(i,:)),'k',real(z2(i,:)),imag(z2(i,:)),'r')
    hold on   
    
end
plot(real(z1),imag(z1),'--k',real(z2),imag(z2),'--r')
% hold on
% end
% polarplot(theta1,rho1,'k',theta2,rho2,'r')
% title('\omega_n = cte')

% e=0:0.01:1;
% wn=1;
%
% s1=-e*wn+wn*sqrt(e.^2-1);
% s2=-e*wn-wn*sqrt(e.^2-1);
% figure
% plot(real(s1),imag(s1),'k',real(s2),imag(s2),'r')
%
% z1=exp(s1*Ts);
% z2=exp(s2*Ts);
% figure
% plot(real(z1),imag(z1),'k',real(z2),imag(z2),'r')



% cont=0
% for k=0:pi/100:pi
%     cont=cont+1;
%     Pc=-k+(k*i);
%     Pd=exp(Pc);
%     ZitaX(cont)=real(Pc);
%     ZitaY(cont)=imag(Pc);
%     ZitaDX(cont)=real(Pd);
%     ZitaDY(cont)=imag(Pd);
% end;
% figure
% zgrid
% figure
% plot(ZitaX,ZitaY)
% figure
% plot(ZitaDX,ZitaDY)
% hold on
% plot(ZitaDX,-ZitaDY)