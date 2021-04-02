clc;
close;
clear;

%% 1. Carregue o arquivo de áudio chirp.mat, fornecido pelo MATLAB [load]. Este sinal foi
%% obtido utilizando-se uma freqüência de amostragem Fs = 8192Hz. Escute este sinal
%% utilizando a função sound, na freqüência Fs e em outras freqüências (Ex: 2*Fs e 0.5*Fs)

% carregando o sinal;
load chirp.mat;

% ouvindo o sinal
%sound(y);
%sound(y,2*Fs);
%sound(y,Fs/2);

%plotando o sinal
figure;
plot(y);
xlabel('Tempo Discreto');
ylabel('Amplitude do sinal Chirp.mat');


%% 2-) Visualize este sinal no tempo, assim como o módulo (em dB) e a fase de sua
%% Transformada de Fourier. [figure, plot, fft, fftshift, abs, angle, unwrap, linspace].
yw = fftshift(fft(y));% resposta em frequencia
freq = linspace(-pi,pi,length(y));

yw = 20*log10(abs(yw));

figure;
plot(freq, yw);
ylabel('Amplitude em (dB)');
xlabel('Frquencia em rad/s');

%% 3-) Adicione um ruído branco gaussiano de média igual a zero e desvio-padrão igual 1
%% ao sinal de áudio [randn], e visualize este sinal no tempo, assim como o módulo e a
%% fase de sua Transformada de Fourier. Escute este sinal utilizando a função sound, na
%% freqüência Fs.

tempo_vec = (1:length(y))/Fs;
ruido_branco = randn(size(y));

% Adicionando ruido
y_ruido = y + ruido_branco*sqrt(1);

%Ruido + sinal do som
figure;
hold;
plot(tempo_vec, y_ruido);
plot(tempo_vec, y);
xlabel('Tempo em seg');
ylabel('Amplitude em (dB) do sinal com o ruido');

yw_ruido = fftshift(abs(fft(y_ruido)));
yw_ruido_fase = fftshift(fft(y_ruido));
yw_ruido = 20*log10(yw_ruido);

%Ruido + sinal com a transformada de fourier
figure;
hold;
plot(freq, yw_ruido);
plot(freq, yw);
xlabel('Frquencia em rad/s');
ylabel('Amplitude em (dB) do sinal com o ruido');

%sound(y_ruido,Fs);

%% 4-) Parte do ruído inserido no item anterior pode ser cancelado utilizando-se um filtro
%% seletivo em freqüência. Qual o tipo de filtro (PB, PA, PF ou RF) parece ser o mais
%% adequado para este caso? Qual parece ser a freqüência de corte ideal para este caso?



