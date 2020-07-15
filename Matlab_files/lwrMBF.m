function Slwrmbf = lwrMBF(x,m1,m2,s)
%Fun��o para calcular Fun��o de pertinencia inferior para o caso de incerteza na m�dia
%media 1 tem que ser menor que a m�dia 2
%x = entrada [1 x P]; m1 = m�dia 1 [1 x P]; m2 = m�dia 2 [1 x P]; s =
%desvio [1 x P]

for P=1:1:size(x,2)
    if x(1,P)<=((m1(1,P)+m2(1,P))/2)
        Slwrmbf(1,P) = exp((-1/2)*(((x(1,P)-m2(1,P))/s(1,P)))^2);
    else
        Slwrmbf(1,P) = exp((-1/2)*(((x(1,P)-m1(1,P))/s(1,P)))^2);
    end
end