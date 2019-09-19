clc
clear all
close all

data = [0 1 0 0 1 0];

sample_per_bit = 100;
bitRate = 1;
total_bits = length(data);
total_sample_size = total_bits*sample_per_bit;
total_sample_time = total_bits/bitRate;
time_per_sample = total_sample_time/total_sample_size;
t = 0:time_per_sample:total_sample_time;
y = zeros(1,length(t));

previous = -1;

for i=0:total_bits-1;
  if data(i+1) == 1
    if previous == -1
      y(i*sample_per_bit+1 : (i+1)*sample_per_bit) = 1;
      previous = 1;
    else
      y(i*sample_per_bit+1 : (i+1)*sample_per_bit) = -1;
      previous = -1;
    endif;
  endif;
endfor;

plot(t,y,'Linewidth',2);
axis([0 t(end) -2 2]);
grid on;
xlabel('time');
ylabel('Amplitude');
title('Bipolar AMI');


%decoding of AMI
pre = -1;
count = 0;
for j=1:sample_per_bit:total_sample_size
  count = count+1;
  if y(j) == -pre;
    decoded_data(count)=1;
    pre = -pre;
  else
    decoded_data(count)=0;
  endif
endfor
disp('decoded AMI data: ');
disp(decoded_data);


