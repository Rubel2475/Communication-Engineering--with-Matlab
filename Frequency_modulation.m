clc
clear all
close all

%{
Am = input('Amplitude of message signal: ');
Ac = input('Amplitude of carrier signal: ');
fm = input('Frequency of message signal: ');
fc = input('Frequency of carrier signal: ');

while fm>fc 
  disp('Invalid message signal');
  fm = input('Frequency of message signal: ');
endwhile
T = input('time period: ');
%}
Am=1;
Ac=1;
fm=2;
fc=4;
T=4;

t = 0:0.001:T;

Ym = Am*sin(2*pi*fm*t);
subplot(3,1,1);
plot(t,Ym);
title('message signal'); 

Yc = Ac*sin(2*pi*fc*t);
subplot(3,1,2);
plot(t,Yc,'k');
title('carrier signal');

Z = Ac*sin(2*pi*fc*t + ((Am/Ac)*(2*pi*fm*t)));
subplot(3,1,3);
plot(t,Z,'g');
title('Modulated signal');