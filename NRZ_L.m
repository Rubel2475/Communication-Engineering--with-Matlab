clc
clear all
close all

data = [1 0 1 1 1 0 1];

sample_per_bit = 100;
bitRate = 1;
total_bits = length(data);
total_sample_size = sample_per_bit * total_bits;
total_sample_time = total_bits / bitRate;
time_per_sample = total_sample_time / total_sample_size;
t = 0:time_per_sample:total_sample_time; 
y = zeros(1,length(t));

for i=0:total_bits-1;
  if data(i+1) == 0 
    y(i*sample_per_bit+1 : (i+1)*sample_per_bit) = 1;
  else 
    y(i*sample_per_bit+1 : (i+1)*sample_per_bit) = -1;  
  endif
endfor

plot(t,y,'g','Linewidth',2);
axis([0 t(end) -3 3]);
grid on;
xlabel('time');
ylabel('Amplitude');
title('Polar NRZ-L');

%decoding the digital signal 
check = 1;
count = 0;
for j = 1:sample_per_bit:length(y)-1;
  count = count+1;
  if y(j)==check
    signal_decoded(count) = 0;
  else
    %count = count+1;
    signal_decoded(count) = 1;
  endif;
endfor;
disp(signal_decoded);


