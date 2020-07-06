function BD = GerarBanco
%% Carregar Dados

%Aqui carrego o arquivo que pretendo aleatorizar
%No caso, o arquivo com as porcentagens de microestruturas
load variavel_para_kfold.mat;

% return

%Aqui, estabele�o a quantidade de folds que eu quero
Nfold=5;

%Se eu n�o precisa do numero de fold, coloco NNFOLD=1
NNFOLD=0;

%Caso queira salvar os dados: SV=1
%Caso n�o queira salvar os dados: SV=0
SV=0;

%% Come�o a criar o banco de dados

%No caso da RN para reconhecimento da porcentagem de microestruturas,
%necessito apenas de 1 repeti��o. Ent�o, KK=1

%Obs.: No caso do Fuzzy, necessito de 33 repeti��es. Ent�o KK=33

for KK=1
    
    
    %num2str � uma fun��o que transforma um n�mero em um caractere
    %Assim, num2str(KK) transforma o n�mero 1 em texto "1"
    %strcat � uma fun��o que concatena informa��es de CARACTERES
    %Aqui, concatena BD Contraceptive e 1. Assim, ao compilar o c�digo,
    %voc� pode ver que gerou um arquivo com nome "BDContraceptive1.mat"
    namesv=strcat('BD','microest',num2str(KK)); 
    
    %Data � o nome da vari�vel presente no arquivo "Contraceptive.mat"
    %end retorna o �ltimo valor da matriz, ent�o, a vari�vel classe recebe
    %os valores da �ltima coluna de dados
    %Classe=variavel_kfold(:,end);
    
    %No caso do reconhecimento de microestruturas, n�o  tenho classes,
    %ent�o classe recebe valor 1
    Classe=variavel_para_kfold(:,13); %OK
    
    %cvpartition cria uma reparti��o aleat�ria entre os valores. 
    CVO = cvpartition(Classe,'k',Nfold);
    
    %Cria a c�lula
    BD{1,4}=[]; 
    
    for i=1:Nfold
        
        %Divide dados para treinamento
        trIdx=CVO.training(i);
        
        %Divide dados para teste
        teIdx = CVO.test(i);
        
        %Cria o banco de dados:
        %Indices para treino
        BD{i,1}=variavel_para_kfold(trIdx,:);
        
        %Indices para teste
        BD{i,3}=variavel_para_kfold(teIdx,:);
        
    end
    
    %Aleatorizando Banco de Dados
    for i=1:Nfold
        %Aleatorizando os indices
        A=randperm(size(BD{i,1},1));
        B=randperm(size(BD{i,3},1));
        
        %continuar arrumando daqui
        BD{i,2}=BD{i,1}(A,13); %armazenando saida treino
        BD{i,1}=BD{i,1}(A,1:12);
        BD{i,4}=BD{i,3}(B,13); %armazenando saida teste
        BD{i,3}=BD{i,3}(B,1:12);
       
    end
    
    if NNFOLD==1
        BD(2:Nfold,:)=[];
    end
    
    if SV==1
        save(namesv,'BD');
    end
    
   % clearvars -except str Data KK Nfold SV NNFOLD
    
end