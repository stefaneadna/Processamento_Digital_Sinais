%% INIT

clc;
close;
clear;

%% ACCUMULATOR SYSTEM

% Input signal (decreasing exponential)

N = 20;        	% Number of samples
n = 0:N-1;     	% Time vector
a = 0.5;     	% Exponential rate
x = a.^n;       % Discrete Signal (from 0 to N-1)

figure,
stem(n,x,'.')

% Output signal

y1 = zeros(1,N);
y1(1) = x(1);
y2 = y1;

for k = 2:N
    y1(k) = sum(x(1:k));
    y2(k) = y2(k-1) + x(k);
end

figure,
stem(n,y1,'.')
hold on
stem(n,y2,'o')

%% MOVING AVERAGE SYSTEM

% Input signal (noisy)

x1 = (1:100) + 5*randn(1,100);
x2 = 100 + 5*randn(1,100);
x = [x1,x2];
x_length = length(x);

% Parameters for moving average

M1 = 2;
M2 = 5;

% Output signal (filtered)

y1 = zeros(1,x_length);
y1(M2+1) = mean(x(1:M2+1+M1));
y2 = y1;

for k = (M2+2):(x_length-M1),
    y1(k) = mean(x(k-M2:k+M1));
    y2(k) = y2(k-1) + (x(k+M1) - x(k-M2-1))/(M2+M1+1);
end

% Figures (just show filtered part of signal)

n = (M2+1):(x_length-M1);

figure, plot(n,x(n),'k');
hold on,
plot(n,y1(n),'r');
plot(n,y2(n),'b.');

%% CONVOLUTION

% Input signal (unit pulse)

N = 10;         % Number of samples
x = ones(1,N);  % Discrete Signal (from 0 to N-1)

figure, stem(0:N-1,x,'.')

% Impulse response (decreasing exponential)

M = 10;         % Number of samples
a = 0.5;        % Exponential rate
h = a.^(0:M-1);	% Discrete Signal (from 0 to M-1)

figure, stem(0:M-1,h,'.')

% Output signal (convolution between x and h)

y = conv(x,h);

figure, stem(0:M+N-2,y,'.')

%% CONVOLUTION x DIFFERENCE EQUATIONS (1)

% Input signal (cosine)

N = 100;                % Number of samples
x = cos(pi/8*(0:N-1));	% Discrete Signal (from 0 to N-1)

figure,plot(x)

% Impulse response (decreasing exponential)

M = 50;             % Number of samples
a = 0.5;            % Exponential rate
h = a.^(0:M-1);     % Discrete Signal (from 0 to M-1)

figure,stem(h,'.')

% Output signal (convolution between x and h)

y1 = conv(x,h);

% Difference equations (decreasing exponential)

B = 1;
A = [1 -a];

% Output signal (filter input signal)

y2 = filter(B,A,x);

% Figures

figure,
plot(y1,'b')
hold on
plot(y2,'r')

%% CONVOLUTION x DIFFERENCE EQUATIONS (2)

% Input signal (cosine)

N = 100;                % Number of samples
x = cos(pi/8*(0:N-1));	% Discrete Signal (from 0 to N-1)

% Impulse response (rectangular pulse)

M = 100;                % Number of samples
h = ones(M,1);          % Discrete Signal (from 0 to M-1)

% Shorter signal

n_samples = min([N,M]);

% Output signal (convolution between x and h)

y1 = conv(x,h);

% Difference equations (unit step)

B = 1;
A = [1 -1];

% Output signal (filter input signal)

y2 = filter(B,A,x);

% Figures

figure,plot(x)

figure,stem(h,'.')

figure,
plot(y1(1:n_samples),'b.')
hold on
plot(y2(1:n_samples),'r')

%% FREQUENCY RESPONSE + IDEAL DELAY

% Input signal

N = 2000;       % Number of samples
w1 = 1*pi/5;    % First signal frequency
w2 = 3*pi/4;    % Second signal frequency
n = 0:N-1;      % Discrete time

x = cos(w1*n) + cos(w2*n);

% Impulse response (ideal delay)

Nd = 5;
h = [zeros(1,Nd),1];

% Output signal (convolution between x and h)

y1 = conv(h,x);

% Figures (in time)

figure,
stem(n,x,'b.')
hold on
stem(1:length(y1),y1,'r.')

% Calculate frequency response

w_x = linspace(-pi,pi,length(x));
fw_x = abs(fftshift(fft(x)));

w_y = linspace(-pi,pi,length(y1));
fw_y = abs(fftshift(fft(y1)));

% Figures (in frequency)

figure,
plot(w_x,fw_x)
hold on
plot(w_y,fw_y)

%% END