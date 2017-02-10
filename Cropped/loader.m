
%Lê os arquivos da pasta
X = read_images('../orl_faces/',10);
Y = test_read_images('../orl_faces/',1,10);
Z = learn_read_images('../orl_faces/',1,10);
%X = vetor de imagens

[h,w,n] = size(X);
%Número de imagens
%Dimensionalidade

T = mass_fft(X);
U = mass_fft(Y);
V = mass_fft(Z);
