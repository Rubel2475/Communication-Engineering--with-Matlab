clc
clear all
close all

data = [1 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0];

sample_per_bit = 100;
bitRate = 1;
total_bits = length(data);
total_sample_size = total_bits*sample_per_bit;
total_sample_time = total_bits/bitRate;
time_per_sample = total_sample_time/total_sample_size;
t = 0:time_per_sample:total_sample_time;
y = zeros(1,length(t));

previous = -1;
count = 0;
pre_non_zero = 0;

for i = 1:total_bits
  if data(i) == 0
    count = count+1;
    if count==4
      if (mod(pre_non_zero,2))!=0  %number of non-zero after last substitution-- odd
        y((i-4)*sample_per_bit+1 : (i-3)*sample_per_bit)=0;
        y((i-3)*sample_per_bit+1 : (i-2)*sample_per_bit)=0;
        y((i-2)*sample_per_bit+1 : (i-1)*sample_per_bit)=0;
        y((i-1)*sample_per_bit+1 : i*sample_per_bit)=previous;
       else
        y((i-4)*sample_per_bit+1 : (i-3)*sample_per_bit)=-previous;
        previous=-previous;
        y((i-3)*sample_per_bit+1 : (i-2)*sample_per_bit)=0;
        y((i-2)*sample_per_bit+1 : (i-1)*sample_per_bit)=0;
        y((i-1)*sample_per_bit+1 : i*sample_per_bit)=previous;
       endif;
      count=0;
      pre_non_zero=0;
    endif
  else
    count=0;
    y((i-1)*sample_per_bit+1 : i*sample_per_bit) = -previous;
    previous = -previous;
    pre_non_zero = pre_non_zero+1;
  endif
endfor

plot(t,y,'Linewidth',2);
axis([0 t(end) -2 2]);
grid on;
xlabel('time');
ylabel('Amplitude');
title('HDB3 Encoding');

%decoding of B8ZS


pre = -1;
count = 0;
for j=1:total_sample_size
  if t(j)>count
    count = count+1;
    if y(j) == pre
      decoded_data(count-3:count)=0;
    else
      if y(j) == 0
        decoded_data(count)=0;
      else
        decoded_data(count)=1;
        pre = -pre;
      endif
    endif
  endif
endfor;
disp('Decoded HDB3');
disp(decoded_data);

