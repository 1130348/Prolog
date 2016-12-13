
%Base de Conhecimento
%liga(Cidade1,Cidade2,distancia,meio de transporte)
%1 para Terrestre, 2 para Avioes

liga(amesterdam,brussels,210,1).
liga(amesterdam,paris,501,1).
liga(andorra,ljubljana,1430,1).
liga(andorra,madrid,609,1).
liga(andorra,paris,861,1).
liga(berlin,copenhagen,356,1).
liga(berlin,paris,1048,1).
liga(berlin,prague,351,1).
liga(berlin,tallin,1042,1).
liga(berlin,warsaw,572,1).
liga(bratislava,budapest,200,1).
liga(bratislava,vienna,79,1).
liga(brussels,amesterdam,210,1).
liga(budapest,bratislava,200,1).
liga(copenhagen,berlin,356,1).
liga(copenhagen,oslo,606,1).
liga(copenhagen,stockholm,657,1).
liga(dublin,paris,1083,1).
liga(lisbon,madrid,625,1).
liga(lisbon,porto,313,1).
liga(ljubljana,andorra,1430,1).
liga(ljubljana,vienna,384,1).
liga(ljubljana,zagreb,140,1).
liga(london,paris,464,1).
liga(luxembourg,paris,374,1).
liga(madrid,andorra,609,1).
liga(madrid,lisbon,625,1).
liga(madrid,paris,1276,1).
liga(madrid,porto,561,1).
liga(oslo,copenhagen,606,1).
liga(oslo,stockholm,521,1).
liga(paris,amesterdam,501,1).
liga(paris,andorra,861,1).
liga(paris,berlin,1048,1).
liga(paris,brussels,314,1).
liga(paris,dublin,1083,1).
liga(paris,london,464,1).
liga(paris,luxembourg,374,1).
liga(paris,madrid,1276,1).
liga(paris,rome,1424,1).
liga(paris,vienna,1236,1).
liga(porto,lisbon,313,1).
liga(porto,madrid,561,1).
liga(prague,berlin,351,1).
liga(prague,vienna,309,1).
liga(riga,berlin,351,1).
liga(riga,vilnius,302,1).
liga(rome,paris,1424,1).
liga(tallin,riga,309,1).
liga(vienna,bratislava,79,1).
liga(vienna,ljubljana,384,1).
liga(vienna,paris,1236,1).
liga(vienna,prague,309,1).
liga(vilnius,riga,302,1).
liga(vilnius,warsaw,459,1).
liga(warsaw,vilnius,459,1).
liga(zagreb,ljubljana,140,1).
liga(amesterdam,paris,430,2).
liga(berlim,paris,878,2).
liga(copenhagen,helsinki,884,2).
liga(copenhagen,oslo,484,2).
liga(copenhagen,stockholm,523,2).
liga(dublin,paris,836,2).
liga(helsinki,copenhagen,884,2).
liga(lisbon,madrid,503,2).
liga(london,paris,344,2).
liga(madrid,lisbon,503,2).
liga(madrid,paris,1054,2).
liga(oslo,copenhagen,484,2).
liga(paris,amesterdam,430,2).
liga(paris,berlin,878,2).
liga(paris,dublin,836,2).
liga(paris,london,344,2).
liga(paris,madrid,1054,2).
liga(paris,rome,1107,2).
liga(paris,vienna,1035,2).
liga(rome,paris,1107,2).
liga(stockolm,copenhagen,523,2).
liga(vienna,paris,1035,2).

%Estimativas
cidade(lisbon,5,40).
cidade(porto,15,50).
cidade(paris,45,45).
cidade(madrid,25,60).
cidade(andorra,30,40).
cidade(rome,25,30).
cidade(oslo,50,82.5).
cidade(copenhagen,60,70).
cidade(london,40,65).
cidade(dublin,40,75).
cidade(brussels,45,57.5).
cidade(amesterdam,52.5,62.5).
cidade(berlin,67.5,60).
cidade(luxemburg,57.5,50).
cidade(prague,70,47.5).
cidade(vienna,67.5,35 ).
cidade(ljubljana,55,25 ).
cidade(bratislava,75,35).
cidade( budapest,80,20).
cidade( zagreb,67.5,22.5).
cidade(stockholm,52.5,87.5).
cidade(helsinki,65,85).
cidade(tallin,70,75).
cidade(riga,75,65).
cidade(vilnius,87.5,72.5).
cidade(warsaw,90,50).

%Algoritmos Auxiliares
membro(X,[X|_]).
membro(X,[_|Y]):-membro(X,Y).


%calculo do custo(CidadeOrigem,CidadeDestino,Carga,Custo)
custo(CO,CD,MT,Crg,C):-MT is 1,liga(CO,CD,D,MT), C is Crg * D * 0.01.
custo(CO,CD,MT,Crg,C):-MT is 2,liga(CO,CD,D,MT), C is Crg * D * 0.05.


% Recebe a cidade de origem e destino, a carga,uma variavel para guardar
% o custo do tipo de viagem (terrestre ou de aviao) que e mais barato(C)
% e outra para guardar o meio de transporte (MT)
mais_barato(CO,CD,Crg,C,MT):-liga(CO,CD,_,MT),custo(CO,CD,MT,Crg,C).

estimativa(C1,C2,Est):-cidade(C1,X1,Y1),cidade(C2,X2,Y2),DX is X1 - X2, DY is Y1 - Y2, Est is sqrt(DX * DX + DY * DY).

proximo_no(C1,T,C2,Crg,CustoF,DestF,F/Caux):-mais_barato(C1,C2,Crg,CP,_),\+ member(C2,T),Caux is CustoF + CP, estimativa(C2,DestF,Heu),F is Heu + Caux.

% **********Algoritmo para calcular o mais barato************

menor_percursoh([Percurso|Percursos],Menor,[Percurso|Resto]):-menor_percursoh(Percursos,Menor,Resto),menorh(Menor,Percurso),!.

menor_percursoh([Percurso|Resto],Percurso,Resto).

menorh(c(H1/D1,_),c(H2/D2,_)):-C1 is H1+D1, C2 is H2+D2, C1<C2.

astar1(Percursos,Dest,Percurso,Total,Crg):-menor_percursoh(Percursos,Menor,Restantes),
percursos_seguintes(Menor,Dest,Restantes,Percurso,Total,Crg).

astar_maisbarato(Orig,Dest,Perc,Total,Crg):- estimativa(Orig,Dest,H), F is H + 0, % G = 0
astar1([c(F/0,[Orig])],Dest,P,Total,Crg),reverse(P,Perc).

percursos_seguintes(c(_/Dist,Percurso),Dest,_,Percurso,Dist,_):-
Percurso=[Dest|_].

percursos_seguintes(c(_,[Dest|_]),Dest,Restantes,Percurso,Total,Crg):-!,
astar1(Restantes,Dest,Percurso,Total,Crg).

percursos_seguintes(c(_/Dist,[Ult|T]),Dest,Percursos,Percurso,Total,Crg):-
findall(c(F1/D1,[Z,Ult|T]),proximo_no(Ult,T,Z,Crg,Dist,Dest,F1/D1),Lista),
append(Lista,Percursos,NovosPercursos),
astar1(NovosPercursos,Dest,Percurso,Total,Crg).

%**********************************************************************

