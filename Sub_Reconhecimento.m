   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%% Variáveis Globais %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 a=[];
 rosto=[];
 varredura = 1:10;
 acertos = 0;
 barcertos=[];
 teste=[];
 final=[];
 
 %Lê todos os rostos e calcula a matriz de acertos
 for iterador = varredura
	inicial = time();
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%% Leitura das Variáveis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 [X Y Z T U V] = fft_load('/home/daniel/UFPB/Sinais/Projeto/orl_faces/', iterador);
 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%% Algorítmo de Varredura %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	for i = 1:40
		for j = 1:360
			%a(j,i) = immse(U(:,:,i),V(:,:,j));
			temp = U(:,:,i)-V(:,:,j);
			a(j,i) = sumsq(temp(:));
		end
	rosto(iterador,i) = floor((find(a(:,i)==min(a(:,i))))/9)+1;
	end
	final(iterador) = time() - inicial;
 end
 %}
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%% Verificação dos Resultados %%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for iterador = varredura
	
	teste(iterador,:) = rosto(iterador,:) == 1:40;
	acertos = acertos + sum(teste(iterador,:)==1);
	barcertos(iterador) = sum(teste(iterador,:)==1);
	%{
	teste(iterador,:,:) = rosto(iterador,:) == 1:40;
	acertos = acertos + sum(teste(iterador,:,:)==1);
	barcertos(iterador) = sum(teste(iterador,:,:)==1);
	%}
 end
 
 %feat = reshape(teste, size(teste,1), size(teste,3)); %não serve de nada
 [h w] = size(teste);
 acertos
 percentual = 100 * acertos/(h*w)
 tempo_total = sum(final)
 figure(1);
 bar(barcertos);
 figure(2);
 bar(final);
 temp = [final, tempo_total]
 save sub_rosto.mat rosto
 save sub_teste.mat teste
 save sub_totais.mat barcertos
 save sub_tempo.mat temp
