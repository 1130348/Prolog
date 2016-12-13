

%encomenda(idEnc,TempoEntrega,Orig,Dest).
encomenda(a,40,1,3).
encomenda(b,20,1,5).
encomenda(c,87,1,13).
encomenda(d,75,1,8).
encomenda(e,13,1,1).
encomenda(f,60,1,14).
encomenda(g,80,1,8).
encomenda(h,90,1,12).
encomenda(i,124,1,11).

%no(numero,cordX,coordY).
no(1,45,95).
no(2,90,95).
no(3,15,85).
no(4,40,80).
no(5,70,80).
no(6,25,65).
no(7,65,65).
no(8,45,55).
no(9,5,50).
no(10,80,50).
no(11,65,45).
no(12,25,40).
no(13,55,30).
no(14,80,30).

%liga(Orig,Dest,Distancia)
liga(1,1,2).				
liga(2,2,2).
liga(3,3,2).
liga(4,4,2).
liga(5,5,2).
liga(6,6,2).
liga(7,7,2).
liga(8,8,2).
liga(9,9,2).
liga(10,10,2).
liga(11,11,2).
liga(12,12,2).
liga(13,13,2).
liga(14,14,2).
liga(1,2,4).
liga(1,3,4).
liga(1,4,4).
liga(1,5,4).
liga(2,1,4).
liga(2,5,4).
liga(3,1,4).
liga(3,4,2).
liga(3,7,4).
liga(4,1,4).
liga(4,3,2).
liga(4,5,4).
liga(4,6,4).
liga(4,7,4).
liga(4,9,4).
liga(5,2,4).
liga(5,4,4).
liga(5,6,2).
liga(5,1,4).
liga(6,5,2).
liga(6,4,4).
liga(6,9,4).
liga(6,10,4).
liga(7,3,4).
liga(7,4,4).
liga(7,9,4).
liga(7,8,2).
liga(8,7,2).
liga(8,9,4).
liga(8,11,4).
liga(8,13,4).
liga(9,4,4).
liga(9,6,4).
liga(9,7,4).
liga(9,8,4).
liga(9,10,2).
liga(9,11,4).
liga(10,6,4).
liga(10,9,2).
liga(10,11,4).
liga(10,12,2).
liga(11,8,4).
liga(11,9,4).
liga(11,10,4).
liga(11,12,2).
liga(11,13,4).
liga(11,14,4).
liga(12,10,4).
liga(12,11,2).
liga(12,14,4).
liga(13,8,4).
liga(13,11,4).
liga(13,14,2).
liga(14,13,2).
liga(14,11,4).
liga(14,12,4).

%relogio(hora,minuto)
relogio(8,0).

start:-	write('Para o centro de distribuicao 1:'),nl,nl,
		C_Dist=1,
		inicio(C_Dist).

inicio(C_Dist):-findall((IdEnc,Tempo,X,Y),
		encomenda(IdEnc,Tempo,X,Y),LstEncomendas),
		quick_sort(LstEncomendas,LstOrd),
		entrega_encomendas(C_Dist,LstOrd,Perc),
		last(Perc,X),hbf(X,C_Dist,PercBack,_),
		write('Percurso de Regresso:  '),
		write(PercBack),nl,nl.
		

entrega_encomendas(_,[],[]).
entrega_encomendas(NoInit,[(IdEnc,_,_,Dest)|LstEncomendasOrd],Percurso):-
							hbf(NoInit,Dest,Perc,_),
							write('A encomenda '),write(IdEnc),write(' foi entregue.'),nl,
							write('Fez o percurso '),write(Perc),nl,nl,
							entrega_encomendas(Dest,LstEncomendasOrd,Percurso1)
							,append(Perc,Percurso1,Percurso),!.

							

							
quick_sort(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([(Y,H,Orig,Dest)|T],Acc,Sorted):-pivoting(H,T,L1,L2),q_sort(L1,Acc,Sorted1),q_sort(L2,[(Y,H,Orig,Dest)|Sorted1],Sorted),!.

pivoting(_,[],[],[]).
pivoting(H,[(Y,X,Orig,Dest)|T],[(Y,X,Orig,Dest)|L],G):- X>=H,pivoting(H,T,L,G).
pivoting(H,[(Y,X,Orig,Dest)|T],L,[(Y,X,Orig,Dest)|G]):- X<H,pivoting(H,T,L,G).

hbf(Orig,Dest,Perc,Total):-estimativa(Orig,Dest,H), F is H + 0, % G = 0
hbf1([c(F/0,[Orig])],Dest,P,Total),reverse(P,Perc),!.

hbf1(Percursos,Dest,Percurso,Total):-menor_percursoh(Percursos,Menor,Restantes),
percursos_seguintesh(Menor,Dest,Restantes,Percurso,Total).

percursos_seguintesh(c(_/ Dist,Percurso),Dest,_,Percurso,Dist):-Percurso=[Dest|_].

percursos_seguintesh(c(_,[Dest|_]),Dest,Restantes,Percurso,Total):-!,hbf1(Restantes,Dest,Percurso,Total).
percursos_seguintesh(c(_/ Dist,[Ult|T]),Dest,Percursos,Percurso,Total):-findall(c(F1/ D1,[Z,Ult|T]),proximo_noh(Ult,T,Z,Dist,Dest,F1/ D1),Lista),
append(Lista,Percursos,NovosPercursos),hbf1(NovosPercursos,Dest,Percurso,Total). 

menor_percursoh([Percurso|Percursos],Menor,[Percurso|Resto]):-menor_percursoh(Percursos,Menor,Resto),menorh(Menor,Percurso),!.

menor_percursoh([Percurso|Resto],Percurso,Resto).

menorh(c(H1/ D1,_),c(H2/ D2,_)):-C1 is H1+D1, C2 is H2+D2, C1<C2.

proximo_noh(X,T,Y,Dist,Dest,F/ Dist1):-(liga(X,Y,Z);
										liga(Y,X,Z)),\+ member(Y,T),Dist1 is Dist + Z,estimativa(Y,Dest,H), F is H + Dist1.
estimativa(C1,C2,Est):-no(C1,X1,Y1),no(C2,X2,Y2),DX is X1-X2,DY is Y1-Y2,Est is sqrt(DX*DX+DY*DY). 


	


	
	



