%% Nome: Stefane Adna dos Santos
%% Matricula: 403249
%% Processamento Digital de Sinais

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
title ('Questão 01');
xlabel('Tempo Discreto');
ylabel('Amplitude do sinal Chirp.mat');


%% 2-) Visualize este sinal no tempo, assim como o módulo (em dB) e a fase de sua
%% Transformada de Fourier. [figure, plot, fft, fftshift, abs, angle, unwrap, linspace].
yw = fftshift(fft(y));
freq = linspace(-pi,pi,length(y));

yw = 20*log10(abs(yw));

figure;
plot(freq, yw);
title ('Questão 02');
ylabel('Amplitude em (dB)');
xlabel('Frquencia em rad/s');

%% 3-) Adicione um ruído branco gaussiano de média igual a zero e desvio-padrão igual 1
%% ao sinal de áudio [randn], e visualize este sinal no tempo, assim como o módulo e a
%% fase de sua Transformada de Fourier. Escute este sinal utilizando a função sound, na
%% freqüência Fs.

tempo_vec = (1:length(y))/Fs;
ruido_branco = wgn(13129,1,randn*sqrt(0.1),0.01);


% Adicionando ruido
y_ruido = y + ruido_branco;

%Ruido + sinal do som
figure;
hold;
plot(tempo_vec, y_ruido);
plot(tempo_vec, y);
title ('Questão 03, parte 01');
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
title ('Questão 03, parte 02');
xlabel('Frquencia em rad/s');
ylabel('Amplitude em (dB) do sinal com o ruido');

%sound(y_ruido,Fs);

%% 4-) Parte do ruído inserido no item anterior pode ser cancelado utilizando-se um filtro
%% seletivo em freqüência. Qual o tipo de filtro (PB, PA, PF ou RF) parece ser o mais
%% adequado para este caso? Qual parece ser a freqüência de corte ideal para este caso?

%Filtro PB com wc = 3200/(Fs/2)

%% 5-) Utilizando a função butter, obtenha os coeficientes do filtro sugerido no item 4.
%% Visualize a resposta em fase e a resposta em magnitude deste filtro. Se necessário,
%% repita a operação até encontrar o filtro que lhe pareça o mais adequado possível. [freqz,
%% abs, angle, unwrap]

wc = 3200/(Fs/2);
[b,a] = butter(10,wc);
[h,w] = freqz(b,a);

figure;
plot(w,abs(unwrap(angle(h))));
title ('Questão 05, parte 01');
figure;
plot(w,unwrap(abs(h)));
title ('Questão 05, parte 02');

figure;
impz(b,a);

%% 6-) Trace os diagramas de zeros e pólos do filtro utilizado no item 5 [zplane]. Quais
%% informações relevantes podem ser tiradas a partir deste gráfico?

figure;
zplane(b,a);
title ('Questão 06');

%% 7-) Repita os itens 5 e 6 usando a função fvtool

fvtool(w,h);
fvtool(b,a);

%%8-) Filtre o sinal de áudio ruidoso com o filtro obtido no item 5 [filter]. Visualize este sinal
%% no tempo, assim como o módulo e a fase de sua Transformadas de Fourier.

y_f = filter(b,a,y_ruido); %sinal filtrado
figure;
plot(real(y_f));
title ('Questão 08, parte 01');
xlabel('Tempo Discreto');
ylabel('Amplitude do sinal que foi filtrado');

yw_f = abs(fftshift(fft(y_f)));
freq_vec = linspace(-pi,pi,length(yw_f));
figure;
plot(freq_vec,yw_f);
title ('Questão 08, parte 02');
xlabel('Frquencia em rad/s');
ylabel('Espectro de magnitude do sinal que foi filtrado'); 

yw_fase = fftshift(fft(y_f));
figure;
plot(freq_vec,unwrap(angle(yw_fase)));
title ('Questão 08, parte 03');
xlabel('Frquencia em rad/s');
ylabel('Resposta em fase do sinal que foi filtrado');

%% 9-) Escute o sinal filtrado utilizando a função sound, na freqüência Fs. O que é
%% observado?
%sound(y_f,Fs);
% Pode-se ouvir o canto do passaro e um leve som de ruido no fundo