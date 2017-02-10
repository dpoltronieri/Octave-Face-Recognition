%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Variáveis Globais %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=[];
rosto=[];
teste=[];
varredura = 1:10;
janela_varre = 2:2:40;
%janela_varre = 10
acertos = 0;
barcertos=[];
historiogram=[];
hist_percentual=[];
inicial = time();

for janela = janela_varre
acertos = 0;
tjanela = time();
%Lê todos os rostos e calcula a matriz de acertos
for iterador = varredura

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%% Leitura das Variáveis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X Y Z T U V] = fft_load('../orl_faces/', iterador, janela);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%% Algorítmo de Varredura %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for i = 1:40
   for j = 1:360
     a(j,i) = immse(U(:,:,i),V(:,:,j));
   end
 rosto(janela,iterador,i) = floor((find(a(:,i)==min(a(:,i))))/9)+1;
 end

end

tjanela_final(janela) = time() - tjanela;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%% Verificação dos Resultados %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for iterador = varredura
 %{
 %teste(janela,iterador,:) = rosto(janela,iterador,:) == 1:40;
 teste(janela,:,:) = rosto(janela,iterador,:) == 1:40;
 acertos(janela) = acertos + sum(teste(janela,iterador,:)==1);
 barcertos(janela,iterador) = sum(teste(janela,iterador,:)==1);
 %}
 temp = reshape(rosto(janela,iterador,:), 1, 40);
 teste(iterador,:) = temp == 1:40; %rosto(janela,iterador,:)
 acertos = acertos + sum(teste(iterador,:)==1);
 barcertos(iterador) = sum(teste(iterador,:)==1);
end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%% Armazenamento dos Resultados %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
historiogram(janela,:) = barcertos;
[w h] = size(teste);
acertos;
percentual = 100 * acertos/(w*h);
hist_percentual(janela) = percentual;

end

[a b] = size(teste);
acertos
percentual = 100 * acertos/(a*b)

tempo_total = sum(tjanela_final);
tempo_temp = [tjanela_final, tempo_total];

save tempo.mat tempo_temp
save rosto.mat rosto
save teste.mat teste
save historiograma.mat historiogram
save percentual.mat hist_percentual

figure(1)
mesh(historiogram);
figure(2)
bar(hist_percentual);
figure(3)
bar(tjanela_final);
figure(4)
bar(barcertos);
